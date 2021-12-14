import 'package:flutter/material.dart';
import 'package:hero_vired/bl/blocs/homepagebloc.dart';
import 'package:hero_vired/bl/model/homepagemodel/coursesresponse.dart';
import 'package:hero_vired/ui/pages/coursepage.dart';
import 'package:hero_vired/ui/widgets/courseloader.dart';
import 'package:hero_vired/utilfunctions.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class CourseList extends StatefulWidget {
  final HomePageBloc bloc;
  const CourseList({Key? key, required this.bloc}) : super(key: key);

  @override
  _CourseListState createState() => _CourseListState();
}

class _CourseListState extends State<CourseList> {
  @override
  void initState() {
    super.initState();
    widget.bloc.add(GetCourses());
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height - 150,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: Text("Courses & assesment",
                style: Theme.of(context).textTheme.headline2!.merge(
                    const TextStyle(fontSize: 17, color: Colors.black87))),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
              child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 5,
                ),
                Center(
                  child: Container(
                    width: 50,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 16),
                  child: Text(
                    "Learn Now",
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                    child: StreamBuilder(
                  builder: (ctx, snap) {
                    if (snap.connectionState == ConnectionState.waiting) {
                      return const CourseLoader();
                    } else {
                      if (snap.hasData) {
                        List<Coursedata> courses =
                            snap.data as List<Coursedata>;
                        return courses.isNotEmpty
                            ? ListView.builder(
                                itemCount: courses.length,
                                itemBuilder: (ctx, index) {
                                  return Container(
                                    padding: const EdgeInsets.only(
                                      left: 16.0,
                                    ),
                                    margin: const EdgeInsets.only(top: 10),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                courses[index].coursename,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1!
                                                    .merge(const TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.black87)),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                      child:
                                                          LinearPercentIndicator(
                                                    backgroundColor: Colors
                                                        .amber[800]!
                                                        .withOpacity(0.1),
                                                    animation: true,
                                                    progressColor:
                                                        Colors.amber[800],
                                                    padding: EdgeInsets.zero,
                                                    percent: courses[index]
                                                            .progress! /
                                                        100,
                                                  )),
                                                  const SizedBox(width: 5),
                                                  Text(
                                                    "${courses[index].progress.toString()}%",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline3!
                                                        .merge(TextStyle(
                                                            fontSize: 14,
                                                            color: Colors
                                                                .amber[800])),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                        IconButton(
                                          iconSize: 45,
                                          onPressed: () {
                                            Navigator.of(context).push(
                                                getGenericeRouteWithSideTransition(
                                                    CoursePage(
                                                        coursedata:
                                                            courses[index],
                                                        homePageBloc:
                                                            widget.bloc)));
                                          },
                                          icon: Container(
                                            alignment: Alignment.center,
                                            child: const Icon(
                                              Icons.play_arrow,
                                              size: 30,
                                              color: Colors.white,
                                            ),
                                            decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.red),
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                })
                            : Center(
                                child: Text(
                                  "Error occured getting data from backend",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .merge(const TextStyle(
                                          fontSize: 16, color: Colors.red)),
                                ),
                              );
                      } else {
                        return Container();
                      }
                    }
                  },
                  stream: widget.bloc.getCoursesStream,
                ))
              ],
            ),
          ))
        ],
      ),
    );
  }
}
