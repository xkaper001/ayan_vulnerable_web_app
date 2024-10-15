import 'dart:developer';
import 'dart:io';
import 'package:ayan_vulnerable_web_app/api.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: Scaffold(
          appBar: AppBar(
            title: const Text("Test Vulnerable App"),
            centerTitle: true,
          ),
          body: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 4,
                child: UserPanel(
                    usernameController: usernameController,
                    passwordController: passwordController),
              ),
              const RightColumn(),
            ],
          )),
    );
  }
}

class RightColumn extends StatefulWidget {
  const RightColumn({super.key});

  @override
  State<RightColumn> createState() => _RightColumnState();
}

class _RightColumnState extends State<RightColumn> {
  bool mfaSwitchValue = false;
  late File logFile;
  final apiHandle = API();

  @override
  void initState() {
    super.initState();
    logFile = File("logs.txt");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 4,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Text(
            "Admin Panel",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Enable MFA"),
              const SizedBox(width: 10),
              Switch(
                value: mfaSwitchValue,
                onChanged: (bool value) async {
                  await apiHandle.mfaEvent(value);
                  setState(() {
                    mfaSwitchValue = value;
                  });
                },
              )
            ],
          ),
          Spacer()
        ],
      ),
    );
  }
}

class UserPanel extends StatefulWidget {
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  const UserPanel({
    super.key,
    required this.usernameController,
    required this.passwordController,
  });

  @override
  State<UserPanel> createState() => UserPanelState();
}

class UserPanelState extends State<UserPanel> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Text(
          "User Panel",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(),
        TextField(
          controller: widget.usernameController,
          decoration: InputDecoration(
            hintText: "Username",
            labelText: "Enter your username",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            prefixIcon: const Icon(Icons.person),
          ),
        ),
        const SizedBox(height: 20),
        TextField(
          controller: widget.passwordController,
          obscureText: true,
          decoration: InputDecoration(
            hintText: "Password",
            labelText: "Enter your password",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            prefixIcon: const Icon(Icons.lock),
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          child: FilledButton(
            onPressed: () {
              // Handle the submit action
              final username = widget.usernameController.text;
              final password = widget.passwordController.text;
              // You can add your logic here
            },
            style: ButtonStyle(
              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            child: const Text(
              "Login",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Spacer(),
      ],
    );
  }
}
