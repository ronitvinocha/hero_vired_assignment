import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:hero_vired/bl/blocs/homepagebloc.dart';
import 'package:hero_vired/bl/model/homepagemodel/coursesresponse.dart';
import 'package:hero_vired/ui/pages/cousesbottomsheet.dart';

class CoursePage extends StatefulWidget {
  final Coursedata coursedata;
  final HomePageBloc homePageBloc;
  const CoursePage(
      {Key? key, required this.coursedata, required this.homePageBloc})
      : super(key: key);

  @override
  _CoursePageState createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> with AfterLayoutMixin {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        elevation: 3,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black87,
            size: 24,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        title: Text(
          widget.coursedata.coursename,
          style: Theme.of(context)
              .textTheme
              .headline2!
              .merge(const TextStyle(fontSize: 15, color: Colors.black87)),
        ),
      ),
      body: Container(),
    ));
  }

  @override
  void afterFirstLayout(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        builder: (context) {
          return CourseTopic(
              coursedata: widget.coursedata, homePageBloc: widget.homePageBloc);
        });
  }
}
