import 'dart:math';

import 'package:cipra/auth/provider/auth_provider.dart';
import 'package:cipra/auth/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: LoginComponent());
  }
}

class LoginComponent extends ConsumerStatefulWidget {
  const LoginComponent({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginComponentState();
}

class _LoginComponentState extends ConsumerState<LoginComponent> {
  final Random random = Random();

  TextEditingController _login = TextEditingController();

  TextEditingController _pass = TextEditingController();

  bool _obscureText = true;

  // List of icons to choose from
  final List<IconData> icons = [
    Icons.star,
    Icons.favorite,
    Icons.home,
    Icons.lock,
    Icons.security,
    Icons.warning,
    Icons.wifi,
    Icons.phone,
    Icons.location_on,
    Icons.camera,
  ];

  @override
  Widget build(BuildContext context) {
    // Get the screen size
    final screenSize = MediaQuery.of(context).size;

    // Generate a list of positioned icons
    List<Widget> iconWidgets = List.generate(20, (index) {
      double top = random.nextDouble() * screenSize.height;
      double left = random.nextDouble() * screenSize.width;
      double size = 20 + random.nextDouble() * 30;
      IconData icon = icons[random.nextInt(icons.length)];
      Color color = Colors.grey.withOpacity(0.5);

      return Positioned(
        top: top,
        left: left,
        child: Icon(
          icon,
          size: size,
          color: color,
        ),
      );
    });

    return Stack(
      children: [
        // Background with random icons
        Stack(
          children: iconWidgets,
        ),
        // Column above the background
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RichText(
                    text: TextSpan(
                        text: "CIPRA",
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 48),
                        children: [
                      TextSpan(
                          text: ".ai", style: TextStyle(color: Colors.blue))
                    ])),
                SizedBox(height: 20),
                Text(
                  'Sign In',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 60),
                Row(
                  children: [
                    Icon(Icons.person),
                    SizedBox(
                      width: 24,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 1.3,
                      child: TextField(
                        controller: _login,
                        decoration: InputDecoration(
                          labelText: 'Username',
                          border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black, width: 8),
                              borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Icon(Icons.key),
                    SizedBox(
                      width: 24,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 1.3,
                      child: TextField(
                        controller: _pass,
                        obscureText: _obscureText,
                        decoration: InputDecoration(
                          suffixIcon: InkWell(
                              onTap: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                              child: Icon(Icons.remove_red_eye_outlined)),
                          labelText: 'Password',
                          border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black, width: 8),
                              borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(Colors.blue)),
                  onPressed: () async {
                    ref
                        .read(authPro)
                        .login(context, _login.text, _pass.text)
                        .then(
                      (value) {
                        if (value) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomeScreen()),
                          );
                        }
                      },
                    );
                  },
                  child: Text(
                    'Sign In',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
