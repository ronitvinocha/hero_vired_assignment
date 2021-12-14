import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:hero_vired/bl/model/homepagemodel/coursedataresponse.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:hero_vired/bl/glitch/glitch.dart';
import 'package:hero_vired/bl/model/homepagemodel/coursesresponse.dart';
import 'package:hero_vired/bl/model/errormodel/generalerrorresponse.dart';
import 'package:hero_vired/bl/network/apiclient.dart';

abstract class HomepageEvent {}

class GetCourses extends HomepageEvent {}

class GetCourseData extends HomepageEvent {
  int courseId;
  GetCourseData({
    required this.courseId,
  });
}

abstract class HomepageState {}

class GetCoursesFailure extends HomepageState {
  Glitch glitch;
  GetCoursesFailure({
    required this.glitch,
  });
}

class InitialState extends HomepageState {}

class HomePageBloc extends Bloc<HomepageEvent, HomepageState> {
  final StreamController<List<Coursedata>> _getCourseController =
      BehaviorSubject();
  Stream<List<Coursedata>> get getCoursesStream => _getCourseController.stream;
  final StreamController<List<CoursesDataResponse>> _getCourseDateController =
      BehaviorSubject();
  Stream<List<CoursesDataResponse>> get getCoursesDataStream =>
      _getCourseDateController.stream;
  ApiClient apiClient;
  HomePageBloc({required this.apiClient}) : super(InitialState()) {
    on<GetCourses>(_getCourses);
    on<GetCourseData>(_getCourseData);
  }

  _getCourses(GetCourses event, Emitter<HomepageState> emit) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var userToken = sharedPreferences.getString("userToken");
    var userid = sharedPreferences.getString("userid");
    var response = await apiClient.networkCall(
        "beta.herovired.com", "GET", "/webservice/rest/server.php", {
      "wstoken": userToken!,
      "wsfunction": "block_courses_get_courses",
      "moodlewsrestformat": "json",
      "start": "0",
      "limit": "10",
      "userid": userid!.toString()
    });
    await response.fold((l) async => emit(GetCoursesFailure(glitch: l)),
        (r) async {
      if (r.contains("exception")) {
        var exception = GeneralError.fromJson(r);
        emit(GetCoursesFailure(glitch: Glitch(message: exception.message)));
        _getCourseController.add([]);
      } else {
        var coursesResponse = CoursesResponse.fromJson(r);
        _getCourseController.add(coursesResponse.coursedata);
      }
    });
  }

  _getCourseData(GetCourseData event, Emitter<HomepageState> emit) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var userToken = sharedPreferences.getString("userToken");
    var response = await apiClient.networkCall(
        "beta.herovired.com", "GET", "/webservice/rest/server.php", {
      "wstoken": userToken!,
      "wsfunction": "core_course_get_contents",
      "moodlewsrestformat": "json",
      "courseid": event.courseId.toString()
    });
    await response.fold((l) async => emit(GetCoursesFailure(glitch: l)),
        (r) async {
      if (r.contains("exception")) {
        var exception = GeneralError.fromJson(r);
        emit(GetCoursesFailure(glitch: Glitch(message: exception.message)));
        _getCourseDateController.add([]);
      } else {
        Iterable l = json.decode(r);
        List<CoursesDataResponse> courseschapters =
            List<CoursesDataResponse>.from(
                l.map((model) => CoursesDataResponse.fromMap(model)));

        _getCourseDateController.add(courseschapters);
      }
    });
  }
}
