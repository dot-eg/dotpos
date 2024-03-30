import 'package:flutter/material.dart';
import 'auth_service.dart';

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
          width: 1528,
          height: 1000,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(color: Colors.white),
          child: Stack(
              children: [
                  Positioned(
                      left: 968,
                      top: 105,
                      child: SizedBox(
                          width: 290,
                          height: 78,
                          child: Text(
                              'Log In',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 30,
                                  fontFamily: 'Hind Kochi',
                                  fontWeight: FontWeight.w500,
                                  height: 0,
                              ),
                          ),
                      ),
                  ),
                  Positioned(
                      left: 0,
                      top: 0,
                      child: Container(
                          width: 894,
                          height: 1000,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage("https://images.unsplash.com/photo-1579546929518-9e396f3cc809?q=80&w=1770&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
                                  fit: BoxFit.fill,
                              ),
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
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 70,
                                  fontFamily: 'Kollektif',
                                  fontWeight: FontWeight.w700,
                                  height: 0,
                                  letterSpacing: -5,
                              ),
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
                                          child: TextFormField(
                                            controller: _emailController,
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
                                                  borderRadius: BorderRadius.circular(10),
                                              ),
                                          ),
                                          child: TextFormField(
                                            controller: _passwordController,
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
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 20,
                                                  fontFamily: 'Hind Kochi',
                                                  fontWeight: FontWeight.w500,
                                                  height: 0,
                                              ),
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
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 20,
                                                  fontFamily: 'Hind Kochi',
                                                  fontWeight: FontWeight.w500,
                                                  height: 0,
                                              ),
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
                      child: Container(
                          width: 486,
                          height: 65,
                          decoration: ShapeDecoration(
                              color: Colors.black,
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(width: 1),
                                  borderRadius: BorderRadius.circular(20),
                              ),
                              shadows: [
                                  BoxShadow(
                                      color: Color(0x3F000000),
                                      blurRadius: 4,
                                      offset: Offset(0, 2),
                                      spreadRadius: 1,
                                  )
                              ],
                          ),
                      ),
                  ),
                  Positioned(
                      left: 1125,
                      top: 437,
                      child: SizedBox(
                          width: 150,
                          height: 30,
                          child: ElevatedButton(
                            onPressed: ()  {
                              _authService.login(_formKey, _emailController.text, _passwordController.text, context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child:Text(
                              'Log in',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontFamily: 'Hind Kochi',
                                  fontWeight: FontWeight.w500,
                                  height: 0,
                              ),
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
                              'Looking for the admin console? click here',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontFamily: 'Hind Kochi',
                                  fontWeight: FontWeight.w500,
                                  height: 0,
                              ),
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
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontFamily: 'Hind Kochi',
                                  fontWeight: FontWeight.w500,
                                  height: 0,
                              ),
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