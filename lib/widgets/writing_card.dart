import 'package:flutter/material.dart';

class WritingCard extends StatelessWidget {
  final String topic;
  final Function(String) onTopicChanged;
  final VoidCallback onDelete;

  const WritingCard({
    super.key,
    required this.topic,
    required this.onTopicChanged,
    required this.onDelete,
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
                const Text(
                  'Writing Topic',
                  style: TextStyle(
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
                IconButton(
                  icon: const Icon(Icons.delete_outline),
                  onPressed: onDelete,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
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
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 12,
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