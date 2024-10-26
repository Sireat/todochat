// lib/domain/entities/chat_entity.dart
class ChatEntity {
  final String id;
  final String userId;
  final String message;
  final DateTime timestamp;

  ChatEntity({
    required this.id,
    required this.userId,
    required this.message,
    required this.timestamp,
  });
}
