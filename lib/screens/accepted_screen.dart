import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AcceptedScreen extends StatefulWidget {
  const AcceptedScreen({Key? key}) : super(key: key);

  @override
  State<AcceptedScreen> createState() => _AcceptedScreenState();
}

class _AcceptedScreenState extends State<AcceptedScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isSuccess = ModalRoute.of(context)!.settings.arguments as bool;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: width * 0.9,
                height: width * 0.9,
                child: InkWell(
                  child: isSuccess
                      ? Lottie.asset(
                          'assets/animations/success.json',
                          repeat: false,
                          controller: _controller,
                          onLoaded: (composition) {
                            _controller.duration = Duration(seconds: 2);
                            _controller.forward();
                          },
                        )
                      : Lottie.asset(
                          'assets/animations/not_success.json',
                          repeat: false,
                          controller: _controller,
                          onLoaded: (composition) {
                            _controller.duration = Duration(seconds: 2);
                            _controller.forward();
                          },
                        ),
                  onTap: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        '/', (Route<dynamic> route) => false);
                  },
                  borderRadius: BorderRadius.circular(80),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
