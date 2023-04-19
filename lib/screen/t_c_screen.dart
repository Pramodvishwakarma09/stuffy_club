import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:stuffy_club/models/t_c_model.dart';


class TCScreen extends StatelessWidget {
   TCScreen({Key? key}) : super(key: key);



   Future<TcModel> loadAssets2() async {
     print('stringValue.toString()');
     // SharedPreferences prefs = await SharedPreferences.getInstance();
     // var stringValue = prefs.getInt('user_id');

     TcModel lm;
     String url = "http://192.168.1.23:4000/termsandcondition";
     http.Response response = await http.post(Uri.parse(url),
         body: {'category_id': "1"});
     Map<String, dynamic> jsonresponse = jsonDecode(response.body);
     lm = TcModel.fromJson(jsonresponse);

     // var  free&paad = data
     return lm;
   }


   @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: FutureBuilder(
            future: loadAssets2(),
            builder: (context, AsyncSnapshot<TcModel> snapshot) {
              if(snapshot.hasData){
                return Html(data: """${snapshot.data!.terms.toString()}""",);
              }else{
                return Center(child: CircularProgressIndicator());
              }
            },
          )
          // Html(data: """${tcController.getdata!.terms.toString()}""",),
        ),
      )

    );
  }
}
