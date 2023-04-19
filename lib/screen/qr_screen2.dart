import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'test.dart';

class QrScreen2 extends StatefulWidget {
  const QrScreen2({Key? key}) : super(key: key);

  @override
  State<QrScreen2> createState() => _QrScreen2State();
}

class _QrScreen2State extends State<QrScreen2> {
  var _scanBarcode;
  Future<void> scanQR() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      debugPrint(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
      var ok = jsonDecode(_scanBarcode);
      var product_id = ok["product_id"];
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TestPage(product_id2: "${product_id}"),
          ));
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scanQR();
    // Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(child: Text("Data Not Found")),
          SizedBox(
            height: 50,
          ),
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              height: 50,
              width: MediaQuery.of(context).size.width * .80,
              child: Center(
                child: Text("Please Beck"),
              ),
            ),
          )
        ],
      ),
    );
  }
}
