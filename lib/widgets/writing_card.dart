import 'package:flutter/material.dart';

class WritingCard extends StatelessWidget {
  final String topic;
  final Function(String) onTopicChanged;
  final VoidCallback onDelete;
  final int index;

  const WritingCard({
    super.key,
    required this.topic,
    required this.onTopicChanged,
    required this.onDelete,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  ' ${index + 1}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),

                ),
                Expanded(child: Container()),
                IconButton(
                  icon: const Icon(Icons.delete_outline),
                  onPressed: onDelete,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
            SizedBox(height: 10,),

            Row(
              children: [
                Text(
                  'Writing Topic ',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  ' *',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                  ),
                ),
                const Spacer(),

              ],
            ),
            const SizedBox(height: 8),
            TextField(
              controller: TextEditingController(text: topic)
                ..selection = TextSelection.fromPosition(
                  TextPosition(offset: topic.length),
                ),
              decoration: const InputDecoration(
                hintText: 'The writing topic has not been filled in',
                border: UnderlineInputBorder(),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 0,
                  vertical: 8,
                ),
              ),
              onChanged: onTopicChanged,
              maxLines: null,
            ),
          ],
        ),
      ),
    );
  }
} 