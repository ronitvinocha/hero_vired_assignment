import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hero_vired/bl/blocs/authblock.dart';
import 'package:hero_vired/bl/blocs/homepagebloc.dart';
import 'package:hero_vired/bl/network/apiclient.dart';
import 'package:hero_vired/ui/pages/homepage.dart';
import 'package:hero_vired/ui/widgets/linearloader.dart';

import '../../utilfunctions.dart';

class SignUpPage extends StatefulWidget {
  final AuthBloc authBloc;
  const SignUpPage({Key? key, required this.authBloc}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> with TickerProviderStateMixin {
  TextEditingController fnController = TextEditingController();
  TextEditingController lnController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  bool isFormEnabled = true;
  final _formKey = GlobalKey<FormState>();
  bool isTermsAccepted = false;
  late final StreamSubscription authBlocSubscription;
  GlobalKey<LinearLoaderState> loaderkey = GlobalKey();

  bool isButtonEnabled() {
    if (isTermsAccepted) {
      if (_formKey.currentState != null && _formKey.currentState!.validate()) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
    authBlocSubscription = widget.authBloc.stream.listen((event) {
      if (event is CreateUserFailure) {
        final snackBar = SnackBar(
            backgroundColor: Colors.red.shade400,
            duration: const Duration(seconds: 2),
            content: Text(
              event.glitch.message,
              style: Theme.of(context)
                  .textTheme
                  .headline2!
                  .merge(const TextStyle(color: Colors.white, fontSize: 14)),
            ));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        loaderkey.currentState!.stopLoader();
        setState(() {
          isFormEnabled = true;
        });
      } else if (event is CreateUserSuccess) {
        loaderkey.currentState!.stopLoader();
        Navigator.of(context).pushAndRemoveUntil(
            getGenericeRouteWithSideTransition(BlocProvider(
                create: (_) => HomePageBloc(apiClient: ApiClient()),
                child: const HomePage())),
            (route) => false);
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
    final node = FocusScope.of(context);
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Theme.of(context).backgroundColor,
          body: SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LinearLoader(
                key: loaderkey,
              ),
              IconButton(
                  onPressed: () {
                    loaderkey.currentState!.stopLoader();
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.black87,
                  )),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Tell us about you",
                      textAlign: TextAlign.start,
                      style: Theme.of(context)
                          .textTheme
                          .headline1!
                          .merge(const TextStyle(color: Colors.black87)),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            controller: fnController,
                            enabled: isFormEnabled,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            onEditingComplete: () => node.nextFocus(),
                            validator: (text) {
                              if (text != null && text.length < 3) {
                                return "First name should be more than 2 character length";
                              }
                              return null;
                            },
                            onChanged: (value) {
                              setState(() {});
                            },
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              label: RichText(
                                text: TextSpan(children: [
                                  TextSpan(
                                      text: "First name ",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .merge(const TextStyle(
                                              color: Colors.black87))),
                                  TextSpan(
                                      text: "*",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .merge(const TextStyle(
                                              color: Colors.red)))
                                ]),
                              ),
                              hintText: 'Please enter first name',
                              hintStyle: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .merge(const TextStyle(color: Colors.grey)),
                              border: const OutlineInputBorder(),
                              focusedBorder: const OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          TextFormField(
                            controller: lnController,
                            enabled: isFormEnabled,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            onEditingComplete: () => node.nextFocus(),
                            validator: (text) {
                              if (text != null && text.length < 3) {
                                return "Last name should be more than 2 character length";
                              }
                              return null;
                            },
                            onChanged: (value) {
                              setState(() {});
                            },
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              label: RichText(
                                text: TextSpan(children: [
                                  TextSpan(
                                      text: "Last name ",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .merge(const TextStyle(
                                              color: Colors.black87))),
                                  TextSpan(
                                      text: "*",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .merge(const TextStyle(
                                              color: Colors.red)))
                                ]),
                              ),
                              hintText: 'Please enter last name',
                              hintStyle: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .merge(const TextStyle(color: Colors.grey)),
                              border: const OutlineInputBorder(),
                              focusedBorder: const OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          TextFormField(
                            controller: emailController,
                            enabled: isFormEnabled,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (text) {
                              if (!isValidEmail(text)) {
                                return 'Enter a valid email ID';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              setState(() {});
                            },
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              label: RichText(
                                text: TextSpan(children: [
                                  TextSpan(
                                      text: "Email address ",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .merge(const TextStyle(
                                              color: Colors.black87))),
                                  TextSpan(
                                      text: "*",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .merge(const TextStyle(
                                              color: Colors.red)))
                                ]),
                              ),
                              hintText: 'Please enter your Email ID',
                              hintStyle: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .merge(const TextStyle(color: Colors.grey)),
                              border: const OutlineInputBorder(),
                              focusedBorder: const OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            children: [
                              IconButton(
                                  splashRadius: 25,
                                  splashColor: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(0.2),
                                  iconSize: 24,
                                  onPressed: () {
                                    if (isFormEnabled) {
                                      setState(() {
                                        isTermsAccepted = !isTermsAccepted;
                                      });
                                    }
                                  },
                                  icon: Container(
                                    height: 30,
                                    width: 30,
                                    decoration: BoxDecoration(
                                        border:
                                            Border.all(color: Colors.black87),
                                        borderRadius: BorderRadius.circular(4)),
                                    child: isTermsAccepted
                                        ? Icon(
                                            Icons.check,
                                            color:
                                                Theme.of(context).primaryColor,
                                          )
                                        : Container(),
                                  )),
                              Flexible(
                                  child: RichText(
                                text: TextSpan(children: [
                                  TextSpan(
                                      text: "I've read and accept the ",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .merge(const TextStyle(
                                              color: Colors.black87,
                                              fontSize: 14))),
                                  TextSpan(
                                      text: "terms and conditions*",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .merge(TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              fontSize: 14)))
                                ]),
                              ))
                            ],
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
                                      getButtonColor(
                                          isButtonEnabled(), context)),
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0))),
                                ),
                                onPressed: () {
                                  if (isFormEnabled && isButtonEnabled()) {
                                    loaderkey.currentState!.startLoader();
                                    setState(() {
                                      isFormEnabled = false;
                                    });
                                    widget.authBloc.add(CreateUser(
                                        fname: fnController.text,
                                        lname: lnController.text,
                                        email: emailController.text));
                                  }
                                },
                                child: Text(
                                  "Next",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline3!
                                      .merge(
                                          const TextStyle(color: Colors.white)),
                                )),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ))),
    );
  }
}
