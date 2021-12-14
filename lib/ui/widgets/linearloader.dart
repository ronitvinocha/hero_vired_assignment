import 'package:flutter/material.dart';

class LinearLoader extends StatefulWidget {
  const LinearLoader({Key? key}) : super(key: key);

  @override
  LinearLoaderState createState() => LinearLoaderState();
}

class LinearLoaderState extends State<LinearLoader>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 1500),
    vsync: this,
  );
  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: const Offset(-2, 0.0),
    end: const Offset(2, 0.0),
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.linear,
  ));
  startLoader() {
    _controller.forward().whenComplete(() => _controller.repeat(reverse: true));
  }

  stopLoader() {
    _controller.reset();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offsetAnimation,
      child: Container(
        height: 5,
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(2)),
        width: MediaQuery.of(context).size.width / 1.5,
      ),
    );
  }
}
