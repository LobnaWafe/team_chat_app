import 'dart:convert';

import 'package:chats_app/cach/cach_helper.dart';
import 'package:chats_app/features/authentication/data/models/user_model.dart';
import 'package:chats_app/features/profile/presentation/view_models/app_language_cubit/app_language_cubit.dart';
import 'package:chats_app/features/profile/widgets/details.dart';
import 'package:chats_app/generated/l10n.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileViewBody extends StatefulWidget {
  const ProfileViewBody({super.key});
  // final UserModel userModel;

  @override
  State<ProfileViewBody> createState() => _ProfileViewBodyState();
}

class _ProfileViewBodyState extends State<ProfileViewBody> {
  UserModel? userModel;
  @override
  void initState() {
    final userString = CacheHelper.getData(key: "user");
    if (userString != null) {
      final userMap = jsonDecode(userString);
      userModel = UserModel.fromJson(Map<String, dynamic>.from(userMap));
      print(userModel!.name);

      super.initState();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: CircleAvatar(
            radius: 60,
            backgroundImage:
                userModel!.imageUrl.isNotEmpty
                    ? NetworkImage(userModel!.imageUrl)
                    : const AssetImage('assets/images/profile.png')
                        as ImageProvider,
          ),
        ),
        SizedBox(height: 40),
        Details(
          onTap: () {
            showEditNameDialog(context, userModel!.name);
          },
          icon: Icons.person,
          detailName: S.of(context).profileName,
          text: userModel!.name,
        ),
        Details(
          icon: Icons.mail,
          detailName: S.of(context).profileEmail,
          text: userModel!.email,
        ),
        Details(
          onTap: () {
            BlocProvider.of<AppLanguageCubit>(context).changeLnguageMethod();
          },
          icon: Icons.language,
          detailName: S.of(context).appLanguage,
          text: S.of(context).language,
        ),

        Padding(
          padding: const EdgeInsets.only(left: 23, top: 30, right: 23),
          child: GestureDetector(
            onTap: () {},
            child: Row(
              children: [
                Icon(Icons.logout),
                SizedBox(width: 10),
                Text(S.of(context).signOut),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void showEditNameDialog(context, String name) {
    TextEditingController textEditingController = TextEditingController(
      text: name,
    );
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text("Edit Name", style: TextStyle(fontSize: 18)),
            content: TextField(
              cursorColor: const Color.fromARGB(255, 78, 130, 209),
              controller: textEditingController,
              decoration: InputDecoration(
                border: buildBorder(),
                enabledBorder: buildBorder(),
                focusedBorder: buildBorder(),
              ),
            ),
            actions: [
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white, // لون النص والأيقونات
                  overlayColor: const Color.fromARGB(255, 108, 107, 107),
                ),
                onPressed: () {
                  Navigator.pop(context); // يقفل الـ dialog
                },
                child: const Text(
                  "Cancel",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  overlayColor: const Color.fromARGB(255, 108, 107, 107),
                ),
                onPressed: () {
                  //code
                  changeNameMethod(textEditingController);
                  Navigator.pop(context);
                },
                child: const Text(
                  "Save",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
    );
  }

  void changeNameMethod(TextEditingController textEditingController) async{
         var newUser = UserModel(
      uid: userModel!.uid,
      name: textEditingController.text,
      email: userModel!.email,
      imageUrl: userModel!.imageUrl,
      createdAt: userModel!.createdAt,
    );
    final users = FirebaseFirestore.instance.collection("users");
  await users.doc(userModel!.uid).update({'name':  textEditingController.text});

    CacheHelper.saveCustomData(key: "user", value: newUser);
    setState(() {
      userModel=newUser;
    });
  }

  OutlineInputBorder buildBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.black),
    );
  }
}
