import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:post_api/Screens/homeScreen.dart';
import '../Models/user_model2.dart';

class CreateJob extends StatefulWidget {
  const CreateJob({super.key});

  @override
  State<CreateJob> createState() => _CreateJobState();
}

class _CreateJobState extends State<CreateJob> {
  late UserModel2 userModel2;

  TextEditingController nameController = TextEditingController();
  TextEditingController jobController = TextEditingController();

  Future<UserModel2?> postData(String name, String job) async {
    try {
      final response = await http.post(Uri.parse('https://reqres.in/api/users'),
          body: {"name": name, "job": job});
      var data = jsonDecode(response.body);

      if (response.statusCode == 201) {
        UserModel2 model2 = UserModel2.fromJson(data);
        return model2;
      }
    } catch (e) {
      print(e.toString());
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black26,
        title: const Text('Post Example 2'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(
                hintText: "name",
              ),
            ),
            TextFormField(
              controller: jobController,
              decoration: const InputDecoration(
                hintText: "job",
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
                  postData(nameController.text, jobController.text).then((value) {
                    if (value != null) {
                      setState(() {
                        userModel2 = value!;
                      });

                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return HomeScreen(
                            id: userModel2.id.toString(),
                            name: userModel2.name.toString(),
                            job: userModel2.job.toString(),
                          );
                        }),
                      );
                    } else {
                      // Handle error or show appropriate message
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Error"),
                            content: Text("Failed to create job."),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text("OK"),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  });
                },
                child: const Text("Create Job"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
