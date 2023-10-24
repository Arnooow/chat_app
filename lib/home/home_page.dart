import 'dart:convert';

import 'package:chatapp/home/widgets/input_row.dart';
import 'package:chatapp/home/widgets/message_row.dart';
import 'package:chatapp/models/message.dart';
import 'package:chatapp/models/user.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final List<Message> _messages = [];
  User user1 = User("1", Colors.yellow, "A");
  User user2 = User("2", Colors.blue, "B");

  Future<void> saveUser(User newUser) async {
    final SharedPreferences prefs = await _prefs;
    final newUserEncode = jsonEncode(newUser.toJson());
    await prefs.setString(newUser.id, newUserEncode);
  }

  Future<User> getUser(String id) async {
    final SharedPreferences prefs = await _prefs;
    final userEncode = prefs.getString(id);
    if (userEncode != null) {
      final userDecode = jsonDecode(userEncode);
      final user = User.fromJson(userDecode);
      return user;
    } else {
      throw Exception();
    }
  }

  Future<void> getAllUsers() async {
    try {
      user1 = await getUser(user1.id);
      user2 = await getUser(user2.id);
      setState(() {});
    } catch (_) {}
  }

  @override
  void initState() {
    getAllUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Talk to myself"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: _messages.length,
                  itemBuilder: (context, index) {
                    return MessageRow(message: _messages[index]);
                  }),
            ),
            const Spacer(),
            InputRow(
              user: user1,
              onPressed: (newText) {
                setState(() {
                  final newMessage = Message(newText, user1);
                  _messages.add(newMessage);
                });
              },
              onTap: (newUser) async {
                await saveUser(newUser);
                setState(() {
                  user1 = newUser;
                });
              },
            ),
            const SizedBox(
              height: 8,
            ),
            InputRow(
              user: user2,
              onPressed: (newText) {
                setState(() {
                  final newMessage = Message(newText, user2);
                  _messages.add(newMessage);
                });
              },
              onTap: (newUser) async {
                await saveUser(newUser);
                setState(() {
                  user2 = newUser;
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
