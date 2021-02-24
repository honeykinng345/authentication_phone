import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geekfleet/screens/showDevice.dart';

class DeviceWidget extends StatelessWidget {
  final String image;
  final String tittle;
  final String subTittle;
  final String totalDevices;
  final QuerySnapshot objects;

  const DeviceWidget(
      {Key key,
      this.image,
      this.tittle,
      this.subTittle,
      this.totalDevices,
      this.objects})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () {
        if (this.objects.docs.length != 0) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ShowDevice(object: this.objects)));
        }
      },
      child: Container(
        height: MediaQuery.of(context).size.width / 2.2,
        width: MediaQuery.of(context).size.width / 2.2,
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              color: Colors.black12,
              offset: Offset(0, 0),
              blurRadius: 3,
              spreadRadius: 3)
        ], color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              image,
              scale: 3,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              tittle,
              style: TextStyle(
                  color: Color(0xff9400D3), fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: 5,
            ),
            subTittle != '' ? Text(subTittle) : Container(),
            SizedBox(
              height: 5,
            ),
            Text(
              totalDevices,
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
