import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flash_chat/components/lozenge_button.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
// --

class WelcomeScreen extends StatefulWidget {
  static String id = 'welcome';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  // Object-properties needed to enable custom animation
  AnimationController aniController;
  Animation animation;

  // INIT logic to instantly do animation on load
  @override
  void initState() {
    super.initState();

    // Controller methods needed to enable Welcome Screen opening anim
    aniController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
      upperBound: 1,
    );
    aniController.forward();
    aniController.addListener(() {
      setState(() {});
    });

    // Opening color-transition animation settings
    animation = ColorTween(begin: Colors.blueGrey, end: Colors.white)
        .animate(aniController);
  }

  // Ensure animation control object is destroyed when no longer used
  @override
  void dispose() {
    super.dispose();
    aniController.dispose();
  }

  // Widget tree
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: 60.0, // aniController.value * 100.0,
                  ),
                ),
                DefaultTextStyle(
                  style: TextStyle(
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                    color: Colors.black,
                  ),
                  child: AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText(
                        'Flash Chat',
                        speed: Duration(milliseconds: 150),
                      ),
                    ],
                    isRepeatingAnimation: true,
                    totalRepeatCount: 2,
                    //pause: Duration(milliseconds: 1000), // wait between blurbs
                    // onTap: (){}, // tap logic if ya needs it
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            LozengeButton(
              bgColour: Colors.lightBlueAccent,
              label: 'Log In',
              onPress: () {
                //Go to login screen.
                Navigator.pushNamed(context, LoginScreen.id);
              },
            ),
            LozengeButton(
              bgColour: Colors.blueAccent,
              label: 'Register',
              onPress: () {
                //Go to registration screen.
                Navigator.pushNamed(context, RegistrationScreen.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
