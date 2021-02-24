import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class MyDeviceListModal {
  String deviceCategory, deviceName, notes, serialNumber;

  MyDeviceListModal(
      {this.deviceCategory, this.deviceName, this.notes, this.serialNumber});

  factory MyDeviceListModal.fromAPI(Map<String, dynamic> jsonObject) {
    return MyDeviceListModal(
        deviceName: jsonObject['deviceName'],
        deviceCategory: jsonObject['deviceCategory'],
        notes: jsonObject['notes'],
        serialNumber: jsonObject['serialNumber']);
  }
}

deviceMapToList(List<QueryDocumentSnapshot> list) {
  return list.map((e) => MyDeviceListModal.fromAPI(e.data())).toList();
}

class MyDeviceList extends ChangeNotifier {
  List<MyDeviceListModal> fixList = [];
  List<MyDeviceListModal> queryList = [];

  MyDeviceList();

  void filterSearchResults(String query) {
    if (query.isNotEmpty) {
      List<MyDeviceListModal> dummyListData = [];
      dummyListData.addAll(fixList.where((item) =>
          item.deviceName.toLowerCase().contains(query.toLowerCase())));
      updateList(dummyListData);
      update();
      return;
    } else {
      updateList(fixList);
      update();
    }
  }

  setDocuments(List<QueryDocumentSnapshot> l) {
    fixList = deviceMapToList(l);
    queryList = deviceMapToList(l);
  }

  updateList(List<MyDeviceListModal> newList) {
    queryList.clear();
    queryList.addAll(newList);
  }

  update() {
    notifyListeners();
  }
}
