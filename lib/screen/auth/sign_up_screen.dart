import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import '../../FormTextField/Validation_Form_field.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../t_c_screen.dart';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool chack3 = true;
  bool chack2 = true;
  bool? check1 = false;
  bool loading = false;

  final _formKey = GlobalKey<FormState>();

  TextEditingController fullNameC = TextEditingController();
  TextEditingController phone_Number = TextEditingController();
  TextEditingController email_Address = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirm_Password = TextEditingController();

  void signUpwithemail() async {
    loading = true;
    try {
      final response = await http.post(
        Uri.parse("http://192.168.1.23:4000/signUp"),
        body: {
          'full_name': fullNameC.value.text,
          'phone_number': phone_Number.value.text,
          "email": email_Address.value.text,
          "password": password.value.text,
        },
      ).timeout(Duration(seconds: 30));
      var data = jsonDecode(response.body);
      print(response.statusCode);
      print(data);
      bool login = data['success'];
      print("${data["message"]}");
      print(login);
      if (login) {
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
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => LoginScreen()));

        loading = false;
      } else {
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
      }
    } catch (e) {
      loading = false;

      loading = false;
      print(e.toString());
    }
  }
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // drawerEnableOpenDragGesture: false,
        // resizeToAvoidBottomInset: false,
        body: SafeArea(
      child: Stack(
        children: [
          Container(
            constraints: BoxConstraints.expand(),
            decoration: const BoxDecoration(
              image: DecorationImage(
                  //filterQuality: Filter,
                  image: AssetImage('asset/images/Teady.png'),
                  fit: BoxFit.cover),
            ),
          ),
          Container(
              constraints: BoxConstraints.expand(), color: Colors.black38),
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              constraints: BoxConstraints.expand(),
              height: 600,
              width: 250,
              child: SingleChildScrollView(
                  child: Column(children: [
                SizedBox(height: 7),
                Container(
                    padding: EdgeInsets.only(top: 71, left: 40, right: 30),
                    alignment: Alignment.topCenter,
                    child: Image.asset('asset/new icons/logo.png')),
                SizedBox(height: 31),
                Text('Signup ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 24,
                        fontFamily: 'Aboshi',
                        fontWeight: FontWeight.w400,
                        color: HexColor('#FFFFFF'))),
                SizedBox(height: 5),
                Container(
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.center,
                    child: Text(
                      'Create an account to continue!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          color: HexColor('#FFFFFF')),
                    )),
                Container(
                  child: Form(
                      key: _formKey,
                      child: ListView(
                          shrinkWrap: true,
                          physics: const ClampingScrollPhysics(),
                          //scrollDirection: Axis.horizontal,
                          children: [
                            //  const Text("Email"),
                            SizedBox(height: 42),
                            Padding(
                                padding:
                                    const EdgeInsets.only(left: 12, right: 12),
                                child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.white.withOpacity(0.15)),
                                    child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10,
                                            right: 10,
                                            top: 5,
                                            bottom: 5),
                                        child: TextFormField(
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
                                            style: TextStyle(
                                                color: HexColor('#FFFFFF')),
                                            controller: fullNameC,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintStyle: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: 'Poppins',
                                                  color: HexColor('#A2A0A8')),
                                              hintText: 'Full Name',
                                              prefixIcon: Padding(
                                                padding: EdgeInsets.all(10),
                                                child: SvgPicture.asset(
                                                  'asset/new icons/user.svg',
                                                  height: 12,
                                                  width: 24,
                                                ),
                                              ),
                                            ),
                                            validator: validateName)))),

                            SizedBox(height: 24),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 12, right: 12),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white.withOpacity(0.15)),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10, top: 5, bottom: 5),
                                  child: TextFormField(
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      style:
                                          TextStyle(color: HexColor('#FFFFFF')),
                                      controller: phone_Number,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintStyle: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'Poppins',
                                            color: HexColor('#A2A0A8')),
                                        hintText: 'Phone Number',
                                        prefixIcon: Padding(
                                          padding: EdgeInsets.all(10),
                                          child: SvgPicture.asset(
                                            'asset/new icons/call.svg',
                                            height: 12,
                                            width: 24,
                                          ),
                                        ),
                                      ),
                                      validator: validateMobile),
                                ),
                              ),
                            ),

                            SizedBox(height: 24),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 12, right: 12),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white.withOpacity(0.15)),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10, top: 5, bottom: 5),
                                  child: TextFormField(
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      style:
                                          TextStyle(color: HexColor('#FFFFFF')),
                                      controller: email_Address,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintStyle: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'Poppins',
                                            color: HexColor('#A2A0A8')),
                                        hintText: 'Email Address',
                                        prefixIcon: Padding(
                                          padding: EdgeInsets.all(10),
                                          child: SvgPicture.asset(
                                            'asset/new icons/envelope 1.svg',
                                            height: 12,
                                            width: 24,
                                          ),
                                        ),
                                      ),
                                      validator: validateEmailField),
                                ),
                              ),
                            ),
                            SizedBox(height: 24),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 12, right: 12),
                              child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.white.withOpacity(0.15)),
                                  child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10,
                                          right: 10,
                                          top: 5,
                                          bottom: 5),
                                      child: TextFormField(
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          style: TextStyle(
                                              color: HexColor('#FFFFFF')),
                                          controller: password,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintStyle: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: 'Poppins',
                                                color: HexColor('#A2A0A8')),
                                            hintText: 'Password',
                                            prefixIcon: Padding(
                                              padding: EdgeInsets.all(10),
                                              child: SvgPicture.asset(
                                                'asset/new icons/lock.svg',
                                                height: 12,
                                                width: 24,
                                              ),
                                            ),
                                            suffixIcon: InkWell(
                                              onTap: () {
                                                setState(() {
                                                  chack3 = !chack3;
                                                });
                                              },
                                              child: Padding(
                                                padding: EdgeInsets.all(10),
                                                child: chack3
                                                    ? SvgPicture.asset(
                                                        'asset/new icons/Eye Slash.svg',
                                                        height: 12,
                                                        width: 24,
                                                        color: Colors.grey,
                                                      )
                                                    : SvgPicture.asset(
                                                        'asset/new icons/eye (1).svg',
                                                        height: 12,
                                                        width: 24,
                                                        color: Colors.grey,
                                                      ),
                                              ),
                                            ),
                                          ),
                                          obscureText: chack3,
                                          validator: validatePassword))),
                            ),
                            SizedBox(height: 24),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 12, right: 12),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white.withOpacity(0.15)),
                                child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10, top: 5, bottom: 5),
                                    child: TextFormField(
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      style:
                                          TextStyle(color: HexColor('#FFFFFF')),
                                      controller: confirm_Password,
                                      obscureText: chack2,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintStyle: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'Poppins',
                                            color: HexColor('#A2A0A8')),
                                        hintText: 'Confirm Password',
                                        prefixIcon: Padding(
                                          padding: EdgeInsets.all(10),
                                          child: SvgPicture.asset(
                                            'asset/new icons/lock.svg',
                                            height: 12,
                                            width: 24,
                                          ),
                                        ),
                                        suffixIcon: InkWell(
                                          onTap: () {
                                            setState(() {
                                              chack2 = !chack2;
                                            });
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.all(10),
                                            child: chack2
                                                ? SvgPicture.asset(
                                                    'asset/new icons/Eye Slash.svg',
                                                    height: 12,
                                                    width: 24,
                                                    color: Colors.grey,
                                                  )
                                                : SvgPicture.asset(
                                                    'asset/new icons/eye (1).svg',
                                                    height: 12,
                                                    width: 24,
                                                    color: Colors.grey,
                                                  ),
                                          ),
                                        ),
                                      ),
                                    )),
                              ),
                            ),

                            SizedBox(height: 2),
                            Container(
                              padding:
                                  EdgeInsets.only(top: 1, left: 3, right: 3),
                              width: MediaQuery.of(context).size.width,
                              alignment: Alignment.centerLeft,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                      padding: EdgeInsets.only(
                                          top: 25, left: 7, right: 32)),
                                  Row(
                                    children: [
                                      Container(
                                        width: 50,
                                        child: CheckboxListTile(
                                            activeColor: HexColor('#ED1D22'),
                                            contentPadding:
                                                EdgeInsets.only(left: 3),
                                            side: BorderSide(
                                              //style: BorderRadius.all(Radius.circular(radius)),
                                              // set border color here
                                              color: HexColor('#FFFFFF'),
                                            ),
                                            title: Text(""),
                                            controlAffinity:
                                                ListTileControlAffinity.leading,
                                            //
                                            // <-- leading Checkbox
                                            value: check1,
                                            checkboxShape:
                                                BeveledRectangleBorder(),
                                            checkColor: HexColor('#F5F5F5'),
                                            selectedTileColor:
                                                HexColor('#FFFFFF'),
                                            onChanged: (bool? value) {
                                              setState(
                                                () {
                                                  check1 = value;
                                                },
                                              );
                                              //  controlAffinity: ListTileControlAffinity.leading;
                                              //  <-- leading Checkbox
                                            }),
                                      ),
                                      SizedBox(
                                        width: MediaQuery.of(context).size.width * 0.7,
                                        child: RichText(
                                            text: TextSpan(
                                                text:
                                                    'By creating an account, you aggree to our ',
                                                style: TextStyle(
                                                    color: HexColor('#FFFFFF'),
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 14),
                                                children: <InlineSpan>[
                                              TextSpan(
                                                  text: 'Terms & Conditions',
                                                  style: TextStyle(
                                                      color:
                                                          HexColor('#ED1D22'),
                                                      fontFamily: 'Poppins',
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 14),
                                                  recognizer:
                                                      TapGestureRecognizer()
                                                        ..onTap = () {
                                                    Navigator.push(context, MaterialPageRoute(builder: (context) => TCScreen(),));
                                                          print(
                                                              'Terms of Service');
                                                        }),
                                            ])),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ])),
                ),
                SizedBox(height: 27),
                InkWell(
                  onTap: () {
                    // if(Password==Confirm_Password)
                    if (_formKey.currentState!.validate()) {
                      print(password.text.toString());
                      print(confirm_Password.text.toString());
                      if (password.text == confirm_Password.text) {
                        print('hhhih');
                        signUpwithemail();
                        setState(() {});
                      }else{
                        Fluttertoast.showToast(
                          msg: "password and confirm password doesn't match",
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

                      }
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        color: HexColor('#ED1D22'),
                        borderRadius: BorderRadius.circular(13)),
                    width: MediaQuery.of(context).size.width,
                    height: 56,
                    child: loading
                        ? Center(
                            child: CircularProgressIndicator(
                            color: Colors.white,
                          ))
                        : Center(
                            child: Text(
                              'Signup',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "Aboshi",
                                  color: HexColor('#FFFFFF')),
                            ),
                          ),
                  ),
                ),
                SizedBox(height: 25),
                InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => LoginScreen()));
                    },
                    child: Container(
                        padding: EdgeInsets.only(
                            top: 2, left: 7, right: 7, bottom: 80),
                        child: Center(
                          child: RichText(
                              text: TextSpan(
                                  text: 'Already have an account?',
                                  style: TextStyle(
                                      color: HexColor('#FFFFFF'),
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14),
                                  children: <InlineSpan>[
                                const WidgetSpan(
                                    alignment: PlaceholderAlignment.baseline,
                                    baseline: TextBaseline.alphabetic,
                                    child: SizedBox(width: 5)),
                                TextSpan(
                                  text: 'Login',
                                  style: TextStyle(
                                      color: HexColor('#ED1D22'),
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14),
                                ),
                              ])),
                        )))
              ]))),
        ],
      ),
    ));
  }
}
