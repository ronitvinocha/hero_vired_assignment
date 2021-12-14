import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CourseLoader extends StatelessWidget {
  const CourseLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.max, children: [
      Expanded(
          child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        enabled: true,
        loop: 5,
        child: ListView.builder(
          itemBuilder: (_, __) => Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
            ),
            margin: const EdgeInsets.only(top: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 100,
                        height: 8.0,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        width: double.infinity,
                        height: 8.0,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  width: 48.0,
                  height: 48.0,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.white),
                ),
              ],
            ),
          ),
          itemCount: 10,
        ),
      ))
    ]);
  }
}
