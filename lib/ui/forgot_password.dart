import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'text_styles.dart';
import 'login_screen.dart';

class Forgotpassword extends StatelessWidget {
  final _emailController = TextEditingController();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
            child: Container(
              width: 1920,
              height: 1080,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(color: Colors.white),
              child: Stack(
                children: [
                  Positioned(
                    left: 915,
                    top: 54,
                    child: Container(
                      width: 551,
                      height: 640,
                      decoration: ShapeDecoration(
                        color: Colors.black.withOpacity(0.9),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 950,
                    top: 105,
                    child: SizedBox(
                      width: 290,
                      height: 78,
                      child: Text('Reset Password', style: loginHeader),
                    ),
                  ),
                  Positioned(
                    left: 52,
                    top: 606,
                    child: SizedBox(
                      width: 131,
                      height: 74,
                      child: Text('dot.', style: dotLogo),
                    ),
                  ),
                  Positioned(
                    left: 950,
                    top: 193,
                    child: SizedBox(
                      width: 486,
                      height: 195,
                      child: Stack(
                        children: [
                          Positioned(
                            left: 0,
                            top: 29,
                            child: Container(
                                width: 486,
                                height: 56,
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
                                    onFieldSubmitted: (_) async {
                                      final errorMessage =
                                          await _authService.resetPassword(_emailController.text);
                                      if (errorMessage != "") {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(errorMessage),
                                          ),
                                        );
                                      }
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
                            left: 4,
                            top: 0,
                            child: SizedBox(
                              width: 162,
                              height: 24,
                              child: Text('Enter your Email', style: fieldHeaders),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 950,
                    top: 414,
                    child: SizedBox(
                      width: 486,
                      height: 65,
                      child: ElevatedButton(
                        onPressed: () async {
                          final errorMessage = await _authService.resetPassword(_emailController.text,);
                          if (errorMessage != "") {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(errorMessage),
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Text('Reset Password',
                            textAlign: TextAlign.center, style: membersList),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 950,
                    top: 500,
                    child: SizedBox(
                      width: 486,
                      height: 65,
                      child: ElevatedButton(
                        onPressed: () async {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => LoginScreenPage(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Text('Back to Login',
                            textAlign: TextAlign.center, style: membersList),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 963,
                    top: 700,
                    child: SizedBox(
                      width: 465,
                      height: 54,
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
