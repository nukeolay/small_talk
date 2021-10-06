import 'package:flutter/material.dart';

class AcceptedScreen extends StatefulWidget {
  const AcceptedScreen({Key? key}) : super(key: key);

  @override
  _AcceptedScreenState createState() => _AcceptedScreenState();
}

class _AcceptedScreenState extends State<AcceptedScreen> {
  bool _visible = false;

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) => _runAnimation());
    super.initState();
  }

  void _runAnimation() {
    setState(() {
      _visible = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Object> arguments =
        ModalRoute.of(context)!.settings.arguments as List<Object>;
    final String heartIcon = arguments[0] as String;
    final Color heartColor = arguments[1] as Color;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedOpacity(
                opacity: _visible ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 1000),
                child: TextButton(
                  child: Text(
                    heartIcon,
                    style: TextStyle(
                      fontSize: 100,
                      color: heartColor,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        '/', (Route<dynamic> route) => false);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
