import 'package:flutter/material.dart';
import 'package:hero_vired/bl/blocs/homepagebloc.dart';
import 'package:hero_vired/bl/model/homepagemodel/coursedataresponse.dart';
import 'package:hero_vired/bl/model/homepagemodel/coursesresponse.dart';
import 'package:hero_vired/ui/widgets/courcedataloader.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CourseTopic extends StatefulWidget {
  final HomePageBloc homePageBloc;
  final Coursedata coursedata;
  const CourseTopic(
      {Key? key, required this.coursedata, required this.homePageBloc})
      : super(key: key);

  @override
  _CourseTopisState createState() => _CourseTopisState();
}

class _CourseTopisState extends State<CourseTopic> {
  @override
  void initState() {
    super.initState();
    widget.homePageBloc
        .add(GetCourseData(courseId: widget.coursedata.courseid));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height - 200,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15))),
      child: Column(
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
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Row(
              children: [
                const Icon(
                  Icons.computer,
                  size: 22,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  widget.coursedata.coursename,
                  style: Theme.of(context).textTheme.headline2!.merge(
                      const TextStyle(fontSize: 18, color: Colors.black87)),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                    width: 200,
                    child: LinearPercentIndicator(
                      backgroundColor: Colors.amber[800]!.withOpacity(0.1),
                      animation: true,
                      progressColor: Colors.amber[800],
                      padding: EdgeInsets.zero,
                      percent: widget.coursedata.progress! / 100,
                    )),
                const SizedBox(width: 10),
                Text(
                  "${widget.coursedata.progress.toString()}%",
                  style: Theme.of(context)
                      .textTheme
                      .headline3!
                      .merge(TextStyle(fontSize: 14, color: Colors.amber[800])),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
              child: StreamBuilder(
                  stream: widget.homePageBloc.getCoursesDataStream,
                  builder: (ctx, snap) {
                    if (snap.connectionState == ConnectionState.waiting) {
                      return const CourseDataLoader();
                    } else {
                      if (snap.hasData) {
                        List<CoursesDataResponse> coursedata =
                            snap.data as List<CoursesDataResponse>;
                        return coursedata.isEmpty
                            ? Center(
                                child: Text(
                                  "Error occured getting course data from backend",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .merge(const TextStyle(
                                          fontSize: 16, color: Colors.red)),
                                ),
                              )
                            : ListView.builder(
                                itemBuilder: (ctx, index) {
                                  return Container(
                                    decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    margin: const EdgeInsets.only(
                                        top: 4, left: 4, right: 4),
                                    child: ExpansionTile(
                                        title: Text(
                                          "${index + 1}.    ${coursedata[index].name}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .merge(const TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.black87)),
                                        ),
                                        children: coursedata[index]
                                            .modules
                                            .map((e) => Container(
                                                  height: 40,
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  color: Colors.white,
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 30),
                                                  child: Row(
                                                    children: [
                                                      SvgPicture.network(
                                                          e.modicon!,
                                                          width: 20,
                                                          height: 20),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text(e.name)
                                                    ],
                                                  ),
                                                ))
                                            .toList(),
                                        collapsedBackgroundColor:
                                            Colors.grey[200],
                                        backgroundColor: Colors.grey[200],
                                        trailing: index == 0
                                            ? Icon(
                                                Icons.check_circle_outline,
                                                color: Colors.amber[800]!
                                                    .withOpacity(0.2),
                                              )
                                            : const Icon(
                                                Icons.circle_outlined,
                                                color: Colors.grey,
                                              )),
                                  );
                                },
                                itemCount: coursedata.length,
                              );
                      } else {
                        return Container();
                      }
                    }
                  }))
        ],
      ),
    );
  }
}
