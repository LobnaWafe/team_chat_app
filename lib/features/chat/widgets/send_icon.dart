
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SendIcon extends StatelessWidget {
  const SendIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: CircleAvatar(
        radius: 16,
        backgroundColor: const Color.fromARGB(255, 78, 130, 209),
        child: SvgPicture.asset("assets/image/sendIcon.svg", width: 22),
      ),
    );
  }
}
