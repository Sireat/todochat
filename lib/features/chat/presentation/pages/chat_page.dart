// lib/presentation/pages/chat_page.dart
import 'package:flutter/material.dart';
import '../../data/repositories/chat_repository.dart';
import '../../domain/entities/chat_entity.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController();
  late ChatRepository _chatRepository;
  List<ChatEntity> _messages = [];

  @override
  void initState() {
    super.initState();
    _chatRepository = ChatRepository();
    // Load messages on init (can improve with stream)
    _loadMessages();
  }

  Future<void> _loadMessages() async {
    final messages = await _chatRepository.getMessages('chatId'); // Use actual chat ID
    setState(() {
      _messages = messages;
    });
  }

  void _sendMessage() {
    final message = _controller.text.trim();
    if (message.isNotEmpty) {
      final chat = ChatEntity(
        id: DateTime.now().toString(), // Use unique ID
        userId: 'userId', // Replace with actual user ID
        message: message,
        timestamp: DateTime.now(),
      );
      _chatRepository.sendMessage(chat);
      _controller.clear();
      _loadMessages(); // Reload messages
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chat')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                return ListTile(
                  title: Text(msg.message),
                  subtitle: Text(msg.userId), // Show user ID or name
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(hintText: 'Type a message'),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
