import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class MyTicketListModal {
  String device, summary, description;

  MyTicketListModal({this.description, this.device, this.summary});

  factory MyTicketListModal.fromAPI(Map<String, dynamic> jsonObject) {
    return MyTicketListModal(
        description: jsonObject['description'],
        summary: jsonObject['summary'],
        device: jsonObject['selectedDevice']);
  }
}

mapToList(List<QueryDocumentSnapshot> list) {
  return list.map((e) => MyTicketListModal.fromAPI(e.data())).toList();
}

class MyTicketList extends ChangeNotifier {
  List<MyTicketListModal> fixList = [];
  List<MyTicketListModal> queryList = [];

  MyTicketList();

  void filterSearchResults(String query) {
    if (query.isNotEmpty) {
      List<MyTicketListModal> dummyListData = [];
      dummyListData.addAll(fixList.where(
          (item) => item.summary.toLowerCase().contains(query.toLowerCase())));
      updateList(dummyListData);
      update();
      return;
    } else {
      updateList(fixList);
      update();
    }
  }

  setDocuments(List<MyTicketListModal> allTickets) {
    queryList.clear();
    fixList.clear();
    fixList.addAll(allTickets);
    queryList.addAll(allTickets);
  }

  updateList(List<MyTicketListModal> newList) {
    queryList.clear();
    queryList.addAll(newList);
  }

  update() {
    notifyListeners();
  }
}
