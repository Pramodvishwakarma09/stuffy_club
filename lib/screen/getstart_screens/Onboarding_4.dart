
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';

import '../Auth/login_screen.dart';


class Onboarding_4 extends StatefulWidget {
  const Onboarding_4({Key? key}) : super(key: key);

  @override
  State<Onboarding_4> createState() => _Onboarding_4State();
}

class _Onboarding_4State extends State<Onboarding_4> {
  Route createRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween = Tween(begin: begin, end: end).chain(
            CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: HexColor('#333333'),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Container(
              color: HexColor('#333333'),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 75),
                  //  sizedboxheight(deviceheight(context,15)),
                  Image.asset('asset/new icons/Mask group (3).png',
                     height: MediaQuery.of(context).size.height/2,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.fill,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left:32,top:15),
                    child: Text('Create a sprite  '
                        '\nof a stuffy',
                      style: TextStyle(fontSize: 32,
                          fontFamily: 'Aboshi',
                          fontWeight: FontWeight.w400,
                          color: HexColor('#FFFFFF')),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(left:32,top:12,),
                    child: Text('Lorem ipsum dolor sit amet, consectetur'
                        '\nadipiscing elit, sed do eiusmod tempor'
                        '\nincididunt ut labore.',
                      style: TextStyle(fontSize: 14,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                          color: HexColor('#E3E3E3')),
                    ),
                  ),],
              ),
            ),
            // Positioned(
            //   top: 20,
            //   child: Container(
            //     width: MediaQuery.of(context).size.width,
            //     alignment: Alignment.topRight,
            //     child: Padding(
            //       padding: EdgeInsets.only(left:32,top:2),
            //       // child: Row(
                    //
                      // TextButton(onPressed: () {
                      //   Navigator.of(context).push(createRoute(
                      //       Login()));
                      // },

                      //   child: Text('Skip', style: TextStyle(fontSize: 14,
                      //     fontFamily: 'Annie Use Your Telescope',
                      //     fontWeight: FontWeight.w400,
                      //     color: HexColor('#E3E3E3'),
                      //   ),
                      //   ),
                      // ),
                      // Align(alignment: Alignment.topLeft,)
                      // // style: textstylesubtitle2(context)!.copyWith
                      // // (color: colorWhite,fontFamily: "Poppins"),)),

            Positioned(
              bottom: 10,
              child: Container(
               // height:MediaQuery.of(context).size.height*0.2 ,
                height: MediaQuery.of(context).size.height/5,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: EdgeInsets.only(left:36,top:60,bottom:5 ,right:32),
                  //padding: EdgeInsets.only(left:36,top:43,bottom:47 ,right:32),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SvgPicture.asset("asset/new icons/Group 1 (3).svg",),

                      InkWell(
                        onTap: () {
                          Navigator.of(context).pushReplacement(createRoute(
                              LoginScreen())
                          );
                        },
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor: HexColor('#FFFFFF'),
                          child: SvgPicture.asset('asset/new icons/Circle4.svg'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
