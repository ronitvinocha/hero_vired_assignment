import 'dart:convert';
import 'dart:developer';
import 'dart:math' as Math;

import 'package:bloc/bloc.dart';
import 'package:hero_vired/bl/model/authmodel/creatuserresponse.dart';
import 'package:hero_vired/bl/model/authmodel/usertokenwrapper.dart';
import 'package:hero_vired/bl/model/errormodel/generalerrorresponse.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:hero_vired/bl/glitch/glitch.dart';
import 'package:hero_vired/bl/model/authmodel/newuserresponse.dart';
import 'package:hero_vired/bl/model/authmodel/olduserresponse.dart';
import 'package:hero_vired/bl/model/authmodel/usertoken.dart';
import 'package:hero_vired/bl/model/errormodel/errorresponse.dart';
import 'package:hero_vired/bl/network/apiclient.dart';

abstract class AuthEvent {}

class GetOTP extends AuthEvent {}

class VerifyOTP extends AuthEvent {
  String otp;
  String phone;
  VerifyOTP({required this.otp, required this.phone});
}

class CreateUser extends AuthEvent {
  String fname;
  String lname;
  String email;
  CreateUser({
    required this.fname,
    required this.lname,
    required this.email,
  });
}

abstract class AuthState {}

class GetOTPSuccess extends AuthState {}

class InitialState extends AuthState {}

class VerifyOtpfailure extends AuthState {
  Glitch glitch;
  VerifyOtpfailure({
    required this.glitch,
  });
}

class NewUser extends AuthState {}

class OldUser extends AuthState {
  User user;
  OldUser({
    required this.user,
  });
}

class CreateUserFailure extends AuthState {
  Glitch glitch;
  CreateUserFailure({
    required this.glitch,
  });
}

class CreateUserSuccess extends AuthState {}

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  ApiClient apiClient;
  AuthBloc({required this.apiClient}) : super(InitialState()) {
    on<GetOTP>(_getOTP);
    on<VerifyOTP>(_verifyOTP);
    on<CreateUser>(_createUser);
  }

  _getOTP(GetOTP event, Emitter<AuthState> emit) async {
    await Future.delayed(const Duration(seconds: 2));
    emit(GetOTPSuccess());
  }

  _verifyOTP(VerifyOTP event, Emitter<AuthState> emit) async {
    var response = await apiClient.networkCall(
        "beta.herovired.com",
        "GET",
        "/local/signin/signin_api.php",
        {"phone": event.phone, "otp": event.otp, "type": "verify"});
    await response.fold((l) async => emit(VerifyOtpfailure(glitch: l)),
        (r) async {
      if (r.contains("error")) {
        var error = ErrorResponse.fromJson(r);
        emit(VerifyOtpfailure(glitch: Glitch(message: error.msg)));
      } else if (r.contains("existing")) {
        var oldUserResponse = UserResponse.fromJson(r);
        var userToken =
            UserToken.fromJson(oldUserResponse.userTokenLocalMobile!);
        emit(OldUser(user: oldUserResponse.user));
        SharedPreferences.getInstance().then((value) async {
          await value.setString("userToken", userToken.token);
          await value.setString("userid", oldUserResponse.user.id);
          await value.setString("userName", oldUserResponse.user.username);
        });
      } else if (r.contains("new")) {
        var newUserResponse = NewUserResponse.fromJson(r);
        log(newUserResponse.toString());
        emit(NewUser());
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        await sharedPreferences.setString("leadId", newUserResponse.leadid);
        await sharedPreferences.setString(
            "wsToken", newUserResponse.admin_token);
        await sharedPreferences.setString("phone", event.phone);
      }
    });
  }

  _createUser(CreateUser event, Emitter<AuthState> emit) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var wsToken = sharedPreferences.getString("wsToken");
    var phone = sharedPreferences.getString("phone");
    var response = await apiClient.networkCall(
        "beta.herovired.com", "GET", "/webservice/rest/server.php", {
      "wstoken": wsToken!,
      "wsfunction": "core_user_create_users",
      "moodlewsrestformat": "json",
      "users[0][firstname]": event.fname,
      "users[0][lastname]": event.lname,
      "users[0][email]": event.email,
      "users[0][password]": "test${Math.Random().nextInt(100000)}",
      "users[0][username]": "test_${Math.Random().nextInt(100000)}",
      "users[0][phone1]": phone!
    });
    await response.fold((l) async => emit(CreateUserFailure(glitch: l)),
        (r) async {
      if (r.contains("exception")) {
        var error = GeneralError.fromJson(r);
        emit(CreateUserFailure(glitch: Glitch(message: error.message)));
      } else {
        Iterable l = json.decode(r);
        List<CreateUserResponse> listUser = List<CreateUserResponse>.from(
            l.map((model) => CreateUserResponse.fromMap(model)));
        // emit(CreateUserSuccess());
        await sharedPreferences.setString("userid", listUser[0].id.toString());
        await sharedPreferences.setString("userName", listUser[0].username);
        var leadId = sharedPreferences.getString("leadId");
        var usertokenresponse = await apiClient.networkCall(
            "beta.herovired.com", "GET", "/local/signin/signin_api.php", {
          "userid": listUser[0].id.toString(),
          "username": listUser[0].username,
          "leadid": leadId!,
          "type": "usertoken",
          "service": "local_mobile",
          "fname": event.fname,
          "lname": event.lname,
          "email": event.email
        });
        await usertokenresponse
            .fold((l) async => emit(CreateUserFailure(glitch: l)), (r) async {
          var userTokenwrapper = UserTokenWrapper.fromJson(r);
          await sharedPreferences.setString("userToken",
              UserToken.fromJson(userTokenwrapper.user_token).token);
          emit(CreateUserSuccess());
        });
      }
    });
  }
}
