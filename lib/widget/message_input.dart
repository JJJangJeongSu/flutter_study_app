import 'package:flutter/material.dart';

class MessageField extends StatelessWidget {
  const MessageField({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Row(
        children: [
          const Flexible(child: TextField()),
          IconButton(onPressed: () {}, icon: const Icon(Icons.send))
        ],
      ),
    );
  }
}
