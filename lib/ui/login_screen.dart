import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'text_styles.dart';
import 'forgot_password.dart';

class LoginScreenPage extends StatefulWidget {
  @override
  _LoginScreenPageState createState() => _LoginScreenPageState();
}

class _LoginScreenPageState extends State<LoginScreenPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final AuthService _authService = AuthService();
  bool _isLoading = false;

  Future<void> _login() async {
    setState(() {
      _isLoading = true;
    });
    final errorMessage = await _authService.login(
        _formKey, _emailController.text, _passwordController.text, context);
    setState(() {
      _isLoading = false;
    });
    if (errorMessage != "") {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Form(
                key: _formKey,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(color: Colors.white),
                  child: Stack(
                    children: [
                      Positioned(
                        left: MediaQuery.of(context).size.width * 0.59570312,
                        top: MediaQuery.of(context).size.height * 0.06811302,
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.35872396,
                          height:
                              MediaQuery.of(context).size.height * 0.80726539,
                          decoration: ShapeDecoration(
                            color: Colors.black.withOpacity(0.9),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: MediaQuery.of(context).size.width * 0.61848958,
                        top: MediaQuery.of(context).size.height * 0.13244198,
                        child: SizedBox(
                          width: 290,
                          height: 78,
                          child: Text('Log In', style: loginHeader),
                        ),
                      ),
                      Positioned(
                        left: MediaQuery.of(context).size.width * 0.01953125,
                        top: MediaQuery.of(context).size.height * 0.81987891,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.078125,
                          height:
                              MediaQuery.of(context).size.height * 0.09334006,
                          child: Text(
                            'dot.',
                            style: dotLogo.copyWith(
                                fontSize: MediaQuery.of(context).size.width *
                                    0.04557292),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Positioned(
                        left: MediaQuery.of(context).size.width * 0.61848958,
                        top: MediaQuery.of(context).size.height * 0.24596367,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.31640625,
                          height:
                              MediaQuery.of(context).size.height * 0.25696367,
                          child: Stack(
                            children: [
                              Positioned(
                                left: 0,
                                top: 29,
                                child: Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.31640625,
                                    height: MediaQuery.of(context).size.height *
                                        0.07063572,
                                    decoration: ShapeDecoration(
                                      color: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                          width: 1,
                                          strokeAlign:
                                              BorderSide.strokeAlignOutside,
                                          color: Color(0xFFC3BBBB),
                                        ),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        controller: _emailController,
                                        onFieldSubmitted: (_) {
                                          _login;
                                        },
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Email',
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter your email';
                                          }
                                          return null;
                                        },
                                      ),
                                    )),
                              ),
                              Positioned(
                                left: 0,
                                top: MediaQuery.of(context).size.height * 0.18,
                                child: Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.31640625,
                                    height: MediaQuery.of(context).size.height *
                                        0.07063572,
                                    decoration: ShapeDecoration(
                                      color: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                          width: 1,
                                          strokeAlign:
                                              BorderSide.strokeAlignOutside,
                                          color: Color(0xFFC4BBBB),
                                        ),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        controller: _passwordController,
                                        onFieldSubmitted: (_) {
                                          _login;
                                        },
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Password',
                                        ),
                                        obscureText: true,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter your password';
                                          }
                                          return null;
                                        },
                                      ),
                                    )),
                              ),
                              Positioned(
                                left: 4,
                                top: 0,
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width *
                                      0.10546875,
                                  height: MediaQuery.of(context).size.height *
                                      0.03027245,
                                  child: Text('Username', style: fieldHeaders),
                                ),
                              ),
                              Positioned(
                                left: 4,
                                top: 105,
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width *
                                      0.10546875,
                                  height: MediaQuery.of(context).size.height *
                                      0.03027245,
                                  child: Text('Password', style: fieldHeaders),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: MediaQuery.of(context).size.width * 0.61848958,
                        top: MediaQuery.of(context).size.height * 0.5221998,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.31640625,
                          height:
                              MediaQuery.of(context).size.height * 0.08198789,
                          child: ElevatedButton(
                            onPressed: _login,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: Text('Log in',
                                textAlign: TextAlign.center,
                                style: membersList),
                          ),
                        ),
                      ),
                      Positioned(
                        left: MediaQuery.of(context).size.width * 0.63802083,
                        top: MediaQuery.of(context).size.height * 0.63067608,
                        child: SizedBox(
                          width: 413,
                          height: 23,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => Forgotpassword()));
                            },
                            child: Text(
                              'Forgot your password? Click Here',
                              textAlign: TextAlign.center,
                              style: looseTextW,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: MediaQuery.of(context).size.width * 0.62695312,
                        top: MediaQuery.of(context).size.height * 0.88294652,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.30273438,
                          height:
                              MediaQuery.of(context).size.height * 0.06811302,
                          child: Text(
                              '© 2024 dot. , Made in the New Administrative Capital with ♡',
                              textAlign: TextAlign.center,
                              style: looseTextB),
                        ),
                      ),
                    ],
                  ),
                )));
  }
}
