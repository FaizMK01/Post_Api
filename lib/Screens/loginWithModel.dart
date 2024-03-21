import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../Models/user_model.dart';
import 'homeScreen.dart';

class LoginWithModel extends StatefulWidget {
  const LoginWithModel({super.key});

  @override
  State<LoginWithModel> createState() => _LoginWithModelState();
}

class _LoginWithModelState extends State<LoginWithModel> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  UserModel userModel = UserModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.teal,
        title: Text("LoginWithModel"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(
                hintText: "Email",
              ),
            ),
            TextFormField(
              controller: passwordController,
              decoration: const InputDecoration(
                hintText: "Password",
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            SizedBox(
              width: 200,
              height: 40,
              child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      postData(emailController.text, passwordController.text).then((value)
                      {
                          userModel = value!;
                         /* Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen(
                           // token:userModel.token.toString()
                          ),
                          ),
                          );*/
                        });
                    });
                  },
                  child: const Text("Login"),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<UserModel?> postData(String email, String password) async {
    try {
      final response = await http.post(Uri.parse('https://reqres.in/api/login'),
          body: {"email": email, "password": password});
      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        UserModel model = UserModel.fromJson(data);
        return model;
      }
    } catch (e) {
      print(e.toString());
    }

    return null;
  }
}
