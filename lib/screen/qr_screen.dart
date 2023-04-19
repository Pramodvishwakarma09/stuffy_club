// import 'dart:convert';
// import 'dart:developer';
// import 'dart:io';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:qr_code_scanner/qr_code_scanner.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'my_stuffy_screen.dart';
// import 'package:http/http.dart' as http;
// import '../models/add_galary.dart';
// import 'my_stuffy_screen.dart';
//
// class QRViewExample extends StatefulWidget {
//   const QRViewExample({Key? key}) : super(key: key);
//
//   @override
//   State<StatefulWidget> createState() => _QRViewExampleState();
// }
//
// class _QRViewExampleState extends State<QRViewExample> {
//
//
//   Map? data;
//   Future<AddGallryModel> fechData(String product_idi) async {
//     print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@11111111111@@@@@@@@");
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     var stringValue = prefs.getInt('user_id');
//     AddGallryModel bm;
//     String url = "http://192.168.1.23:4000/addgallery";
//     http.Response response = await http.post(Uri.parse(url),
//         body: { "product_id" : "${product_idi}",
//                "user_id": stringValue.toString(),
//               }
//     );
//     print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@22222222222@@@@@@@@");
//
//     Map<String, dynamic> jsonresponse = jsonDecode(response.body);
//     print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@333333333@@@@@@@@");
//     print(jsonresponse.toString());
//     bm = AddGallryModel.fromJson(jsonresponse);
//     print(jsonresponse.toString());
//     return bm;
//
//   }
//
//
//
//   Barcode? result;
//   QRViewController? controller;
//   final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
//
//
//   @override
//   void reassemble() {
//     super.reassemble();
//     if (Platform.isAndroid) {
//       // controller!.pauseCamera();
//       controller!.resumeCamera();
//
//     }
//     // controller!.resumeCamera();
//   }
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     controller?.resumeCamera();
//
//     setState(()  {
//
//        // controller?.resumeCamera();
//
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: <Widget>[
//           Expanded(flex: 6, child: _buildQrView(context)),
//           Expanded(
//             flex: 1,
//             child: FittedBox(
//               fit: BoxFit.contain,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: <Widget>[
//                   // if (result != null)
//                   //   Text(
//                   //       "${result!.code}")
//                   // else
//                   //   const Text('Scan a code'),
//                  Container(
//                    child: result != null ?   TextButton(onPressed: ()async{
//                      await controller?.pauseCamera();
//                    var ok=  jsonDecode(result!.code!);
//                    print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
//                    print("${ok["product_id"]}");
//                     var product_id= ok["product_id"].toString();
//                    // fechData("${product_id}");
//                      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyStuffyScreen(),));
//                    }, child: Text("Rong QR & Not Find Stuffy")): Padding(
//                      padding: const EdgeInsets.all(8.0),
//                      child: Text("Faching QR Code", style: TextStyle(fontSize: 18),),
//                    ),
//                  ),
//
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: <Widget>[
//                       Container(
//                         margin: const EdgeInsets.all(8),
//                         child: ElevatedButton(
//                             onPressed: () async {
//                               await controller?.toggleFlash();
//                               setState(() {});
//                             },
//                             child: FutureBuilder(
//                               future: controller?.getFlashStatus(),
//                               builder: (context, snapshot) {
//                                 return Icon(Icons.lightbulb_outline);
//                                   Text('Flash: ${snapshot.data}');
//                               },
//                             )),
//                       ),
//                       Row(
//                         children: [
//                           Container(
//                             margin: const EdgeInsets.all(8),
//                             child: ElevatedButton(
//                                 onPressed: () async {
//                                   await controller?.flipCamera();
//                                   await controller?.flipCamera();
//
//
//                                   setState(() {});
//                                 },
//                                 child: FutureBuilder(
//                                   future: controller?.getCameraInfo(),
//                                   builder: (context, snapshot) {
//                                     if (snapshot.data != null) {
//                                       return Text(
//                                           'Scan Qr ');
//                                       // ${describeEnum(snapshot.data!)}
//                                     } else {
//                                       return const Text('loading');
//                                     }
//                                   },
//                                 )),
//                           ),
//                           Container(
//                             margin: const EdgeInsets.all(8),
//                             child: ElevatedButton(
//                                 onPressed: () async {
//                                   setState(() {});
//                                 },
//                                 child: FutureBuilder(
//                                   future: controller?.getCameraInfo(),
//                                   builder: (context, snapshot) {
//                                     if (snapshot.data != null) {
//                                       return Text(
//                                           'Sumbit ');
//                                       // ${describeEnum(snapshot.data!)}
//                                     } else {
//                                       return const Text('loading');
//                                     }
//                                   },
//                                 )),
//                           ),
//
//                         ],
//                       )
//                     ],
//                   ),
//                   // Row(
//                   //   mainAxisAlignment: MainAxisAlignment.center,
//                   //   crossAxisAlignment: CrossAxisAlignment.center,
//                   //   children: <Widget>[
//                   //     Container(
//                   //       margin: const EdgeInsets.all(8),
//                   //       child: ElevatedButton(
//                   //         onPressed: () async {
//                   //           await controller?.pauseCamera();
//                   //         },
//                   //         child: const Text('pause',
//                   //             style: TextStyle(fontSize: 20)),
//                   //       ),
//                   //     ),
//                   //     Container(
//                   //       margin: const EdgeInsets.all(8),
//                   //       child: ElevatedButton(
//                   //         onPressed: () async {
//                   //           await controller?.resumeCamera();
//                   //         },
//                   //         child: const Text('resume',
//                   //             style: TextStyle(fontSize: 20)),
//                   //       ),
//                   //     )
//                   //   ],
//                   // ),
//                 ],
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
//
//   Widget _buildQrView(BuildContext context) {
//     // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
//     var scanArea = (MediaQuery.of(context).size.width < 400 ||
//         MediaQuery.of(context).size.height < 400)
//         ? 300.0
//         : 400.0;
//     // To ensure the Scanner view is properly sizes after rotation
//     // we need to listen for Flutter SizeChanged notification and update controller
//     return QRView(
//       key: qrKey,
//       onQRViewCreated: _onQRViewCreated,
//       overlay: QrScannerOverlayShape(
//           borderColor: Colors.lightGreenAccent,
//           borderRadius: 10,
//           borderLength: 30,
//           borderWidth: 10,
//           cutOutSize: scanArea),
//       onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
//     );
//   }
//
//   void _onQRViewCreated(QRViewController controller) {
//     setState(() {
//       this.controller = controller;
//     });
//     controller.scannedDataStream.listen((scanData) {
//       setState(() async {
//         result = scanData;
//         await controller?.resumeCamera();
//
//         if(result != null){
//           await controller?.resumeCamera();
//         var ok=  jsonDecode(result!.code!);
//         print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
//         print("${ok["product_id"]}");
//         var product_id= ok["product_id"].toString();
//         fechData("${product_id}");
//         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyStuffyScreen(),));
//
//         }
//       });
//     });
//   }
//
//   void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
//     log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
//     if (!p) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('no Permission')),
//       );
//     }
//   }
//
//   @override
//   void dispose() {
//     controller?.dispose();
//     super.dispose();
//   }
// }
