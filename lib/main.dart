import 'package:flutter/material.dart';
import 'package:remote_mouse/components/components.dart';
import 'package:remote_mouse/views/views.dart';


void main() {
  runApp(const App(title: 'Remote mouse'));
}

class App extends StatelessWidget {
  const App({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      theme: ThemeData(primarySwatch: Colors.grey),
      home: buildBody(),
      debugShowCheckedModeBanner: false,
    );
  }

  Widget buildBody() {
    return const Scaffold(
      body: Center(
        child: HostForm(),
      ),
    );
  }

}


class TouchTracker extends StatefulWidget {
  TouchTracker({Key? key}) : super(key: key);

  @override
  _TouchTrackerState createState() => _TouchTrackerState();
}

class _TouchTrackerState extends State<TouchTracker> {
  double x = 0.0;
  double y = 0.0;
  
  void _updateLocation(PointerEvent details) {
    setState(() {
      x = details.position.dx;
      y = details.position.dy;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
