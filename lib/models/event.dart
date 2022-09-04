class Event {

  String? title;
  String? tag;
  DateTime? alert;

  Event();

  Map<String, dynamic> toJson()=>
  {'title': title, 'tag': tag, 'alert': alert};

}