import 'package:first_flutter_app/firstprogram.dart';
import 'package:first_flutter_app/menu.dart';
import 'package:first_flutter_app/signup.dart';
import 'package:flutter/material.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: const Text("Food App"),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.blue,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            const Text(
              "Food Application ",
              style: TextStyle(color: Colors.white, fontSize: 32),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Hello()));
                },
                child: const Text(
                  "login",
                  style: TextStyle(color: Colors.white, fontSize: 30),
                )),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignUp()));
                },
                child: const Text(
                  "Signup",
                  style: TextStyle(color: Colors.white, fontSize: 30),
                )),
          ],
        ),
      ),
    );
  }
}
