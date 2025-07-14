class ChatModel {
  int? id;
  String? firstname;
  String? lastname;
  String? phone;
  String? onlineStatus;
  String? profilePic;
  String? serviceName;
  String? lastMessageCreatedAt;
  int? servicemanId;
  int? chatId;
  int? senderId;
  int? receiverId;
  String? message;
  String? type;
  String? status;
  String? uploads;
  int? unreadCount;
  String? createdAt;

  ChatModel(
      {this.id,
      this.firstname,
      this.lastname,
      this.phone,
      this.onlineStatus,
      this.profilePic,
      this.serviceName,
      this.lastMessageCreatedAt,
      this.servicemanId,
      this.chatId,
      this.senderId,
      this.receiverId,
      this.message,
      this.type,
      this.status,
      this.uploads,
      this.unreadCount,
      this.createdAt});

  ChatModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    phone = json['phone'];
    onlineStatus = json['online_status'];
    profilePic = json['profile_pic'];
    serviceName = json['service_name'];
    lastMessageCreatedAt = json['last_message_created_at'];
    servicemanId = json['serviceman_id'];
    chatId = json['chat_id'];
    senderId = json['sender_id'];
    receiverId = json['receiver_id'];
    message = json['message'];
    type = json['type'];
    status = json['status'];
    uploads = json['uploads'];
    unreadCount = json['unread_count'];
    createdAt = json['created_at'];
  }
}
