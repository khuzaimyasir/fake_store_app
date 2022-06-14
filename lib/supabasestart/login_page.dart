import 'package:fake_store_app/supabasestart/constantzz.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../utils/constants.dart';

import 'signup_page.dart';

class LoginPage extends StatefulWidget {
  static String routeName = '/login';
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _form = GlobalKey<FormState>();
  bool _isLoading = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _signIn() async {
    setState(() {
      _isLoading = true;
    });

    final isValid =
        _form.currentState == null ? false : _form.currentState!.validate();

    if (isValid) {
      final response = await supabase.auth.signIn(
          email: _emailController.text, password: _passwordController.text);
      final error = response.error;
      if (error != null) {
        context.showErrorSnackBar(message: error.message);
      } else {
        // Navigator.of(context).pushReplacementNamed(MainPage.routeName);
      }
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String? _emailFromSignUp =
        ModalRoute.of(context)!.settings.arguments as String?;

    _emailController.text = _emailFromSignUp ?? '';

    return Scaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        children: [
          Form(
            key: _form,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // TextButton(
                    //   onPressed: () =>
                    //       // Navigator.of(context).pushNamed(MainPage.routeName),
                    //   // child: const Text('Back'),
                    // ),
                  ],
                ),
                Image.asset(
                  'assets/images/user.png',
                  height: 30,
                ),
                const Text(
                  'AqNiyet',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 18),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                  enabled: !_isLoading,
                  validator: emailValidator(),
                ),
                const SizedBox(height: 18),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  enabled: !_isLoading,
                  validator: passwordValidator(),
                ),
                const SizedBox(height: 18),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: _isLoading ? null : _signIn,
                      child: Text(_isLoading ? 'Loading' : 'Sign In'),
                      
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                      TextButton(
                      onPressed: () =>  Navigator.of(context)
                              .pushNamed(LoginPage.routeName),
                          // EditProfilePage.route(isCreatingAccount: true));
                         
                      child: const Text('Sign In'),
                    ),
                    // TextButton(
                    //   onPressed: () => _isLoading
                    //       ? null
                    //       : Navigator.of(context)
                    //           .pushNamed(SignUpPage.routeName),
                    //   child: const Text('Sign Up'),
                    // ),
                  ],
                ),
                SizedBox(height: 20),
                const Text(
                  'DEVELOPED BY IGOR DMITROV',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  DateTime.now().year.toString(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}