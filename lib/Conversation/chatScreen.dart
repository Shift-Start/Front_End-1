import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart'; //  تنسيق الوقت

import 'package:ShiftStart/colors.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'chatProvider.dart';

class ChatScreen extends StatefulWidget {
  final String chatId;
  final String chatName;
  final String userId;

  ChatScreen({required this.chatId, required this.chatName, required this.userId});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController messageController = TextEditingController();
  TextEditingController searchController = TextEditingController(); //  للبحث
  final ImagePicker _picker = ImagePicker();
  File? _image;
  String searchQuery = "";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ChatProvider>(context, listen: false)
          .markMessagesAsRead(widget.chatId, widget.userId); // تحديث الرسائل كمقروءة
    });
  }

  @override
  Widget build(BuildContext context) {
    final chatProvider = Provider.of<ChatProvider>(context);
    final chat = chatProvider.chats.firstWhere((chat) => chat.chatId == widget.chatId);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    //  التحقق من حالة المستخدم أو آخر ظهور
    bool isOnline = chatProvider.isUserOnline(widget.chatName);
    DateTime? lastSeen = chatProvider.getLastSeen(widget.chatName);
    String lastSeenText = isOnline
        ? "Online"
        : (lastSeen != null ? "Last seen: ${DateFormat('hh:mm a').format(lastSeen)}" : "Offline");

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: AppColors.lightSecondaryText,
              child: Text(widget.chatName[0].toUpperCase()),
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.chatName, style: TextStyle(fontWeight: FontWeight.bold)),
                Text(lastSeenText, style: TextStyle(fontSize: 12, color: Colors.green)),
              ],
            ),
          ],
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          Expanded(
            child: ListView.builder(
              itemCount: chat.messages.length,
              itemBuilder: (context, index) {
                final message = chat.messages[index];
                final isMe = message.sender == widget.userId;

                //  عرض الرسائل المطابقة للبحث فقط
                if (searchQuery.isNotEmpty && !message.content.toLowerCase().contains(searchQuery.toLowerCase())) {
                  return SizedBox.shrink();
                }

                return Align(
                  alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: isMe ? Theme.of(context).primaryColor : AppColors.lightCard,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (message.isImage)
                          Image.file(File(message.content), width: 200)
                        else
                          Text(message.content, style: TextStyle(color: Colors.white)),
                        SizedBox(height: 5),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              DateFormat('hh:mm a').format(message.timestamp), //  عرض وقت الإرسال
                              style: TextStyle(fontSize: 10, color: Colors.grey),
                            ),
                            if (isMe)
                              Icon(
                                message.isRead ? Icons.done_all : Icons.check, //  علامة قراءة الرسائل
                                size: 16,
                                color: message.isRead ? Colors.blue : Colors.grey,
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          _buildMessageInput(chatProvider),
        ],
      ),
    );
  }

  //  شريط البحث داخل المحادثة
  Widget _buildSearchBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: TextField(
        controller: searchController,
        decoration: InputDecoration(
          hintText: "Search messages...",
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        ),
        onChanged: (query) {
          setState(() {
            searchQuery = query;
          });
        },
      ),
    );
  }

  Widget _buildMessageInput(ChatProvider chatProvider) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      color: AppColors.lightBackground,
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.camera_alt, color: AppColors.lightSecondaryText),
            onPressed: () async {
              final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
              if (pickedFile != null) {
                setState(() {
                  _image = File(pickedFile.path);
                });
                chatProvider.sendMessage(widget.chatId, widget.userId, pickedFile.path, isImage: true);
              }
            },
          ),
          Expanded(
            child: TextField(
              controller: messageController,
              decoration: InputDecoration(
                hintText: "Type a message...",
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send, color:Theme.of(context).primaryColor),
            onPressed: () {
              if (messageController.text.isNotEmpty) {
                chatProvider.sendMessage(
                  widget.chatId,
                  widget.userId,
                  messageController.text,
                );
                messageController.clear();
              }
            },
          ),
        ],
     ),
);
}
}
