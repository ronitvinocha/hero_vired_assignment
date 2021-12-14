import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hero_vired/bl/blocs/authblock.dart';
import 'package:hero_vired/bl/blocs/homepagebloc.dart';
import 'package:hero_vired/bl/glitch/glitch.dart';
import 'package:hero_vired/bl/network/apiclient.dart';
import 'package:hero_vired/ui/pages/homepage.dart';
import 'package:hero_vired/ui/pages/signuppage.dart';
import 'package:hero_vired/ui/widgets/linearloader.dart';

import '../../utilfunctions.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  bool isPhoneEnabled = true;
  bool isOTPEnabled = true;
  bool isPhoneNumberButtonEnabaled = false;
  bool isOTPNumberButtonEnabaled = false;
  String? otperrortext;
  late final AuthBloc authBloc;
  GlobalKey<LinearLoaderState> loaderKey = GlobalKey();
  late final TextEditingController phoneEditingController =
      TextEditingController(text: "");
  late final TextEditingController otpEditingController =
      TextEditingController(text: "");
  final PageController _pageController = PageController(initialPage: 0);
  late final StreamSubscription authBlocSubscription;

  @override
  void initState() {
    super.initState();
    authBloc = BlocProvider.of<AuthBloc>(context);
    authBlocSubscription = authBloc.stream.listen((event) {
      if (event is GetOTPSuccess) {
        loaderKey.currentState!.stopLoader();
        _pageController.animateToPage(1,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut);
      } else if (event is VerifyOtpfailure) {
        loaderKey.currentState!.stopLoader();
        setState(() {
          isOTPEnabled = true;
          isOTPNumberButtonEnabaled = true;
          otperrortext = event.glitch.message;
        });
      } else if (event is NewUser) {
        _pageController.animateToPage(0,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut);
        loaderKey.currentState!.stopLoader();
        setState(() {
          isPhoneEnabled = true;
          isPhoneNumberButtonEnabaled = true;
          isOTPNumberButtonEnabaled = true;
          isOTPEnabled = true;
          otpEditingController.clear();
        });
        Navigator.of(context)
            .push(getGenericeRouteWithSideTransition(SignUpPage(
          authBloc: authBloc,
        )));
      } else if (event is OldUser) {
        loaderKey.currentState!.stopLoader();
        Navigator.of(context).pushReplacement(
            (getGenericeRouteWithSideTransition(BlocProvider(
                create: (_) => HomePageBloc(apiClient: ApiClient()),
                child: const HomePage()))));
      }
    });
  }

  @override
  void dispose() {
    authBlocSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: Container(
          color: Theme.of(context).backgroundColor,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              LinearLoader(
                key: loaderKey,
              ),
              Expanded(
                  child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [phoneInputPage(), otpInputPage()],
              ))
            ],
          ),
        ),
      ),
    );
  }

  Widget otpInputPage() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 100,
            ),
            Text(
              "OTP sent!",
              textAlign: TextAlign.start,
              style: Theme.of(context)
                  .textTheme
                  .headline1!
                  .merge(const TextStyle(color: Colors.black87)),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text(
                  phoneEditingController.text,
                  textAlign: TextAlign.start,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .merge(const TextStyle(color: Colors.black54)),
                ),
                IconButton(
                    iconSize: 20,
                    onPressed: () {
                      setState(() {
                        isPhoneEnabled = true;
                        isPhoneNumberButtonEnabaled = true;
                        otpEditingController.clear();
                      });
                      _pageController.animateToPage(0,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut);
                    },
                    icon: Icon(
                      Icons.edit,
                      color: Theme.of(context).primaryColor,
                    )),
                const SizedBox(
                  height: 60,
                ),
              ],
            ),
            TextFormField(
              controller: otpEditingController,
              enabled: isOTPEnabled,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (text) {
                if (!isValidOTP(text)) {
                  return 'Enter a valid 6 digit otp';
                }
                return null;
              },
              onChanged: (text) {
                setState(() {
                  isOTPNumberButtonEnabaled = text.length == 6;
                });
              },
              keyboardType: TextInputType.phone,
              maxLength: 6,
              decoration: InputDecoration(
                labelText: 'OTP',
                errorText: otperrortext,
                labelStyle: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .merge(const TextStyle(color: Colors.black87)),
                hintText:
                    'Enter the OTP send to ${phoneEditingController.text}',
                hintStyle: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .merge(const TextStyle(color: Colors.grey)),
                border: const OutlineInputBorder(),
                focusedBorder: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: TextButton(
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(vertical: 10)),
                    backgroundColor: MaterialStateProperty.all(
                        getButtonColor(isOTPNumberButtonEnabaled, context)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0))),
                  ),
                  onPressed: () {
                    if (isOTPNumberButtonEnabaled) {
                      setState(() {
                        isOTPNumberButtonEnabaled = false;
                        isOTPEnabled = false;
                      });
                      loaderKey.currentState!.startLoader();
                      authBloc.add(VerifyOTP(
                          otp: otpEditingController.text,
                          phone: phoneEditingController.text));
                    }
                  },
                  child: Text(
                    "Verify",
                    style: Theme.of(context)
                        .textTheme
                        .headline3!
                        .merge(const TextStyle(color: Colors.white)),
                  )),
            )
          ],
        ));
  }

  Widget phoneInputPage() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 100,
          ),
          Text(
            "Continue with phone",
            textAlign: TextAlign.start,
            style: Theme.of(context)
                .textTheme
                .headline1!
                .merge(const TextStyle(color: Colors.black87)),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            "You'll recieve 6 digit code to verify next",
            textAlign: TextAlign.start,
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .merge(const TextStyle(color: Colors.black54)),
          ),
          const SizedBox(
            height: 40,
          ),
          TextFormField(
            controller: phoneEditingController,
            enabled: isPhoneEnabled,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (text) {
              if (!isValidPhoneNumber(text)) {
                return 'Enter a valid phone number';
              }
              return null;
            },
            onChanged: (text) {
              setState(() {
                isPhoneNumberButtonEnabaled = isValidPhoneNumber(text);
              });
            },
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              labelText: 'Mobile number',
              labelStyle: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .merge(const TextStyle(color: Colors.black87)),
              hintText: 'Enter mobile number here',
              hintStyle: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .merge(const TextStyle(color: Colors.grey)),
              border: const OutlineInputBorder(),
              focusedBorder: const OutlineInputBorder(),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: TextButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(vertical: 10)),
                  backgroundColor: MaterialStateProperty.all(
                      getButtonColor(isPhoneNumberButtonEnabaled, context)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0))),
                ),
                onPressed: () {
                  if (isPhoneNumberButtonEnabaled) {
                    setState(() {
                      isPhoneNumberButtonEnabaled = false;
                      isPhoneEnabled = false;
                    });
                    loaderKey.currentState!.startLoader();
                    authBloc.add(GetOTP());
                  }
                },
                child: Text(
                  "Next",
                  style: Theme.of(context)
                      .textTheme
                      .headline3!
                      .merge(const TextStyle(color: Colors.white)),
                )),
          )
        ],
      ),
    );
  }
}
