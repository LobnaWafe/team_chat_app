import 'package:chats_app/features/chat/presentation/view_models/chat_cubit/chat_cubit.dart';
import 'package:chats_app/features/chat/widgets/map_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MapView extends StatelessWidget {
  const MapView({
    super.key,
    required this.senderEmail,
    required this.reciverEmail,
  });
  final String senderEmail;
  final String reciverEmail;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatCubit(),
      child: Scaffold(
        body: SafeArea(
          child: MapViewBody(
            senderEmail: senderEmail,
            reciverEmail: reciverEmail,
          ),
        ),
      ),
    );
  }
}
