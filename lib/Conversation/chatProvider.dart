import 'package:flutter/material.dart';

class Message {
  String content;
  String sender;
  DateTime timestamp;
  bool isImage;
  bool isRead;

  Message({
    required this.content,
    required this.sender,
    required this.timestamp,
    this.isImage = false,
    this.isRead = false,
  });
}

class Chat {
  String chatId;
  String teamId;
  List<String> participants;
  List<Message> messages;
  Map<String, DateTime> lastSeen; //  تخزين آخر ظهور لكل مستخدم

  Chat({
    required this.chatId,
    required this.messages,
    required this.teamId,
    required this.participants,
    required this.lastSeen,
  });
}

class ChatProvider extends ChangeNotifier {
  List<Chat> _chats = [];
  List<Chat> get chats => _chats;

  Map<String, bool> _userStatus = {}; //  حالة المستخدم (متصل/غير متصل)

  //  إرجاع حالة المستخدم (متصل أو لا)
  bool isUserOnline(String userId) {
    return _userStatus[userId] ?? false;
  }

  //  تحديث حالة المستخدم
  void updateUserStatus(String userId, bool isOnline) {
    _userStatus[userId] = isOnline;
    if (!isOnline) {
      _updateLastSeen(userId);
    }
    notifyListeners();
  }

  //  تحديث آخر ظهور للمستخدم
  void _updateLastSeen(String userId) {
    for (var chat in _chats) {
      if (chat.participants.contains(userId)) {
        chat.lastSeen[userId] = DateTime.now();
      }
    }
    notifyListeners();
  }

  //  إرجاع آخر ظهور للمستخدم
  DateTime? getLastSeen(String userId) {
    for (var chat in _chats) {
      if (chat.lastSeen.containsKey(userId)) {
        return chat.lastSeen[userId];
      }
    }
    return null;
  }

  //  إضافة محادثة جديدة
  void addChat(String teamId, List<String> participants) {
    final newChat = Chat(
      chatId: DateTime.now().toString(),
      teamId: teamId,
      participants: participants,
      messages: [],
      lastSeen: {for (var p in participants) p: DateTime.now()},
    );
    _chats.add(newChat);
    notifyListeners();
  }

  //  حذف محادثة
  void removeChat(String chatId) {
    _chats.removeWhere((chat) => chat.chatId == chatId);
    notifyListeners();
  }

  //  إرسال رسالة مع timestamp
  void sendMessage(String chatId, String sender, String content,
      {bool isImage = false}) {
    final chatIndex = _chats.indexWhere((chat) => chat.chatId == chatId);
    if (chatIndex != -1) {
      _chats[chatIndex].messages.add(
            Message(
                content: content,
                sender: sender,
                timestamp: DateTime.now(),
                isImage: isImage),
          );
      notifyListeners();
    }
  }

  //  تحديث حالة الرسائل المقروءة
  void markMessagesAsRead(String chatId, String userId) {
    final chatIndex = _chats.indexWhere((chat) => chat.chatId == chatId);
    if (chatIndex != -1) {
      for (var message in _chats[chatIndex].messages) {
        if (message.sender != userId) {
          message.isRead = true;
        }
      }
      notifyListeners();
    }
  }

  //  البحث داخل محادثة معينة
  List<Message> searchMessages(String chatId, String query) {
    final chat = _chats.firstWhere((chat) => chat.chatId == chatId,
        orElse: () => Chat(
            chatId: '',
            messages: [],
            teamId: '',
            participants: [],
            lastSeen: {}));
    return chat.messages
        .where((msg) => msg.content.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  int getUnreadMessageCount(String chatId, String userId) {
    final chat = _chats.firstWhere((chat) => chat.chatId == chatId,
        orElse: () =>
            Chat(chatId: "", messages: [], teamId: "", participants: [],lastSeen: {}));
    return chat.messages
        .where((msg) => !msg.isRead && msg.sender != userId)
        .length;
  }
}
