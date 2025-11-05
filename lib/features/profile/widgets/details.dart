import 'package:flutter/material.dart';

class Details extends StatelessWidget {
  const Details({
    super.key,
    required this.detailName,
    required this.text,
    required this.icon, this.onTap,
  });
  final String detailName;
  final String text;
  final IconData icon;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20,bottom: 15,right: 20),
      child: GestureDetector(
        onTap:onTap,
        child: Row( mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(icon),
            SizedBox(width: 15),
            Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [Text(detailName),
               Text(text,style: TextStyle(color: const Color.fromARGB(255, 89, 115, 128)),)]),
          ],
        ),
      ),
    );
  }
}
