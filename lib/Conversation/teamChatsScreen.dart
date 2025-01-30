import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart'; //  تنسيق الوقت

import 'package:ShiftStart/colors.dart';

import 'chatProvider.dart';
import 'chatScreen.dart';

class TeamChatsScreen extends StatefulWidget {
  final String teamId;

  TeamChatsScreen({required this.teamId});

  @override
  _TeamChatsScreenState createState() => _TeamChatsScreenState();
}

class _TeamChatsScreenState extends State<TeamChatsScreen> {
  TextEditingController searchController = TextEditingController();
  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    final chatProvider = Provider.of<ChatProvider>(context);
    final chats = chatProvider.chats
        .where((chat) => chat.teamId == widget.teamId)
        .toList();
    final onlineUsers = chatProvider.chats
        .expand((chat) => chat.participants)
        .where((user) => chatProvider.isUserOnline(user))
        .toSet()
        .toList();

    List<Chat> filteredChats = chats.where((chat) {
      return chat.participants.any(
              (p) => p.toLowerCase().contains(searchQuery.toLowerCase())) ||
          chat.messages.any((msg) =>
              msg.content.toLowerCase().contains(searchQuery.toLowerCase()));
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("Team Chats"),
        backgroundColor: AppColors.lightButton,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: ChatSearchDelegate(chats));
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _buildOnlineUsers(onlineUsers, chatProvider),
          Expanded(
            child: ListView.builder(
              itemCount: filteredChats.length,
              itemBuilder: (context, index) {
                final chat = filteredChats[index];
                return _buildChatTile(chatProvider, chat);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showCreateChatDialog(context, chatProvider),
        backgroundColor: AppColors.lightButton,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  //  عرض المستخدمين المتصلين مع حالة الاتصال
  Widget _buildOnlineUsers(
      List<String> onlineUsers, ChatProvider chatProvider) {
    return Container(
      height: 80,
      padding: EdgeInsets.all(10),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: onlineUsers.length,
        itemBuilder: (context, index) {
          final user = onlineUsers[index];
          final lastSeen = chatProvider.getLastSeen(user);
          String status = lastSeen == null
              ? "Online"
              : "Last seen: ${DateFormat('hh:mm a').format(lastSeen)}";

          return Column(
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    backgroundColor: AppColors.lightSecondaryText,
                    child: Text(user[0].toUpperCase(),
                        style: TextStyle(color: Colors.white)),
                  ),
                  if (chatProvider.isUserOnline(user))
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: CircleAvatar(
                        backgroundColor: Colors.green,
                        radius: 5,
                      ),
                    ),
                ],
              ),
              SizedBox(height: 5),
              Text(user, style: TextStyle(fontSize: 12)),
              Text(status, style: TextStyle(fontSize: 10, color: Colors.grey)),
            ],
          );
        },
      ),
    );
  }

  //  تصميم عنصر المحادثة مع عرض عدد الرسائل غير المقروءة
  Widget _buildChatTile(ChatProvider chatProvider, Chat chat) {
    int unreadCount = chatProvider.getUnreadMessageCount(
        chat.chatId, chat.participants.first);
    final lastMessage = chat.messages.isNotEmpty ? chat.messages.last : null;

    return ListTile(
      leading: CircleAvatar(
        backgroundColor: AppColors.lightSecondaryText,
        child: Text(chat.participants.first[0].toUpperCase(),
            style: TextStyle(color: Colors.white)),
      ),
      title: Text(
        chat.participants.join(", "),
        style: TextStyle(
            fontWeight: FontWeight.bold, color: AppColors.lightPrimaryText),
      ),
      subtitle: lastMessage != null
          ? Text(
              lastMessage.isImage ? "[Image]" : lastMessage.content,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: AppColors.lightSecondaryText),
            )
          : Text("No messages",
              style: TextStyle(color: AppColors.lightSecondaryText)),
      trailing: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (lastMessage != null)
            Text(
              DateFormat('hh:mm a').format(lastMessage.timestamp),
              style: TextStyle(color: AppColors.lightSecondaryText),
            ),
          if (unreadCount > 0)
            CircleAvatar(
              radius: 10,
              backgroundColor: Colors.red,
              child: Text("$unreadCount",
                  style: TextStyle(fontSize: 12, color: Colors.white)),
            ),
        ],
      ),
      onTap: () {
        chatProvider.markMessagesAsRead(chat.chatId, chat.participants.first);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatScreen(
              chatId: chat.chatId,
              chatName: chat.participants.join(", "),
              userId: chat.participants.first,
            ),
          ),
        );
      },
    );
  }

  //  نافذة إنشاء محادثة جديدة
  void _showCreateChatDialog(BuildContext context, ChatProvider chatProvider) {
    TextEditingController participantController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Create Chat"),
          content: TextField(
            controller: participantController,
            decoration: InputDecoration(
                hintText: "Enter participant names (comma-separated)"),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                List<String> participants = participantController.text
                    .split(',')
                    .map((e) => e.trim())
                    .toList();
                if (participants.isNotEmpty) {
                  chatProvider.addChat(widget.teamId, participants);
                  Navigator.pop(context);
                }
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.lightButton),
              child: Text("Create", style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }
}

//  تحسين البحث ليشمل أسماء المشاركين والرسائل
class ChatSearchDelegate extends SearchDelegate {
  final List<Chat> chats;

  ChatSearchDelegate(this.chats);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [IconButton(icon: Icon(Icons.clear), onPressed: () => query = "")];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back), onPressed: () => close(context, null));
  }

  @override
  Widget buildResults(BuildContext context) {
    List<Chat> filteredChats = chats.where((chat) {
      return chat.participants
              .any((p) => p.toLowerCase().contains(query.toLowerCase())) ||
          chat.messages.any(
              (msg) => msg.content.toLowerCase().contains(query.toLowerCase()));
    }).toList();

    return ListView.builder(
      itemCount: filteredChats.length,
      itemBuilder: (context, index) {
        final chat = filteredChats[index];
        return ListTile(
          title: Text(chat.participants.join(", ")),
          subtitle: chat.messages.isNotEmpty
              ? Text(chat.messages.last.content)
              : Text("No messages"),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ChatScreen(
                      chatId: chat.chatId,
                      chatName: chat.participants.join(", "),
                      userId: chat.participants.first)),
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return buildResults(context);
  }
}
