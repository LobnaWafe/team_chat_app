import 'package:chats_app/features/profile/presentation/view_models/app_language_cubit/app_language_cubit.dart';
import 'package:chats_app/features/profile/widgets/details.dart';
import 'package:chats_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: CircleAvatar(
            radius: 60,
            backgroundImage: NetworkImage(
              "https://hkxtaqbisnboczqhsodv.supabase.co/storage/v1/object/public/avatars/profilePhotos/1759188884597.png",
            ),
          ),
        ),
        SizedBox(height: 40),
        Details(
          onTap: () {
            showEditNameDialog(context, "Lobna Wafe");
          },
          icon: Icons.person,
          detailName: S.of(context).profileName,
          text: "Lobna Wafe",
        ),
        Details(
          icon: Icons.mail,
          detailName: S.of(context).profileEmail,
          text: "Lobnawafe@gmail.com",
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
          padding: const EdgeInsets.only(left: 23, top: 30,right: 23),
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
      builder: (context) => AlertDialog(
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
            child: const Text("Cancel", style: TextStyle(color: Colors.black)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
            overlayColor: const Color.fromARGB(255, 108, 107, 107),
            ),
            onPressed: () {
              //code
              Navigator.pop(context);
            },
            child: const Text("Save", style: TextStyle(color: Colors.black)),
          ),
        ],
      ),
    );
  }

  OutlineInputBorder buildBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.black),
    );
  }
}
