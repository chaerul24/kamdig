import 'package:equatable/equatable.dart';

class MessageModel extends Equatable {
  final String day;
  final String message;
  final bool read;
  final String receiver;
  final String sender;
  final String timestamp;
  final String? fileUrl; // URL file yang diunggah ke Firebase Storage

  const MessageModel({
    required this.day,
    required this.message,
    required this.read,
    required this.receiver,
    required this.sender,
    required this.timestamp,
    this.fileUrl, // opsional, hanya ada jika ada file
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      day: json['day'] ?? '',
      message: json['message'] ?? '',
      read: json['read'] ?? false,
      receiver: json['receiver'] ?? '',
      sender: json['sender'] ?? '',
      timestamp: json['timestamp'] ?? '',
      fileUrl: json['fileUrl'], // mengakses URL file jika ada
    );
  }

  Map<String, dynamic> toJson() => {
    'day': day,
    'message': message,
    'read': read,
    'receiver': receiver,
    'sender': sender,
    'timestamp': timestamp,
    'fileUrl': fileUrl, // simpan URL file
  };

  @override
  List<Object> get props => [
    day,
    message,
    read,
    receiver,
    sender,
    timestamp,
    fileUrl ?? '',
  ];
}

class ChatModel extends Equatable {
  final String receiver;
  final String sender;
  final Map<String, MessageModel> messages;

  const ChatModel({
    required this.receiver,
    required this.sender,
    required this.messages,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    final messagesJson = json['messages'] as Map<String, dynamic>;
    final messages = messagesJson.map(
      (key, value) => MapEntry(key, MessageModel.fromJson(value)),
    );

    return ChatModel(
      receiver: json['receiver'] ?? '',
      sender: json['sender'] ?? '',
      messages: messages,
    );
  }

  Map<String, dynamic> toJson() => {
    'receiver': receiver,
    'sender': sender,
    'messages': messages.map((key, value) => MapEntry(key, value.toJson())),
  };

  @override
  List<Object> get props => [receiver, sender, messages];
}
