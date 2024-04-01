import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'text_styles.dart';

class LoginScreenPage extends StatelessWidget {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Container(
          width: 1920,
          height: 1080,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(color: Colors.white),
          child: Stack(
              children: [
                Positioned(
                      left: 0,
                      top: 0,
                      child: Container(
                          width: 1920,
                          height: 1080,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/images/backgrounds/login_bg.jpg'),
                                  fit: BoxFit.fill,
                              ),
                          ),
                      ),
                  ),
                  Positioned(
                    left: 900,
                    top: 0,
                    child: Container(
                        width: 700,
                        height: 1000,
                        decoration: BoxDecoration(color: Color(0xB29A9393).withOpacity(0.6)),),),
                  Positioned(
                      left: 968,
                      top: 105,
                      child: SizedBox(
                          width: 290,
                          height: 78,
                          child: Text(
                              'Log In',
                              style: loginHeader
                          ),
                      ),
                  ),
                  Positioned(
                      left: 48,
                      top: 44,
                      child: SizedBox(
                          width: 131,
                          height: 74,
                          child: Text(
                              'dot.',
                              style: dotLogo 
                          ),
                      ),
                  ),
                  
                  Positioned(
                      left: 968,
                      top: 193,
                      child: SizedBox(
                          width: 486,
                          height: 190,
                          child: Stack(
                              children: [
                                  Positioned(
                                      left: 0,
                                      top: 24,
                                      child: Container(
                                          width: 486,
                                          height: 56,
                                          decoration: ShapeDecoration(
                                              color: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                  side: BorderSide(
                                                      width: 1,
                                                      strokeAlign: BorderSide.strokeAlignOutside,
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
                                                final errorMessage = await _authService.login(_formKey, _emailController.text, _passwordController.text, context);
                                                if (errorMessage != "") {
                                                  ScaffoldMessenger.of(context).showSnackBar(
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
                                          ),)
                                      ),
                                  ),
                                  Positioned(
                                      left: 0,
                                      top: 134,
                                      child: Container(
                                          width: 486,
                                          height: 56,
                                          decoration: ShapeDecoration(
                                              color: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                  side: BorderSide(
                                                      width: 1,
                                                      strokeAlign: BorderSide.strokeAlignOutside,
                                                      color: Color(0xFFC4BBBB),
                                                  ),
                                                  borderRadius: BorderRadius.circular(20),
                                              ),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: TextFormField(
                                              controller: _passwordController,
                                              onFieldSubmitted: (_) async {
                                                final errorMessage = await _authService.login(_formKey, _emailController.text, _passwordController.text, context);
                                                if (errorMessage != "") {
                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                    SnackBar(
                                                      content: Text(errorMessage),
                                                    ),
                                                  );
                                                }
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
                                          ),)
                                      ),
                                  ),
                                  Positioned(
                                      left: 4,
                                      top: 0,
                                      child: SizedBox(
                                          width: 162,
                                          height: 24,
                                          child: Text(
                                              'Username',
                                              style: fieldHeaders
                                          ),
                                      ),
                                  ),
                                  Positioned(
                                      left: 4,
                                      top: 105,
                                      child: SizedBox(
                                          width: 162,
                                          height: 24,
                                          child: Text(
                                              'Password',
                                              style: fieldHeaders
                                          ),
                                      ),
                                  ),
                              ],
                          ),
                      ),
                  ),
                  Positioned(
                      left: 968,
                      top: 414,
                      child: SizedBox(
                          width: 486,
                          height: 65,
                          child: ElevatedButton(
                            onPressed: () async {
                              final errorMessage = await _authService.login(_formKey, _emailController.text, _passwordController.text, context);
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
                            child:Text(
                              'Log in',
                              textAlign: TextAlign.center,
                              style: membersList
                            ),
                          ),
                      ),
                  ),
                  Positioned(
                      left: 1004,
                      top: 500,
                      child: SizedBox(
                          width: 413,
                          height: 23,
                          child: Text(
                              'Looking for the admin console? Click Here',
                              textAlign: TextAlign.center,
                              style: looseTextW
                          ),
                      ),
                  ),
                  Positioned(
                      left: 989,
                      top: 700,
                      child: SizedBox(
                          width: 465,
                          height: 54,
                          child: Text(
                              '© 2024 dot. , Made in the New Administrative Capital with ♡',
                              textAlign: TextAlign.center,
                              style: looseTextW
                          ),
                      ),
                  ),
              ],
          ),
      )
      )
          );
        }
      }