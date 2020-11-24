import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  @override
  void initState() {
    super.initState();
    animate();
  }

  animate() {
    _controller =
        AnimationController(duration: Duration(seconds: 5), vsync: this);
    _controller.forward();
    _controller.addListener(() {
      setState(() {});
      print(_controller.value);
    });
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) print('completed');
      _controller.reverse();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Roomi'),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(20, 200, 20, 0),
              child: Image.asset(
                'assets/images/splash_screen.png',
                height: 200 - (_controller.value) * 200,
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(20, 200, 20, 0),
              child: Text('Copy right'),
            ),
          ],
        ),
      ),
    );
  }
}
