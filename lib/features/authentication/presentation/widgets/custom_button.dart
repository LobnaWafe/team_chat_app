import 'package:chats_app/generated/l10n.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const CustomButton({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isSignUp = text == S.of(context).SignUp;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(30),
      splashColor: const Color(0xFF5EBBFF).withOpacity(0.3),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.6,
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          // ✅ لو الزرار SignUp استخدم تدرج، لو غير كده استخدم لون ثابت
          gradient: isSignUp
              ? const LinearGradient(
                  colors: [
                    Color.fromARGB(255, 78, 165, 236),
                  Color.fromARGB(255, 130, 180, 220),
                //  Color.fromARGB(255, 78, 165, 236),
                    Color.fromARGB(255, 162, 221, 209),
                  ],
                )
              : null,
          color: isSignUp ? null : Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: isSignUp ? Colors.white : const Color(0xFF1C3A5F),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
