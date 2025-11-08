import 'dart:convert';
import 'package:chats_app/cach/cach_helper.dart';
import 'package:chats_app/features/authentication/data/models/user_model.dart';
import 'package:chats_app/features/profile/presentation/view_models/app_language_cubit/app_language_cubit.dart';
import 'package:chats_app/features/profile/widgets/details.dart';
import 'package:chats_app/generated/l10n.dart';
import 'package:chats_app/utils/app_router.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ProfileViewBody extends StatefulWidget {
  const ProfileViewBody({super.key});

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
    final theme = Theme.of(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: Column(
        children: [
          // ✅ صورة المستخدم بتصميم عصري
          Center(
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  radius: 65,
                  backgroundColor: Colors.blue.shade100.withOpacity(0.4),
                  backgroundImage: userModel!.imageUrl.isNotEmpty &&
                          userModel!.imageUrl.startsWith("assets")
                      ? AssetImage(userModel!.imageUrl) as ImageProvider
                      : NetworkImage(userModel!.imageUrl),
                ),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(6),
                  child: Icon(Icons.edit, color: Colors.blue.shade600, size: 22),
                ),
              ],
            ),
          ),

          const SizedBox(height: 40),

          // ✅ الاسم
          Details(
            onTap: () {
              showEditNameDialog(context, userModel!.name);
            },
            icon: Icons.person_outline,
            detailName: S.of(context).profileName,
            text: userModel!.name,
          ),

          // ✅ البريد
          Details(
            icon: Icons.mail_outline,
            detailName: S.of(context).profileEmail,
            text: userModel!.email,
          ),

          // ✅ اللغة
          Details(
            onTap: () {
              BlocProvider.of<AppLanguageCubit>(context).changeLnguageMethod();
            },
            icon: Icons.language,
            detailName: S.of(context).appLanguage,
            text: S.of(context).language,
          ),

          // ✅ تسجيل الخروج
          const SizedBox(height: 30),
          GestureDetector(
            onTap: () async {
              await CacheHelper.removeData(key: "user");
              GoRouter.of(context).pushReplacement(AppRouter.kWelcome);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.red.shade200),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.logout, color: Colors.red.shade700),
                  const SizedBox(width: 10),
                  Text(
                    S.of(context).signOut,
                    style: TextStyle(
                      color: Colors.red.shade700,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showEditNameDialog(context, String name) {
    TextEditingController textEditingController = TextEditingController(
      text: name,
    );
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text("Edit Name", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        content: TextField(
          cursorColor: Colors.blueAccent,
          controller: textEditingController,
          decoration: InputDecoration(
            hintText: "Enter new name",
            border: buildBorder(),
            enabledBorder: buildBorder(),
            focusedBorder: buildBorder(color: Colors.blueAccent),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel", style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () {
              changeNameMethod(textEditingController);
              Navigator.pop(context);
            },
            child: const Text("Save", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void changeNameMethod(TextEditingController textEditingController) async {
    var newUser = UserModel(
      uid: userModel!.uid,
      name: textEditingController.text,
      email: userModel!.email,
      imageUrl: userModel!.imageUrl,
      createdAt: userModel!.createdAt,
    );
    final users = FirebaseFirestore.instance.collection("users");
    await users.doc(userModel!.uid).update({'name': textEditingController.text});

    CacheHelper.saveCustomData(key: "user", value: newUser);
    setState(() {
      userModel = newUser;
    });
  }

  OutlineInputBorder buildBorder({Color color = Colors.black26}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: color),
    );
  }
}
