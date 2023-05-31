
import 'dart:io';

import 'package:android_intent_plus/android_intent.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';
import 'Homepage.dart';
import 'const.dart';

class LocationPage extends StatefulWidget {
  String phonenumer;
  bool check;
  LocationPage(this.phonenumer,this.check);

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  @override
  void initState() {
    check();
    _getCurrentPosition();
    gettoken();
    // TODO: implement initState
    super.initState();
  }
  String?Token;
  gettoken()async{
    setState(()async{
      Token= await FirebaseMessaging.instance.getToken();
    });

  }
  check(){
    if(widget.check!=true){

    }
  }
   File? _pickedFile;
  croppimage()async {
    if (_pickedFile == null) {
      ImagePicker _picker = ImagePicker();
      await _picker.pickImage(source: ImageSource.gallery).then((xFile) {
        if (xFile != null) {
          setState(() {
            _pickedFile = File(xFile.path);
          });
        }
      });
    }
  }
  String ram ="";
  String imageurl ="";
  bool isloading =false;
  Future uploadImagenew() async {
    setState((){
      ram = randomAlphaNumeric(10);
    });
    int status = 1;
    if(_pickedFile!=null) {
      var ref = FirebaseStorage.instance.ref().child('ShopImages').child("${_pickedFile!.path}.jpg");

      var uploadTask2 = await ref.putFile(_pickedFile!).catchError((error) async {
        status = 0;
      });


      if (status == 1) {
        imageurl = await uploadTask2.ref.getDownloadURL();
        print(imageurl);
        FirebaseFirestore.instance.collection("Shops").doc(FirebaseAuth.instance.currentUser!.uid).set(
            {
              "phone":widget.phonenumer,
              "name":name.text,
              "timestamp":DateTime.now().millisecondsSinceEpoch,
              "token":Token,
              "address":area.text,
              "pincode":pincode.text,
              "latitude":_currentPosition!.latitude,
              "longitude":_currentPosition!.longitude,
              "amount":0,
              "des":des.text,
              "status":"Unverified",
              "imgurl": imageurl,
              "order":false


            });
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
        setState(() {
          isloading=false;
        });

      }
    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please select a image to proceed")));
    }
  }
  @override
  Widget build(BuildContext context) {
    final double width=MediaQuery.of(context).size.width;
    final double height=MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [

          SingleChildScrollView(
            child: Padding(
              padding:  EdgeInsets.only(top: 40.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: (){
                      croppimage();
                    },
                    child: Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                          color: primarycolor,
                          borderRadius: BorderRadius.circular(80)
                      ),
                      child: _pickedFile==null?Center(
                        child: Icon(Icons.camera_alt_rounded,size: 80,color: Colors.white,),
                      ): ClipRRect(
                        borderRadius: BorderRadius.circular(80),
                          child: Image.file(_pickedFile!,fit: BoxFit.cover,)),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      _getCurrentPosition();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text("Upload your Shop Image and Details",style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: width/15.84,
                      ),
                      textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Enter your Shop Details \n This will be displayed to all users",style: GoogleFonts.poppins(
                      color: Colors.black45,
                      fontWeight: FontWeight.w600,
                      fontSize: width/22.84,
                    ),
                    textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: name,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        hintText: "Type your name",
                        prefixIcon: Icon(Icons.person),
                        labelText: "Shop Name",
                        labelStyle: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: width/26.84,
                        ),
                        hintStyle: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: width/26.84,
                        ),




                      ),
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: width/22.84,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: des,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        hintText: "Type your name",
                        prefixIcon: Icon(Icons.comment),
                        labelText: "Shop Description",
                        labelStyle: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: width/26.84,
                        ),
                        hintStyle: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: width/26.84,
                        ),




                      ),
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: width/22.84,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: area,

                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        hintText: "Type your area name",
                        prefixIcon: Icon(Icons.location_on),
                        labelText: "Area",
                        labelStyle: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: width/26.84,
                        ),
                        hintStyle: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: width/26.84,
                        ),




                      ),
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: width/22.84,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: pincode,

                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        hintText: "Type your area pincode",
                        prefixIcon: Icon(Icons.pin_drop),
                        labelText: "Pincode",
                        labelStyle: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: width/26.84,
                        ),
                        hintStyle: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: width/26.84,
                        ),




                      ),
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: width/22.84,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: GestureDetector(
                      onTap: (){
                        uploadImagenew();
                        setState(() {
                          isloading=true;
                        });


    print("Valied Otp");





                      },
                      child: Container(

                        width: 300,
                        height: 60,
                        decoration: BoxDecoration(
                            color: primarycolor,
                            borderRadius: BorderRadius.circular(15)
                        ),
                        child: Center(
                          child: Text("Submit",style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: width/22.84,
                          )),
                        ),
                      ),
                    ),
                  )




                ],
              ),
            ),
          ),
          isloading==true?CircularProgressIndicator(): Container()

        ],
      ),
    );
  }
  String _currentAddress="";
  String _currentpincode="";
  Position? _currentPosition;
  TextEditingController name= new TextEditingController();
  TextEditingController des= new TextEditingController();
  TextEditingController area= new TextEditingController();
  TextEditingController pincode= new TextEditingController();

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      permission = await Geolocator.checkPermission();
      permission = await Geolocator.requestPermission();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
      _getAddressFromLatLng(_currentPosition!);
      print(_currentPosition);
    }).catchError((e) {
      debugPrint(e);
    });

  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
        _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress = '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea},';
        _currentpincode = '${place.postalCode}';
        setState(() {
          print(_currentAddress);
          area.text=_currentAddress;
          pincode.text=_currentpincode;
        });
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }
  location(){
    String origin="${_currentPosition!.latitude},${_currentPosition!.longitude}";  // lat,long like 123.34,68.56
    String destination="${_currentPosition!.latitude},${_currentPosition!.longitude}";

      final AndroidIntent intent = new AndroidIntent(
          action: 'action_view',
          data: Uri.encodeFull(
              "https://www.google.com/maps/dir/?api=1&origin=" +
                  origin + "&destination=" + destination + "&travelmode=driving&dir_action=navigate"),
          package: 'com.google.android.apps.maps');
      intent.launch();
    }


}
