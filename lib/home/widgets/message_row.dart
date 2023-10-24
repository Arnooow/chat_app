import 'package:chatapp/models/message.dart';
import 'package:flutter/material.dart';

class MessageRow extends StatelessWidget {
  const MessageRow({super.key, required this.message});

  final Message message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: message.user.color,
            child: Text(message.user.userName),
          ),
          const SizedBox(
            width: 8,
          ),
          Container(
              height: 50,
              decoration: BoxDecoration(
                  color: message.user.color,
                  borderRadius: const BorderRadius.all(Radius.circular(20))),
              child: Center(child: Text(message.message)))
        ],
      ),
    );
  }
}
