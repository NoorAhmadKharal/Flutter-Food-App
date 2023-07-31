import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_flutter_app/main.dart';
import 'package:first_flutter_app/menu.dart';
import 'package:first_flutter_app/signup.dart';
import 'package:flutter/material.dart';

class Hello extends StatefulWidget {
  const Hello({super.key});

  @override
  State<Hello> createState() => _HelloState();
}

class _HelloState extends State<Hello> {
  String? gender;
  final emailController = TextEditingController();
  final passController = TextEditingController();

  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: const Text("Login Page"),
        centerTitle: true,
      ),
      drawer: const Drawer(),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.blue,
        child: Padding(
          padding: const EdgeInsets.only(top: 80.0),
          child: Form(
              key: formkey,
              child: Column(
                children: [
                  TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    style: const TextStyle(color: Colors.black),
                    decoration: const InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: "Email Adress",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Email Required';
                      }
                      if (!value.contains('@')) {
                        return "Enter a valid email";
                      }
                    },
                  ),
                  TextFormField(
                    controller: passController,
                    keyboardType: TextInputType.text,
                    style: const TextStyle(color: Colors.black),
                    obscureText: true,
                    decoration: const InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: "password",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'PAssword required';
                      }
                      if (value.length < 8) {
                        return 'worng password';
                      }
                    },
                  ),
                  // // Row(
                  // //   mainAxisAlignment: MainAxisAlignment.start,
                  // //   children: [
                  // //     DropdownButton(
                  // //       value: gender,
                  // //       alignment: AlignmentDirectional.centerStart,
                  // //       hint: const Text("Gender"),
                  // //       items: const [
                  // //         DropdownMenuItem(value: "MALE", child: Text("MALE")),
                  // //         DropdownMenuItem(
                  // //           value: "Female",
                  // //           child: Text("Female"),
                  // //         ),
                  // //         DropdownMenuItem(value: "Other", child: Text("Other"))
                  // //       ],
                  // //       onChanged: onChanged,
                  // //     ),
                  // //   ],
                  // ),
                  ElevatedButton(
                      onPressed: () {
                        if (formkey.currentState!.validate()) {
                          loginUser(emailController.text, passController.text);
                        }
                      },
                      child: const Text("submit"))
                ],
              )),
        ),
      ),
    );
  }

  void onChanged(String? stringA) {
    setState(() {
      gender = stringA;
    });
  }

  Future<void> loginUser(String email, String password) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Proceed with user authentication
      print('User authenticated: ${userCredential.user!.uid}');
      // ignore: use_build_context_synchronously
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                title: const Text("ALrt box"),
                content: const Text("Are you want to submit "),
                actions: [
                  ElevatedButton(
                      onPressed: () {
                        print("successful login");
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DisplayMenu()));
                      },
                      child: const Text("ok"))
                ],
              ));
    } catch (e) {
      // Handle login errors
      print('Login error: $e');
    }
  }
}
