import 'package:bcrypt/bcrypt.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_flutter_app/firstprogram.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String? gender;
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final firstnameController = TextEditingController();
  final lastnameController = TextEditingController();
  final phonenumberController = TextEditingController();
  final confrmpassController = TextEditingController();
  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: const Text("Signup Page"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
            color: Colors.green,
            padding: const EdgeInsets.all(10.0),
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            // color: Colors.red,
            child: Form(
                key: formkey,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: firstnameController,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          hintText: "First Name",
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'name required';
                          }
                        },
                      ),
                      TextFormField(
                        controller: lastnameController,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          hintText: "Last  Name",
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Name required';
                          }
                        },
                      ),
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          hintText: "Email Adress",
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
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
                        obscureText: true,
                        decoration: const InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          hintText: "password",
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'PAssword required';
                          }
                          if (value.length < 8) {
                            return 'PAssword Should be atlest 8 characters';
                          }
                        },
                      ),
                      TextFormField(
                        controller: confrmpassController,
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        decoration: const InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          hintText: " Confirm password",
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'PAssword required';
                          }
                          if (value.length < 8) {
                            return 'PAssword Should be atlest 8 characters';
                          }
                          if (passController.text !=
                              confrmpassController.text) {
                            return 'password not same';
                          }
                        },
                      ),
                      TextFormField(
                        controller: phonenumberController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            hintText: "Phone Number",
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)))),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Phone Number Required';
                          }
                          if (value.length < 11) {
                            return 'phone number  Should be atlest 11 characters';
                          }
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          DropdownButton(
                            value: gender,
                            alignment: AlignmentDirectional.centerStart,
                            hint: const Text("Gender"),
                            items: const [
                              DropdownMenuItem(
                                  value: "MALE", child: Text("MALE")),
                              DropdownMenuItem(
                                value: "Female",
                                child: Text("Female"),
                              ),
                              DropdownMenuItem(
                                  value: "Other", child: Text("Other"))
                            ],
                            onChanged: onChanged,
                          ),
                        ],
                      ),
                      ElevatedButton(
                          onPressed: () {
                            if (formkey.currentState!.validate()) {
                              addUser(
                                  firstname: firstnameController.text,
                                  lastname: lastnameController.text,
                                  email: emailController.text,
                                  password: passController.text,
                                  phone: phonenumberController.text);
                              showDialog(
                                  context: context,
                                  builder: (_) => AlertDialog(
                                        title: const Text("ALrt box"),
                                        content: const Text(
                                            "Are you want to submit "),
                                        actions: [
                                          ElevatedButton(
                                              onPressed: () async {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const Hello()));
                                              },
                                              child: const Text("ok"))
                                        ],
                                      ));
                            }
                          },
                          child: const Text("submit"))
                    ],
                  ),
                ))),
      ),
    );
  }

  void onChanged(String? stringA) {
    setState(() {
      gender = stringA;
    });
  }

  Future addUser(
      {required String firstname,
      required String lastname,
      required String email,
      required String password,
      required String phone}) async {
    UserCredential userCredential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    await userCredential.user!.updateDisplayName(email);
    await userCredential.user!.updatePassword(password);

    DocumentReference documentReference = await FirebaseFirestore.instance
        .collection('User')
        .add({
      'firstname': firstname,
      'lastname': lastname,
      'email': email,
      'phone': phone
    });
    final taskId = documentReference.id;
    await FirebaseFirestore.instance
        .collection('User')
        .doc(taskId)
        .update({'id': taskId});
  }
}
