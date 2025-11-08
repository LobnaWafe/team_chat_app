import 'package:chats_app/cach/cach_helper.dart';
import 'package:chats_app/features/chat/data/models/message_model.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart' as intl;

class FirstSendMessageContainer extends StatelessWidget {
  const FirstSendMessageContainer({super.key, required this.message});
  final MessageModel message;

  @override
  Widget build(BuildContext context) {
    final lang = CacheHelper.getData(key: "appLanguage") ?? "en";
    final isLocation = message.type == "location";

    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 5),
      child: Row(
        mainAxisAlignment:
            lang == "en" ? MainAxisAlignment.start : MainAxisAlignment.end,
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.sizeOf(context).width * 0.6,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 179, 201, 232),
                borderRadius: BorderRadius.only(
                  /////////
                  topRight: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8)
                ),
              ),
              padding: const EdgeInsets.all(8),
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: Column(
                  
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (isLocation)
                      GestureDetector(
                        onTap: () {
                          final url =
                              "https://www.google.com/maps/dir/?api=1&destination=${message.lat},${message.lng}";
                          launchUrl(Uri.parse(url),
                              mode: LaunchMode.externalApplication);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.blueGrey[100],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: const [
                              Icon(Icons.location_pin, color: Colors.red),
                              SizedBox(width: 8),
                              Text("View Location",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500)),
                            ],
                          ),
                        ),
                      )
                    else
                      Text(
                        message.content,
                        style: const TextStyle(color: Colors.black),
                        softWrap: true,
                      ),
                    const SizedBox(height: 4),
                    Text(
                     formattedTime(message.createdAt),
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black.withValues(alpha: 80),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
      String formattedTime(createdAt) {
    return intl.DateFormat('h:mm a').format(createdAt);
  }
}
