// lib/data/repositories/chat_repository.dart
import 'package:firebase_database/firebase_database.dart';
import '../../domain/entities/chat_entity.dart';
import '../models/chat_model.dart';

class ChatRepository {
  final DatabaseReference dbRef = FirebaseDatabase.instance.ref('chats');

  Future<void> sendMessage(ChatEntity chat) async {
    final chatModel = ChatModel.fromEntity(chat);
    await dbRef.child(chatModel.id).set(chatModel.toMap());
  }

  Future<List<ChatEntity>> getMessages(String chatId) async {
    final snapshot = await dbRef.child(chatId).once(); // Get the initial snapshot
    final List<ChatEntity> messages = [];

    // Check if there are any messages in the snapshot
    if (snapshot.snapshot.value != null) {
      // Use snapshot.children to access the children of the snapshot
      final children = snapshot.snapshot.children;
      for (var child in children) {
        messages.add(ChatModel.fromMap(child.value as Map).toEntity());
      }
    }
    return messages;
  }

  // Stream for real-time updates
  Stream<List<ChatEntity>> messagesStream(String chatId) {
    return dbRef.child(chatId).onValue.map((DatabaseEvent event) {
      final List<ChatEntity> messages = [];
      final snapshot = event.snapshot;

      if (snapshot.value != null) {
        final children = snapshot.children;
        for (var child in children) {
          messages.add(ChatModel.fromMap(child.value as Map).toEntity());
        }
      }
      return messages;
    });
  }
}
