import 'package:flutter/material.dart';
import '../widgets/text_field.dart';
import '/screens/login_screen.dart';
import 'upload_image_screen.dart';


class SignUp extends StatefulWidget {
    final TextEditingController emailController;
    final TextEditingController usernameController;
    final TextEditingController passwordController;
    final TextEditingController passwordConfirmController;

    const SignUp({
        super.key,
        required this.emailController,
        required this.usernameController,
        required this.passwordController,
        required this.passwordConfirmController,
     });

    @override
    State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
    late bool _passwordVisible;
    late bool _confirmedPasswordVisible;

    @override
    void initState() {
      super.initState();
        _passwordVisible = true;
        _confirmedPasswordVisible = true;
      }

    @override
    void dispose() {
        widget.emailController.dispose();
        widget.passwordController.dispose();
        widget.passwordController.dispose();
        widget.passwordConfirmController.dispose();
        super.dispose();
  }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            body: SingleChildScrollView(
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                            SizedBox(height: 28),
                            Text(
                                "Holbegram",
                                style: TextStyle(fontFamily: "Billabong", fontSize: 50),
                            ),
                            Image.asset("assets/images/logo.webp", width: 80, height: 60),
                            Container(
                                child:
                                    Text(
                                        "Sign up to see photos and videos from your friends.",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 25),
                                    ),
                            ),
                            Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Column(
                                    children: <Widget>[
                                        SizedBox(height: 28),
                                        TextFieldInput(
                                            controller: widget.emailController,
                                            ispassword: false,
                                            hintText: "Email",
                                            keyboardType: TextInputType.emailAddress,
                                        ),
                                        SizedBox(height: 24),
                                        TextFieldInput(
                                            controller: widget.usernameController,
                                            ispassword: false,
                                            hintText: "Full Name",
                                            keyboardType: TextInputType.text,
                                        ),
                                        SizedBox(height: 24),
                                        TextFieldInput(
                                            controller: widget.passwordController,
                                            ispassword: !_passwordVisible,
                                            hintText: "Password",
                                            keyboardType: TextInputType.visiblePassword,
                                            suffixIcon: IconButton(
                                                alignment: Alignment(-1.0, 1.0),
                                                icon: Icon(
                                                    _passwordVisible ? Icons.visibility : Icons.visibility_off,
                                                ),
                                                onPressed: () {
                                                    setState(() {
                                                        _passwordVisible = !_passwordVisible;
                                                    });
                                                },
                                            ),
                                        ),
                                        SizedBox(height: 28),
                                        TextFieldInput(
                                            controller: widget.passwordConfirmController,
                                            ispassword: !_confirmedPasswordVisible,
                                            hintText: "Confirm Password",
                                            keyboardType: TextInputType.visiblePassword,
                                            suffixIcon: IconButton(
                                                alignment: Alignment(-1.0, 1.0),
                                                icon: Icon(
                                                    _confirmedPasswordVisible ? Icons.visibility : Icons.visibility_off,
                                                ),
                                                onPressed: () {
                                                    setState(() {
                                                        _confirmedPasswordVisible = !_confirmedPasswordVisible;
                                                    });
                                                },
                                            ),
                                        ),
                                        SizedBox(height: 28),
                                        SizedBox(
                                            height: 48,
                                            width: double.infinity,
                                            child: ElevatedButton(
                                                style: ButtonStyle(
                                                    backgroundColor: WidgetStateProperty.all<Color>(
                                                        Color.fromARGB(218, 226, 37, 24),
                                                    ),
                                                ),
                                                onPressed: () {
                                                    String email = widget.emailController.text;
                                                    String password = widget.passwordController.text;
                                                    String username = widget.usernameController.text;
                                                    
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(builder: (context) => AddPicture(
                                                        email: email, password: password, username: username
                                                        )),
                                                    );
                                                },
                                                child: Text(
                                                    "Sign up",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                    ),
                                                ),
                                            ),
                                        ),
                                        SizedBox(height: 24),
                                        Divider(
                                            thickness: 2,
                                        ),
                                        Padding(
                                            padding: EdgeInsets.symmetric(vertical: 12),
                                            child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: <Widget> [
                                                    Text("Have an account?"),
                                                    TextButton(
                                                        onPressed: () {
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(builder: (context) => LoginScreen(
                                                                    emailController: TextEditingController(),
                                                                    passwordController: TextEditingController(),
                                                                )),
                                                            );
                                                        },
                                                        child: Text(
                                                            "Log in",
                                                            style: TextStyle(   
                                                                fontWeight: FontWeight.bold,
                                                                color: Color.fromARGB(218, 226, 37, 24),
                                                            ),
                                                        ),

                                                    ),
                                                ],
                                            ),
                                        ),
                                        SizedBox(height: 10),
                                    ],
                                ),
                            ),
                        ],
                ),
            ),
        );
    }
}
