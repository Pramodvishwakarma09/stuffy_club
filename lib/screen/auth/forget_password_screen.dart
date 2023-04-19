
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../FormTextField/Validation_Form_field.dart';
import 'package:http/http.dart'as http;

import 'login_screen.dart';

class Forget_Password extends StatefulWidget {
  const Forget_Password({Key? key}) : super(key: key);

  @override
  State<Forget_Password> createState() => _Forget_PasswordState();
}

class _Forget_PasswordState extends State<Forget_Password> {

  final _formkey = GlobalKey<FormState>();
  TextEditingController email_AddressC = TextEditingController();

  bool loading =false;
  void loginwithEmail() async {

    setState(() {
      loading = true;
    });

    try {
      final response = await http.post(
        Uri.parse("http://192.168.1.23:4000/forgotPassword"),
        body: {
          "email": email_AddressC.value.text,
        },
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        bool login = data['success'];
        print("@@@@@@1234@@@@@@@@@@@@@@@");

        Fluttertoast.showToast(
          msg: "${data["message"]}",
          toastLength: Toast.LENGTH_LONG,
          //duration
          gravity: ToastGravity.BOTTOM,
          //location
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          //background color
          textColor: Colors.white,
          //text Color
          fontSize: 16.0,
          //font size
        );
        setState(() {
          loading = false;
        });
        if (login) {
          print("loggggin");
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
          );

          setState(() {
            loading = false;
          });
        } else {
          print("++++++++++++++++++");
          // Fluttertoast.showToast(
          //   msg: "Internal server error",
          //   toastLength: Toast.LENGTH_LONG,
          //   //duration
          //   gravity: ToastGravity.TOP,
          //   //location
          //   timeInSecForIosWeb: 1,
          //   backgroundColor: Colors.red,
          //   //background color
          //   textColor: Colors.white,
          //   //text Color
          //   fontSize: 16.0,
          //   //font size
          // );

        }
      } else {

        setState(() {
          loading = false;
        });
        print('failed');
      }
    } catch (e) {

      setState(() {
        loading = false;
        Fluttertoast.showToast(
          msg: "verify user",
          toastLength: Toast.LENGTH_LONG,
          //duration
          gravity: ToastGravity.TOP,
          //location
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          //background color
          textColor: Colors.white,
          //text Color
          fontSize: 16.0,
          //font size
        );
        print(
            "------------------------------------------------------------------");
        print("@@@@@@@@@@@trrgfgg@@@@@@@@${e}");
      });
      print(e.toString());
    }
  }



  @override
  Widget build(BuildContext context) {

  return Scaffold(
      backgroundColor: HexColor('#00000033').withOpacity(0.15),
        drawerEnableOpenDragGesture: false,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
        child:Stack(
          children: [
            Container(
                constraints: BoxConstraints.expand(),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("asset/images/Teady.png"),
                      fit: BoxFit.cover),
                ),
                height: 7, width: 6,
            ),
            Container(
              constraints: BoxConstraints.expand(),
              color: Colors.black38,
            ),
            Container(
                padding:const  EdgeInsets.symmetric(horizontal: 16),
                constraints: BoxConstraints.expand(),
                height: 7,
                width: 6,
                child: SingleChildScrollView(
                    child: Column(
                        children: [
                          SizedBox(height:4,width: 2),
                           Container(
                             padding: EdgeInsets.only(top:51, left:40, right:30),
                             alignment: Alignment.topCenter,
                            // mainAxisSize: MainAxisAlignment.center,
                              child: Image.asset('asset/new icons/logo.png'),
                           ),
                          SizedBox(height: 21),
                          Padding(
                            padding: const EdgeInsets.only(top: 2),
                            child: Text('Forgot Password ',textAlign: TextAlign.center,
                                style: TextStyle(fontSize:24,fontFamily: 'Aboshi', fontWeight: FontWeight.w400,
                                    color: HexColor('#FFFFFF'))
                            ),
                          ),

                            Container(
                              padding: EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        width: MediaQuery.of(context).size.width,
                                        alignment: Alignment.center,
                                        child: Text('Enter your email address to get a reset'
                                            '\n password link.',textAlign: TextAlign.center,
                                          style: TextStyle(fontSize:14, fontFamily: 'Poppins',  fontWeight: FontWeight.w500,
                                              color:HexColor('#FFFFFF')),)
                                    ),

                                    Form(
                                        key: _formkey,
                                        child: ListView(
                                            shrinkWrap: true,
                                            children:[
                                              SizedBox(height: 64),
                                              Padding(
                                                padding: const EdgeInsets.only(left:2,right:2),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(16),
                                                      color: Colors.white.withOpacity(0.15)
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(left:2,right: 10,top: 5,bottom: 5),
                                                    child: TextFormField(
                                                      style:TextStyle(color: HexColor('#FFFFFF')),
                                                      controller: email_AddressC,
                                                      decoration: InputDecoration(
                                                        border: InputBorder.none,
                                                        //contentPadding: EdgeInsets.only(left: 32,right: 32),
                                                        hintStyle: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight: FontWeight.w400,
                                                            fontFamily: 'Poppins',
                                                            color: HexColor('#A2A0A8')
                                                        ),
                                                        hintText: 'Email Address',
                                                        prefixIcon: Padding(
                                                          padding: EdgeInsets.all(12),
                                                          child: SvgPicture.asset('asset/new icons/envelope 1.svg',
                                                            height: 12,
                                                            width: 24,
                                                          ),
                                                        ),
                                                      ),
                                                      validator: validateEmailField
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 30),
                                              InkWell(
                                                onTap: (){
                                                  if (_formkey.currentState!.validate()) {
                                                    loginwithEmail();
                                                      //SignUp
                                                      // otpverify (context);
                                                }
                                                },
                                                child:  Container(
                                                  margin: EdgeInsets.only(left: 2,right: 2),
                                                  decoration: BoxDecoration(
                                                      color: HexColor('#ED1D22'),
                                                      borderRadius: BorderRadius.circular(13)),
                                                  width: MediaQuery.of(context).size.width,
                                                  height: 56,
                                                  child: Center(
                                                    child: loading ? CircularProgressIndicator(color: Colors.white,):  Text('Continue',style:TextStyle(
                                                        fontSize:18,fontWeight: FontWeight.w400,fontFamily: 'Aboshi',
                                                        color: HexColor ('#FFFFFF') ),),
                                                  ),
                                                ),
                                              ),
                                            ]
                                        )
                                    ),
                                  ],
                                ),
                            ),
                        ]
                    )
                )
            ),
          ],
        )
        )
    );
  }



}
