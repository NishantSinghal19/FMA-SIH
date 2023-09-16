class NotificationModel{
  late String title;
  late String body;
  late String data;
  // final DateTime expiredAt;

  NotificationModel(this.title, this.body, this.data);

  // factory PushNotificationModel.fromJson(Map<String, dynamic> json) {
  //   return PushNotificationModel(
  //     title: json['title'],
  //     description: json['description'],
  //     expiredAt: json['expiredAt'],
  //   );
  // }
}