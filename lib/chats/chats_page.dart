import 'package:messenger/chats/chats_bloc.dart';
import 'package:messenger/main.dart';
import 'package:messenger/chats/chat_page.dart';
import 'package:messenger/messages/messages_bloc.dart';
import 'package:messenger/messages/messages_repository.dart';
import 'package:messenger/navigator.dart';
import 'package:messenger/users/users_bloc.dart';

import '../users/users_repository.dart';
import 'chat.dart';

final TextEditingController searchController = TextEditingController();

class ChatsPage extends UI {
  const ChatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Messages'),
        actions: [
          IconButton(
            icon: CircleAvatar(
              child: '${context.of<MessagesBloc>().messages.length}'.text(),
            ),
            onPressed: () {
              context.of<NavigationController>().to(AllMessagesPage());
            },
          ),
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                onTap: () {
                  context.of<NavigationController>().to(SettingsPage());
                },
                child: Row(
                  children: [
                    Icon(Icons.settings).pad(),
                    Text('settings').pad(),
                  ],
                ),
              ),
              PopupMenuItem(
                onTap: context.of<ThemeModeController>().toggleThemeMode,
                child: Row(
                  children: [
                    Icon(
                      switch (context.of<ThemeModeController>().themeMode) {
                        ThemeMode.system => Icons.circle,
                        ThemeMode.dark => Icons.dark_mode,
                        ThemeMode.light => Icons.light_mode,
                      },
                    ).pad(),
                    context
                        .of<ThemeModeController>()
                        .themeMode
                        .name
                        .text()
                        .pad(),
                  ],
                ),
              ),
            ],
          ).pad(),
        ],
      ),
      body: Column(
        children: [
          SearchBar(
            controller: searchController,
            hintText: 'Search or ask AI...',
          ).pad(),
          Expanded(
            child: ListView.builder(
              itemCount: context.of<ChatsBloc>().chats.length,
              itemBuilder: (context, index) {
                final chat = context.of<ChatsBloc>().chats[index];
                return ChatTile(
                  chat: chat,
                  onTap: () => context
                      .of<NavigationController>()
                      .to(ChatPage(chat: chat)),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // context.of<ChatsBloc>().put(Chat());
          final user = await context.of<NavigationController>().dialog<User>(
                AlertDialog(
                  title: const Text('CHAT WITH'),
                  content: Column(
                    children: context.of<UsersController>().users.map(
                      (user) {
                        return ListTile(
                          title: user.email.text(),
                          onTap: () {
                            context.of<NavigationController>().back(user);
                          },
                        );
                      },
                    ).toList(),
                  ),
                ),
              );
          if (user != null) {
            context.of<ChatsBloc>().put(
                  Chat()..sender.target = user,
                );
          }
        },
        child: const Icon(Icons.message),
      ),
    );
  }
}

class AllMessagesPage extends UI {
  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Messages'),
      ),
      body: ListView.builder(
        itemCount: context.of<MessagesBloc>().messages.length,
        itemBuilder: (_, index) {
          final Message message =
              context.of<MessagesBloc>().messages.elementAt(index);
          return ListTile(
            title: Column(
              children: [
                message.id.text(),
                message.content.text(),
                PopupMenuButton(
                  itemBuilder: (context) => context.of<ChatsBloc>().chats.map(
                    (chat) {
                      return PopupMenuItem(
                        value: chat,
                        child: chat.text(),
                      );
                    },
                  ).toList(),
                  onSelected: (value) {
                    messagesRepository.put(message..chat.target = value);
                  },
                ),
                message.chat.target.text(),
                (message.sender.target?.email).text(),
                (message.receiver.target?.email).text(),
              ],
            ),
          );
        },
      ),
    );
  }
}

class ChatTile extends UI {
  final Chat chat;
  final VoidCallback onTap;

  const ChatTile({
    super.key,
    required this.chat,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(child: Icon(Icons.person)),
      title: Text(chat.name),
      subtitle: chat.messages.firstOrNull?.content.text(),
      onTap: onTap,
    );
  }
}
