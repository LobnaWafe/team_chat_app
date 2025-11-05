import 'package:chats_app/features/chat/data/models/message_model.dart';
import 'package:chats_app/features/chat/presentation/view_models/chat_cubit/chat_cubit.dart';
import 'package:chats_app/features/chat/widgets/recive_message_container.dart';
import 'package:chats_app/features/chat/widgets/send_message_container.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//make rebild here
class ChatMessagesListView extends StatefulWidget {
   ChatMessagesListView({super.key, required this.senderEmail, required this.reciverEmail});
   final String senderEmail;
   final String reciverEmail;

  @override
  State<ChatMessagesListView> createState() => _ChatMessagesListViewState();
}

class _ChatMessagesListViewState extends State<ChatMessagesListView> {
   List<MessageModel> messagesList = [];

  @override
  void initState() {
   BlocProvider.of<ChatCubit>(context).getMessages(senderEmail: widget.senderEmail, reciverEmail: widget.reciverEmail);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatCubit, ChatState>(
      listener: (context,state){
        if(state is ChatSuccess){
        messagesList = state.messages;
       // print("in if :$messagesList");
        }
      },
      builder: (context, state) {
      
        return ListView.builder(
          itemCount: messagesList.length,
          reverse: true,
          itemBuilder: (context, index) {
            return messagesList[index].to == widget.senderEmail
                ? SendMessageContainer(message: messagesList[index])
                : ReciveMessageContainer(message: messagesList[index]);
          },
        );
      },
    );
  }
}
