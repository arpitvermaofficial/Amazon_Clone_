import 'package:amazon/Constant/global_variable.dart';
import 'package:amazon/common/widgets/Custom_Buttom.dart';
import 'package:amazon/common/widgets/custom_textfield.dart';
import 'package:amazon/features/auth/services/authservices.dart';
import 'package:flutter/material.dart';

enum Auth {
  SignUp,
  SignIn,
}

class AuthScreen extends StatefulWidget {
  static const String routeName = "/auth-screen";
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _signupFormKey = GlobalKey<FormState>();
  final _signinFormKey = GlobalKey<FormState>();
  final Authservices authservices = Authservices();
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final TextEditingController _namecontroller = TextEditingController();
  Auth _auth = Auth.SignUp;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
    _namecontroller.dispose();
  }

  void signUpUser() {
    authservices.signupuser(
        context: context,
        email: _emailcontroller.text,
        password: _passwordcontroller.text,
        name: _namecontroller.text);
  }
  void signInUser() {
    authservices.siginuser(
        context: context,
        email: _emailcontroller.text,
        password: _passwordcontroller.text,
        );
  }
 
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Globalariables.greyBackgroundCOlor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Welcome',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 22)),
              ListTile(
                tileColor: _auth == Auth.SignUp
                    ? Globalariables.backgroundColor
                    : Globalariables.greyBackgroundCOlor,
                title: const Text(
                  'Create Account',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                leading: Radio(
                    value: Auth.SignUp,
                    groupValue: _auth,
                    onChanged: (Auth? val) {
                      setState(() {
                        _auth = val!;
                      });
                    },
                    activeColor: Globalariables.secondaryColor),
              ),
              if (_auth == Auth.SignUp)
                Container(
                  padding: EdgeInsets.all(8),
                  color: Globalariables.backgroundColor,
                  child: Form(
                    key: _signupFormKey,
                    child: Column(
                      children: [
                        CustomTextFormField(
                          controller: _namecontroller,
                          hinttext: 'Name',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextFormField(
                          controller: _emailcontroller,
                          hinttext: 'Email',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextFormField(
                          controller: _passwordcontroller,
                          hinttext: 'Password',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomButton(
                          text: "SignUp",
                          onTap: () {
                            if (_signupFormKey.currentState!.validate()) {
                              signUpUser();
                            }
                            ;
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ListTile(
                tileColor: _auth == Auth.SignIn
                    ? Globalariables.backgroundColor
                    : Globalariables.greyBackgroundCOlor,
                title: const Text(
                  'Sign In',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                leading: Radio(
                    value: Auth.SignIn,
                    groupValue: _auth,
                    onChanged: (Auth? val) {
                      setState(() {
                        _auth = val!;
                      });
                    },
                    activeColor: Globalariables.secondaryColor),
              ),
              if (_auth == Auth.SignIn)
                Container(
                  padding: EdgeInsets.all(8),
                  color: Globalariables.backgroundColor,
                  child: Form(
                    key: _signinFormKey,
                    child: Column(
                      children: [
                        CustomTextFormField(
                          controller: _emailcontroller,
                          hinttext: 'Email',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextFormField(
                          controller: _passwordcontroller,
                          hinttext: 'Password',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomButton(
                          text: "SignIn",
                          onTap: () {
                             if (_signinFormKey.currentState!.validate()) {
                              signInUser();
                            }
                          },
                        )
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
