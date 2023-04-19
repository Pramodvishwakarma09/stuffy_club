import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'My_Sprites.dart';
import 'auth/profile_screen.dart';
import 'qr_screen2.dart';
import 'test.dart';
import 'home_screen.dart';
import 'my_stuffy_screen.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
class BottomBar_Screen extends StatefulWidget {
  const BottomBar_Screen({Key? key}) : super(key: key);

  @override
  State<BottomBar_Screen> createState() => _BottomBar_ScreenState();
}

class _BottomBar_ScreenState extends State<BottomBar_Screen> {

  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  static  List<Widget> _pages = <Widget>[
    HomeScreen(),
    MyStuffyScreen(),
    QrScreen2(),
    My_Spirit(),
    ProfileScreen(),
  ];




  var _scanBarcode ;
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
      var  product_id = ok["product_id"];
      Navigator.push(context, MaterialPageRoute(builder: (context) => TestPage(product_id2: "${product_id}"),));
    });
  }



  Future<bool> showExitPopup() async {
   return  await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Exit App'),
        content: Text('Do you want to exit an App?'),
        actions:[
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(false),
            //return false when click on "NO"
            child:Text('No'),
          ),

          ElevatedButton(
            onPressed: () => Navigator.of(context)..pop(true),
            //return true when click on "Yes"
            child:Text('Yes'),
          ),

        ],
      ),
    )??false; //if showDialouge had returned null, then return false
  }
   void  check() {
    print(_selectedIndex);
     if(_selectedIndex != 0 ){
       _selectedIndex=0;

     }else{
       showExitPopup();
     }

  }

  Future<bool> _willPopCallback() async {
    print(_selectedIndex);
    if(_selectedIndex == 0 ){

      showExitPopup();
    }else{
      setState((){
        _selectedIndex = 0;
      });
    }

    // await showDialog or Show add banners or whatever
    // then
    return false; // return true if the route to be popped
  }

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: _willPopCallback, //cal
      child: Scaffold(
        body: Center(
          child: _pages.elementAt(_selectedIndex), //New
        ),
        bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
          backgroundColor:  HexColor('#86C33C'),
          currentIndex: _selectedIndex, //New
          onTap: _onItemTapped,
          items:  <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              backgroundColor:  Color(0xff86C33C),

              // backgroundColor:  HexColor('#86C33C'),

              label: '',
              icon: Column(
                children: [
                  SvgPicture.asset('asset/new icons/homeicon.svg'),
                  _selectedIndex == 0?Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container (
                      height: 3,width: 12,
                      color: Colors.white,
                    ),
                  ):Container()
                ],
              ),

            ),
            BottomNavigationBarItem(
              backgroundColor:  HexColor('#86C33C'),
              label: '',
              icon: Column(
                children: [
                  SvgPicture.asset('asset/new icons/Tab Two (2).svg'),
                  _selectedIndex == 1?Container (
                    height: 3,width: 12,
                    color: Colors.white,
                  ):Container()
                ],
              ),
            ),
            BottomNavigationBarItem(
              backgroundColor:  HexColor('#86C33C'),
              label: '',
              icon: InkWell(
                onTap: (){
                  scanQR();
                  // Navigator.push(context, MaterialPageRoute(
                  //     builder: (_)=> QrScreen2())

                },
                child: Column(
                  children: [
                    SvgPicture.asset('asset/new icons/send_circle.svg'),
                  ],
                ),
              ),
            ),
            BottomNavigationBarItem(
              backgroundColor:  HexColor('#86C33C'),
              label: '',
              icon: Column(
                children: [
                  SvgPicture.asset('asset/new icons/Tab Four.svg'),
                  _selectedIndex == 3?Container (
                    height: 3,width: 12,
                    color: Colors.white,
                  ):Container()
                ],
              ),
            ),
            BottomNavigationBarItem(
              backgroundColor:  HexColor('#86C33C'),
              label: '',
              icon: Column(
                children: [
                  SvgPicture.asset('asset/new icons/Tab Five.svg'),
                  _selectedIndex == 4?Container (
                    height: 3,width: 12,
                    color: Colors.white,
                  ):Container()
                ],
              ),
            ),
          ],
        )
        //
        // Container(
        //   child: Row(
        //     children: [
        //       Container(
        //         height: 60,
        //         width: MediaQuery.of(context).size.width/5,
        //         decoration: BoxDecoration(
        //             color: HexColor('#86C33C')
        //         ),
        //         child: SvgPicture.asset('asset/new icons/Tab One (1).svg'),
        //       ),
        //       InkWell(
        //         onTap: (){
        //           Navigator.push(context, MaterialPageRoute(
        //               builder: (_)=>My_Stuff())
        //           );
        //         },
        //         child :Container(
        //           height: 60,
        //           width: MediaQuery.of(context).size.width/5,
        //           decoration: BoxDecoration(
        //               color: HexColor('#86C33C')
        //           ),
        //           child: SvgPicture.asset('asset/new icons/Tab Two (2).svg'),
        //         ),),
        //       InkWell(
        //         onTap: (){
        //           Navigator.push(context, MaterialPageRoute(
        //               builder: (_)=>SC())
        //           );
        //         },
        //         child : Container(
        //           height: 60,
        //           width: MediaQuery.of(context).size.width/5,
        //           decoration: BoxDecoration(
        //               color: HexColor('#86C33C')
        //           ),
        //           child: SvgPicture.asset('asset/new icons/send_circle.svg'),
        //         ),),
        //       InkWell(
        //         onTap: (){
        //           Navigator.push(context, MaterialPageRoute(
        //               builder: (_)=>My_Spirit())
        //           );
        //         },
        //         child : Container(
        //           height: 60,
        //           width: MediaQuery.of(context).size.width/5,
        //           decoration: BoxDecoration(
        //               color: HexColor('#86C33C')
        //           ),
        //           child: SvgPicture.asset('asset/new icons/Tab Four.svg'),
        //         ),),
        //       InkWell(
        //         onTap: (){
        //           Navigator.push(context, MaterialPageRoute(
        //               builder: (_)=>MProfile())
        //           );
        //         },
        //         child : Container(
        //           height: 60,
        //           width: MediaQuery.of(context).size.width/5,
        //           decoration: BoxDecoration(
        //               color: HexColor('#86C33C')
        //           ),
        //           child: SvgPicture.asset('asset/new icons/Tab Five.svg'),
        //         ),
        //       )
        //     ],
        //   ),
        // ),
      ),
    );
  }
}
