class Account {
  String? uid;
  String? detail_1;
  int detail_2 = 0;
  DateTime? nextFreeEvent;

  Account();

  Map<String, dynamic> toJson() => {
        'detail_1': detail_1,
        'detail_2': detail_2,
        'nextFreeEvent': nextFreeEvent
      };

  Account.fromSnapshot(snapshot, this.uid)
  : detail_1 = snapshot.data()['detail_1'], 
    detail_2 = snapshot.data()['detail_2'],
    nextFreeEvent = snapshot.data()['nextFreeEvent'].toDate();
}
