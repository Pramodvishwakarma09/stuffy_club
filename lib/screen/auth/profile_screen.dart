import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../controller/profile_controller.dart';
import '../../models/profile_model.dart';
import 'edit_profile_screen.dart';
import 'package:get/get.dart';
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {




  Future<ProfileModel> loadAssets() async {
    print('stringValue.toString()');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var stringValue = prefs.getInt('user_id');

    ProfileModel lm;
    String url = "http://192.168.1.23:4000/myprofile";
    http.Response response =
        await http.post(Uri.parse(url), body: {"id": stringValue.toString() });
    Map<String, dynamic> jsonresponse = jsonDecode(response.body);
    lm = ProfileModel.fromJson(jsonresponse);

    // var  free&paad = data
    return lm;
  }



  @override
  void initState() {
    loadAssets();
    // TODO: implement initState
    super.initState();
  }

  final imagePicker = ImagePicker();
  // File? imageFile;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 1,
          backgroundColor: HexColor('#FFFFFF'),
          title: Text('My Profile',
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                  fontFamily: 'Aboshi',
                  color: HexColor('#333333'))),
          // leading: IconButton(icon: Icon(Icons.arrow_back_ios,
          //   color: HexColor('#000000'),),
          //   onPressed: (){
          //
          //   },
          // ),


          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(20,5,20,0),
          child:FutureBuilder(
            future: loadAssets(),
            builder: (context, AsyncSnapshot<ProfileModel> snapshot) {
              if (snapshot.hasData) {
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(child: ClipRRect(

                        borderRadius: BorderRadius.circular(500.0),
                        child: FadeInImage(
                            height: 150,
                            width: 150,
                            fadeInDuration: const Duration(milliseconds: 500),
                            fadeInCurve: Curves.easeInExpo,
                            fadeOutCurve: Curves.easeOutExpo,
                            placeholder: AssetImage(
                              "asset/images/demoprofile.png",
                            ),
                            image: NetworkImage(
                              snapshot.data!.profileImage,
                            ),
                            imageErrorBuilder: (context, error, stackTrace) {
                              return Container(
                                  child: Image.asset(
                                      "asset/images/demoprofile.png"));
                            },
                            fit: BoxFit.cover),
                      ),
                      ),
                      SizedBox(height: 8,),
                      Center(
                        child: Text(
                          '${snapshot.data!.data[0].fullName}',
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Aboshi',
                            fontWeight: FontWeight.w400,
                            color: HexColor('#000000'),
                          ),
                        ),
                      ),
                      SizedBox(height: 5,),

                      Center(child: Text("${snapshot.data!.data[0].email}")),
                      SizedBox(height: 10,),


                      profileCard(context, 75, "Phone Number", "+91 ${snapshot.data!.data[0].phoneNumber}"),
                      profileCard(context, 75, "Email Address", "${snapshot.data!.data[0].email}"),
                      Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          height: 75,
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Membership Plan',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'Aboshi',
                                      fontWeight: FontWeight.w400,
                                      color: HexColor('#000000'),
                                    ),
                                  ),
                                  Text(
                                    'Active',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400,
                                      color: HexColor('#00CA14'),
                                    ),
                                  ),

                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Free',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600,
                                      color: HexColor('#03A9D6'),
                                    ),

                                  ),
                                  Text(
                                    'Upgrade',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600,
                                      decoration: TextDecoration.underline,
                                      decorationColor: HexColor('#ED1D22'),
                                      decorationThickness: 1.5,
                                      color: HexColor('#ED1D22'),
                                    ),
                                  ),

                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditProfileScreen()
                              ),
                          );
                        },
                        child: Container(
                          //padding: const EdgeInsets.symmetric(16),
                          margin: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              color:Color(0xff86C33C),
                              borderRadius: BorderRadius.circular(13)),
                          width: MediaQuery.of(context).size.width,
                          height: 56,
                          child:
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Edit Profile  ',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'Aboshi',
                                      color: HexColor('#FFFFFF')),
                                ),
                                Icon(Icons.edit,color: Colors.white,)
                              ],
                            ),
                          ),
                        ),
                      ),


                    ],
                  ),
                );

              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),

        ));



  }
}
Widget profileCard(context, double height, String label, content) {
  return Card(
    elevation: 5,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    child: Container(
      padding: const EdgeInsets.all(10),
      height: height,
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Aboshi',
                fontWeight: FontWeight.w400,
                color: HexColor('#000000'),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              width: MediaQuery.of(context).size.width / 1.3,
              child: Text(
                content,
                maxLines: 4,
                style:  TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 14),
              ),
            )
          ],
        ),
      ),
    ),
  );
}
