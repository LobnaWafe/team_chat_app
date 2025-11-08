import 'package:chats_app/features/chat/data/models/message_model.dart';
import 'package:chats_app/features/chat/presentation/view_models/chat_cubit/chat_cubit.dart';
import 'package:chats_app/features/chat/widgets/recive_message_container.dart';
import 'package:chats_app/features/chat/widgets/send_message_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatMessagesListView extends StatefulWidget {
  ChatMessagesListView({
    super.key,
    required this.senderEmail,
    required this.reciverEmail,
  });
  
  final String senderEmail;
  final String reciverEmail;

  @override
  State<ChatMessagesListView> createState() => _ChatMessagesListViewState();
}

class _ChatMessagesListViewState extends State<ChatMessagesListView> {
  @override
  void initState() {
    super.initState();
    
    // ✅ استخدم addPostFrameCallback لتأكد أن الـ Cubit جاهز
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ChatCubit>().getMessages(
        senderEmail: widget.senderEmail,
        reciverEmail: widget.reciverEmail,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatCubit, ChatState>(
      listener: (context, state) {
        // يمكنك إضافة أي listener إضافي هنا إذا needed
      },
      builder: (context, state) {
        // ✅ استخدم الـ state مباشرة بدلاً من متغير منفصل
        if (state is ChatSuccess) {
          return ListView.builder(
            itemCount: state.messages.length,
            reverse: true,
            itemBuilder: (context, index) {
              final message = state.messages[index];
              return message.to == widget.senderEmail
                  ? SendMessageContainer(message: message)
                  : ReciveMessageContainer(message: message);
            },
          );
        } else if (state is ChatError) {
          return Center(child: Text('Error: ${state.errorMsg}'));
        } else if (state is ChatInitial) {
          return Center(child: CircularProgressIndicator());
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}