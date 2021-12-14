import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CourseDataLoader extends StatelessWidget {
  const CourseDataLoader({Key? key}) : super(key: key);

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
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: Colors.white,
            ),
            height: 40,
            margin: const EdgeInsets.only(top: 3),
          ),
          itemCount: 15,
        ),
      ))
    ]);
  }
}
