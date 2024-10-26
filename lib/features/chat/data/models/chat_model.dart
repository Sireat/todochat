// lib/data/models/chat_model.dart
import '../../domain/entities/chat_entity.dart';

class ChatModel {
  final String id;
  final String userId;
  final String message;
  final DateTime timestamp;

  ChatModel({
    required this.id,
    required this.userId,
    required this.message,
    required this.timestamp,
  });

  factory ChatModel.fromMap(Map<dynamic, dynamic> map) {
    return ChatModel(
      id: map['id'],
      userId: map['userId'],
      message: map['message'],
      timestamp: DateTime.parse(map['timestamp']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'message': message,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  ChatEntity toEntity() {
    return ChatEntity(
      id: id,
      userId: userId,
      message: message,
      timestamp: timestamp,
    );
  }

  factory ChatModel.fromEntity(ChatEntity entity) {
    return ChatModel(
      id: entity.id,
      userId: entity.userId,
      message: entity.message,
      timestamp: entity.timestamp,
    );
  }
}
