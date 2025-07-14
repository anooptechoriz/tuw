import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../components/color_manager.dart';
import '../../components/styles_manager.dart';

class ChatTextMessageBubble extends StatelessWidget {
  final bool isSendByMe;
  final String message;
  final String status;
  final String time;
  const ChatTextMessageBubble(
      {super.key, required this.isSendByMe, required this.message, required this.status,required this.time });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
      margin: EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: isSendByMe ? ColorManager.chatGreen : ColorManager.whiteColor,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            blurRadius: 10.0,
            color: Colors.grey.shade300,
            offset: const Offset(5, 8.5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            message,
            style: getRegularStyle(
              color: ColorManager.black,
              fontSize: 14,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 999999999999999999,
          ),
          Padding(
                          padding: const EdgeInsets.fromLTRB(0, 2, 0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                             children: [
                              Text(
                                time,
                                style: getRegularStyle(
                                    color: ColorManager.grayLight, fontSize: 9),
                              ),
                              const SizedBox(
                                width: 2,
                              ),
                             status == 'waiting'
                                  ? const Icon(
                                      FontAwesomeIcons.clock,
                                      size: 10,
                                    )
                                  : isSendByMe
                                      ? Icon(
                                          Icons.done_all,
                                          color: status == 'read'
                                              ? Colors.blue
                                              : ColorManager.black,
                                          size: 12,
                                        )
                                      : Container()
                            ],
                          ),
                        )
        ],
      ),
    );
  }
}
