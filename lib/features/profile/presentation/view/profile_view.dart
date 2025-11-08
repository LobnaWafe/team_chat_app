import 'dart:convert';

import 'package:chats_app/cach/cach_helper.dart';
import 'package:chats_app/features/authentication/data/models/user_model.dart';
import 'package:chats_app/features/profile/widgets/profile_view_body.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: 
      ProfileViewBody()),
    );
  }
}