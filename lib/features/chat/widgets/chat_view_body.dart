import 'package:chats_app/features/chat/data/models/message_model.dart';
import 'package:chats_app/features/chat/presentation/view_models/chat_cubit/chat_cubit.dart';
import 'package:chats_app/features/chat/widgets/chat_messages_list_view.dart';
import 'package:chats_app/features/chat/widgets/send_icon.dart';
import 'package:chats_app/generated/l10n.dart';
import 'package:chats_app/utils/app_router.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ChatViewBody extends StatelessWidget {
  const ChatViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ChatMessagesListView(
            senderEmail: "ahmedwafe@gmail.com",
            reciverEmail: "lobnawafe@gmail.com",
          ),
        ),
        SizedBox(height: 3),
        ChatTextFeild(),
        SizedBox(height: 25),
      ],
    );
  }
}

class ChatTextFeild extends StatefulWidget {
  const ChatTextFeild({super.key});

  @override
  State<ChatTextFeild> createState() => _ChatTextFeildState();
}

class _ChatTextFeildState extends State<ChatTextFeild> {
  late TextEditingController messageController;
  @override
  void initState() {
    messageController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 5),
              child: TextField(
                minLines: 1,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.newline,
                cursorColor: Colors.black.withValues(alpha: 100),
                controller: messageController,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {
                      GoRouter.of(context).push(
                        AppRouter.kMap,
                        extra: {
                          'senderEmail': 'lobnawafe@gmail.com',
                          'reciverEmail': 'ahmedwafe@gmail.com',
                        },
                      );
                    },
                    icon: Icon(Icons.location_on),
                  ),
                  fillColor: const Color.fromARGB(255, 212, 221, 235),
                  filled: true,
                  contentPadding: EdgeInsets.only(left: 15),
                  hintText: S.of(context).hintTextChatPage,
                  border: buildBorder(),
                  enabledBorder: buildBorder(),
                  focusedBorder: buildBorder(),
                ),
              ),
            ),
          ),

          GestureDetector(
            onTap: () {
              if (messageController.text.isNotEmpty) {
                // 1️⃣ توليد id فريد للرسالة
                sendMessage(context);
              }
            },
            child: SendIcon(),
          ),
        ],
      ),
    );
  }

  void sendMessage(BuildContext context) {
         final messageId = FirebaseFirestore.instance
        .collection('temp')
        .doc()
        .id;
    
    // 2️⃣ إنشاء الموديل
    var msg = MessageModel(
      id: messageId,
      from: "ahmedwafe@gmail.com",
      to: "lobnawafe@gmail.com",
      content: messageController.text,
      createdAt: DateTime.now(),
    );
    
    // 3️⃣ إرسال الرسالة
    BlocProvider.of<ChatCubit>(context).addMessage(
      senderEmail: "ahmedwafe@gmail.com",
      reciverEmail: "lobnawafe@gmail.com",
      message: msg,
    );
    messageController.clear();
  }

  OutlineInputBorder buildBorder() {
    return OutlineInputBorder(
      borderSide: BorderSide(color: Colors.transparent),
      borderRadius: BorderRadius.circular(20),
    );
  }
}
