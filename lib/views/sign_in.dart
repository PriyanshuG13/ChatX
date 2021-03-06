import 'package:chatx/views/home.dart';
import 'package:chatx/widget/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:chatx/helper/helperfunctions.dart';
import 'package:chatx/services/auth.dart';
import 'package:chatx/services/database.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:chatx/helper/theme.dart';
import 'package:chatx/views/forgot_password.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();

  final FocusNode focusNodeEmail = FocusNode();
  final FocusNode focusNodePassword = FocusNode();
  final FocusNode focusNodeLoginButton = FocusNode();
  final formKey = GlobalKey<FormState>();

  bool _obscureTextPassword = true;
  AuthService authService = new AuthService();
  bool isLoading = false;

  bool isEmail(String input) => RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(input);

  bool isPhone(String input) =>
      RegExp(r'^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$')
          .hasMatch(input);

  @override
  void dispose() {
    focusNodeEmail.dispose();
    focusNodePassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Container(
            child: Center(child: CircularProgressIndicator()),
          )
        : Container(
            padding: const EdgeInsets.only(top: 23.0),
            child: Column(
              children: <Widget>[
                Stack(
                  alignment: Alignment.topCenter,
                  children: <Widget>[
                    Card(
                      elevation: 2.0,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Container(
                          width: 300.0,
                          height: 190.0,
                          child: Form(
                            key: formKey,
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 20.0,
                                      bottom: 20.0,
                                      left: 25.0,
                                      right: 25.0),
                                  child: TextFormField(
                                    focusNode: focusNodeEmail,
                                    controller: loginEmailController,
                                    keyboardType: TextInputType.emailAddress,
                                    validator: (val) {
                                      if (!isEmail(val) && !isPhone(val)) {
                                        CustomSnackBar(
                                            context,
                                            Text(
                                                'Please enter a valid email.'));
                                      }
                                      return null;
                                    },
                                    style: const TextStyle(
                                        fontFamily: 'WorkSansSemiBold',
                                        fontSize: 16.0,
                                        color: Colors.black),
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      icon: Icon(
                                        FontAwesomeIcons.envelope,
                                        color: Colors.black,
                                        size: 22.0,
                                      ),
                                      hintText: 'Email Address',
                                      hintStyle: TextStyle(
                                          fontFamily: 'WorkSansSemiBold',
                                          fontSize: 17.0,
                                          color: Colors.grey),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 250.0,
                                  height: 1.0,
                                  color: Colors.grey[400],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 20.0,
                                      bottom: 20.0,
                                      left: 25.0,
                                      right: 25.0),
                                  child: TextFormField(
                                    focusNode: focusNodePassword,
                                    controller: loginPasswordController,
                                    obscureText: _obscureTextPassword,
                                    validator: (val) {
                                      if (val.length < 6) {
                                        CustomSnackBar(
                                            context,
                                            Text(
                                                'Password must be 6+ characters'));
                                      }
                                      return null;
                                    },
                                    style: const TextStyle(
                                        fontFamily: 'WorkSansSemiBold',
                                        fontSize: 16.0,
                                        color: Colors.black),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      icon: const Icon(
                                        FontAwesomeIcons.lock,
                                        size: 22.0,
                                        color: Colors.black,
                                      ),
                                      hintText: 'Password',
                                      hintStyle: const TextStyle(
                                          fontFamily: 'WorkSansSemiBold',
                                          fontSize: 17.0,
                                          color: Colors.grey),
                                      suffixIcon: GestureDetector(
                                        onTap: _toggleLogin,
                                        child: Icon(
                                          _obscureTextPassword
                                              ? FontAwesomeIcons.eye
                                              : FontAwesomeIcons.eyeSlash,
                                          size: 15.0,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    textInputAction: TextInputAction.go,
                                  ),
                                ),
                              ],
                            ),
                          )),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 170.0),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Colors.redAccent,
                            offset: Offset(1.0, 6.0),
                            blurRadius: 20.0,
                          ),
                          BoxShadow(
                            color: const Color(0xff2A75BC),
                            offset: Offset(1.0, 6.0),
                            blurRadius: 20.0,
                          ),
                        ],
                        gradient: LinearGradient(
                            colors: <Color>[
                              Colors.redAccent,
                              const Color(0xff2A75BC)
                            ],
                            begin: FractionalOffset(0.2, 0.2),
                            end: FractionalOffset(1.0, 1.0),
                            stops: <double>[0.0, 1.0],
                            tileMode: TileMode.clamp),
                      ),
                      child: MaterialButton(
                        highlightColor: Colors.transparent,
                        splashColor: CustomTheme.loginGradientEnd,
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 42.0),
                          child: Text(
                            'LOGIN',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 25.0,
                                fontFamily: 'WorkSansBold'),
                          ),
                        ),
                        onPressed: () => _toggleSignInButton(),
                      ),
                    )
                  ],
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ForgotPassword())),
                      child: TextButton(
                          onPressed: () {},
                          child: const Text(
                            'Forgot Password?',
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Colors.white,
                                fontSize: 16.0,
                                fontFamily: 'WorkSansMedium'),
                          )),
                    )),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                              colors: <Color>[
                                Colors.white10,
                                Colors.white,
                              ],
                              begin: FractionalOffset(0.0, 0.0),
                              end: FractionalOffset(1.0, 1.0),
                              stops: <double>[0.0, 1.0],
                              tileMode: TileMode.clamp),
                        ),
                        width: 100.0,
                        height: 1.0,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 15.0, right: 15.0),
                        child: Text(
                          'Or',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontFamily: 'WorkSansMedium'),
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                              colors: <Color>[
                                Colors.white,
                                Colors.white10,
                              ],
                              begin: FractionalOffset(0.0, 0.0),
                              end: FractionalOffset(1.0, 1.0),
                              stops: <double>[0.0, 1.0],
                              tileMode: TileMode.clamp),
                        ),
                        width: 100.0,
                        height: 1.0,
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, right: 20.0),
                      child: GestureDetector(
                        onTap: () => {},
                        child: Container(
                          padding: const EdgeInsets.all(15.0),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: const Icon(
                            FontAwesomeIcons.google,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, right: 20.0),
                      child: GestureDetector(
                        onTap: () => {},
                        child: Container(
                          padding: const EdgeInsets.all(15.0),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: const Icon(
                            FontAwesomeIcons.github,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: GestureDetector(
                        onTap: () => {},
                        child: Container(
                          padding: const EdgeInsets.all(15.0),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: const Icon(
                            FontAwesomeIcons.apple,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
  }

  void _toggleSignInButton() async {
    if (formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });

      await authService
          .signInWithEmailAndPassword(
              loginEmailController.text, loginPasswordController.text)
          .then((result) async {
        if (result != null) {
          print(1);
          QuerySnapshot userInfoSnapshot =
              await DatabaseMethods().getUserInfo(loginEmailController.text);

          HelperFunctions.saveUserLoggedInSharedPreference(true);
          HelperFunctions.saveUserNameSharedPreference(
              userInfoSnapshot.documents[0].data["userName"]);
          HelperFunctions.saveUserEmailSharedPreference(
              userInfoSnapshot.documents[0].data["userEmail"]);

          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Home()));
        } else {
          setState(() {
            isLoading = false;
            //show snackbar
          });
        }
      });
    }
  }

  void _toggleLogin() {
    setState(() {
      _obscureTextPassword = !_obscureTextPassword;
    });
  }
}
