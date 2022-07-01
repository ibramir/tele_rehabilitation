import 'package:flutter/material.dart';
import 'package:tele_rehabilitation/screens/home_screen.dart';
import 'package:tele_rehabilitation/utils/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var _isVisible = false;
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color(0xFFF0F0F0),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 50),
                height: deviceHeight * 0.3,
                child: const Image(
                  image: AssetImage('assets/logo-color.png'),
                ),
              ),
              Container(
                  height: deviceHeight * 0.6,
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: LayoutBuilder(builder: (ctx, constraints) {
                    return Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Welcome to TeleRehab!',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'proxima_ssv',
                                  fontSize: 30),
                            ),
                            SizedBox(
                              height: constraints.maxHeight * 0.01,
                            ),
                            const Text(
                              'Please enter your email and password to login',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 96, 94, 94),
                                  fontFamily: 'din'),
                            ),
                            SizedBox(
                              height: constraints.maxHeight * 0.08,
                            ),
                            Container(
                              height: constraints.maxHeight * 0.12,
                              decoration: BoxDecoration(
                                color: const Color(0xff848484).withOpacity(0.4),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Center(
                                  child: TextFormField(
                                    onSaved: (value) => _email = value!,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter E-mail';
                                      }
                                      bool isValid = RegExp(
                                              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                                          .hasMatch(value);
                                      if (isValid) {
                                        return null;
                                      }
                                      return 'Please enter a valid E-mail';
                                    },
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'E-mail',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: constraints.maxHeight * 0.02,
                            ),
                            Container(
                              height: constraints.maxHeight * 0.12,
                              decoration: BoxDecoration(
                                color: const Color(0xff848484).withOpacity(0.4),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Center(
                                  child: TextFormField(
                                    onSaved: (value) => _password = value!,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter password';
                                      }
                                      return null;
                                    },
                                    obscureText: _isVisible ? false : true,
                                    decoration: InputDecoration(
                                      suffixIcon: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            _isVisible = !_isVisible;
                                          });
                                        },
                                        icon: Icon(
                                          _isVisible
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      border: InputBorder.none,
                                      hintText: 'Password',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                  onPressed: () {},
                                  child: const Text(
                                    'Forgot Password',
                                    style: TextStyle(
                                      color: Colors.green,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              width: double.infinity,
                              height: constraints.maxHeight * 0.12,
                              margin: EdgeInsets.only(
                                top: constraints.maxHeight * 0.05,
                              ),
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();
                                    AuthService()
                                        .login(_email, _password)
                                        .then((success) {
                                      if (success) {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    HomeScreen()));
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content: Text(
                                                    'Invalid credentials')));
                                      }
                                    });
                                  }
                                },
                                child: const Text(
                                  'Login',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'proxima_ssv',
                                    fontSize: 25,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.green,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(28),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ));
                  }))
            ],
          ),
        ),
      ),
    );
  }
}
