// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
// import 'package:tuw_services/providers/data_provider.dart';
// import 'package:tuw_services/screens/widget/chat_model.dart';
// import 'package:tuw_services/widgets/chat/chat_bubble.dart';
// import 'package:tuw_services/widgets/chat/chat_date_widget.dart';

// class ChatBubbleWidget extends StatelessWidget {
//   final int index;
//   final String lang;
//   final ChatModel item;
//   const ChatBubbleWidget(
//       {super.key, required this.index, required this.lang, required this.item});

//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<DataProvider>(context, listen: true);
//     final chatData = provider.viewChatMessageModel?.chatMessage;
//     final userAddress = provider.userAddressShow?.userAddress;
//     final status = item.status;
//     final len = chatData?.data?.length;
//     var locale = 'en';
//     if (lang == 'ar') {
//       locale = 'ar';
//     } else if (lang == 'hi') {
//       locale = 'hi';
//     }
//     var date = DateFormat("yyyy-MM-dd")
//         .parse(chatData?.data?[index].createdAt?.substring(0, 10) ?? '', true);
//     String localDate = DateFormat.yMEd(locale).format(date.toLocal());

//     return Column(
//       children: [
//         status != 'waiting'
//             ? Column(
//                 children: [
//                   (len! - 1) == index
//                       ? ChatDateWidget(localDate: localDate)
//                       : Container(),
//                   (len - 1) != index &&
//                           item.createdAt?.substring(0, 10) !=
//                               item.createdAt?.substring(0, 10)
//                       ? ChatDateWidget(localDate: localDate)
//                       : Container(),
//                 ],
//               )
//             : Container(),
//         CustomChatBubble(chatMessage: chatData?.data?[index]),
//       ],
//     );
//   }
// }
