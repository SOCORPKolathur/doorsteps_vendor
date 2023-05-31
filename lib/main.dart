import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doorsteps_vendor/Homepage.dart';
import 'package:doorsteps_vendor/WelcomePage.dart';
import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:system_alert_window/system_alert_window.dart';
import 'const.dart';


@pragma("vm:entry-point")
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AudioPlayer audioPlayer1 = AudioPlayer();
  String url1 ="https://firebasestorage.googleapis.com/v0/b/door-steps-1780c.appspot.com/o/Uber%20Ringtone.mp3?alt=media&token=082690ac-1e1f-4ce6-9f1c-b180baa7cfca";
  PlayerState audioPlayerState1 = PlayerState.PAUSED;
  pauseMusic1() async {
    await audioPlayer1.pause();
  }
  playMusic1() async {
    await audioPlayer1.play(url1,volume: 1.0,);
  }
  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.currentUser!=null? fuctiondemo(): dummy();
    getPermission();
    SystemAlertWindow.registerOnClickListener(callBack);
    audioPlayer1.onPlayerStateChanged.listen((PlayerState state) {
      setState(() {
        audioPlayerState1 = state;
      });
    }
    );

  }
  dummy(){}
  getPermission() async {
    await SystemAlertWindow.checkPermissions;
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Door Steps Vendor',
        debugShowCheckedModeBanner: false,
        theme: Theme.of(context).copyWith(
      colorScheme: Theme.of(context).colorScheme.copyWith(
        primary: primarycolor,
      ),),
      home: FirebaseAuth.instance.currentUser==null?WelcomePage():HomePage(),
    );
  }
  fuctiondemo(){
    final userwallet =
    FirebaseFirestore.instance.collection('Shops').doc(FirebaseAuth.instance.currentUser!.uid.toString());
    userwallet.snapshots().listen(
          (event) {
        print("user wallet");
        Map<String, dynamic>? value = event.data();

        if(value!["order"]==true){
          playMusic1();
          SystemAlertWindow.showSystemWindow(
            prefMode: SystemWindowPrefMode.OVERLAY,
            notificationTitle: "Got a Order",
            notificationBody: "Click to view",isDisableClicks: false,

            backgroundColor: primarycolor,



            width: 350,
            height: 165,
            gravity: SystemWindowGravity.CENTER,


            header: value!["order"]==true ?SystemWindowHeader(

              padding: SystemWindowPadding(left: 20),
              decoration: SystemWindowDecoration(
                borderRadius: 12,


                  startColor: primarycolor, endColor: primarycolor),
              title:  SystemWindowText(
                padding: SystemWindowPadding(top: 10),

                  text: "Got a order 🔔", textColor: Colors.white,  fontSize: 30,
                fontWeight: FontWeight.BOLD_ITALIC,),
              subTitle: SystemWindowText(
                  text: "Order ID:sdgsdg",
                  textColor: Colors.white,  fontSize: 22,
                fontWeight: FontWeight.BOLD,),
            ) : SystemWindowHeader(),
            /*body:value!["order"]==true ? SystemWindowBody(

                decoration: SystemWindowDecoration(
                    startColor: primarycolor, endColor:primarycolor),
                padding: SystemWindowPadding(left: 20),
                rows: [

                  EachRow(
                      columns: [

                        EachColumn(
                          text: SystemWindowText(
                              text: "",
                              fontSize: 20,

                              textColor: Colors.white),
                        )
                      ])
                ]) :SystemWindowBody(),

             */
            footer: value!["order"]==true ? SystemWindowFooter(
              buttons: [

                SystemWindowButton(
                  margin: SystemWindowMargin(left:10,right:10,top: 10,bottom: 50),
                  decoration: SystemWindowDecoration(
                    borderRadius: 20.0,
                    startColor: Colors.black,
                    endColor: Colors.black,
                  ),


                  width: 40,
                  height: 60,




                  text: SystemWindowText(text: 'Accept Order',textColor: Colors.white,fontWeight: FontWeight.BOLD,fontSize: 18), tag: "close",)
              ],

            ) : SystemWindowFooter(),

          );

        }
        else if(value!["order"]==false){
          pauseMusic1();
          SystemAlertWindow.closeSystemWindow(prefMode: SystemWindowPrefMode.OVERLAY);
        }

      },
      onError: (error) => print("Listen failed: $error"),
    );

  }
}


Future<void> callBack(tag) async {
  print(tag);
  if (tag == "close") {
    print("close worked");
    SystemAlertWindow.closeSystemWindow(
        prefMode: SystemWindowPrefMode.OVERLAY
    );
    await LaunchApp.openApp(
      androidPackageName: 'com.example.doorsteps_vendor',
      // openStore: false
    );

  }
}
