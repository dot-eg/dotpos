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
                      height: MediaQuery.of(context).size.height * 0.80726539,
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
                      child: Text('Reset Password', style: loginHeader),
                    ),
                  ),
                  Positioned(
                    left: MediaQuery.of(context).size.width * 0.01953125,
                    top: MediaQuery.of(context).size.height * 0.81987891,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.078125,
                      height: MediaQuery.of(context).size.height * 0.09334006,
                      child: Text('dot.', style: dotLogo.copyWith(fontSize: MediaQuery.of(context).size.width * 0.04557292), textAlign: TextAlign.center,),
                    ),
                  ),
                  Positioned(
                    left: MediaQuery.of(context).size.width * 0.61848958,
                    top: MediaQuery.of(context).size.height * 0.24596367,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.31640625,
                      height: MediaQuery.of(context).size.height * 0.25696367,
                      child: Stack(
                        children: [
                          Positioned(
                            left: 0,
                            top: 29,
                            child: Container(
                                width: MediaQuery.of(context).size.width * 0.31640625,
                                height: MediaQuery.of(context).size.height * 0.07063572,
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
                    left: MediaQuery.of(context).size.width * 0.61848958,
                    top: MediaQuery.of(context).size.height * 0.5221998,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.31640625,
                      height: MediaQuery.of(context).size.height * 0.08198789,
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
                    left:  MediaQuery.of(context).size.width * 0.61848958,
                    top: 500,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.31640625,
                      height: MediaQuery.of(context).size.height * 0.08198789,
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
                    left: MediaQuery.of(context).size.width * 0.62695312,
                    top: MediaQuery.of(context).size.height * 0.88294652,
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
