import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:uuid/uuid.dart';

import 'const.dart';
class Addproducts extends StatefulWidget {
  String Cateroriges;
  Addproducts(this.Cateroriges);

  @override
  State<Addproducts> createState() => _AddproductsState();
}

class _AddproductsState extends State<Addproducts> {
  TextEditingController product_name = TextEditingController();
  TextEditingController product_price = TextEditingController();
  TextEditingController product_quvantity = TextEditingController();
  TextEditingController product_des = TextEditingController();


  @override
  void initState() {
    getuser();
    setState(() {
      product_name.clear();
      product_price.clear();
      product_quvantity.clear();
      product_des.clear();
    });
    // TODO: implement initState
    super.initState();
  }
  bool isloading =false;

  @override
  Widget build(BuildContext context) {
    final double height=MediaQuery.of(context).size.height;
    final double width=MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Products",style: GoogleFonts.poppins(fontWeight: FontWeight.w600),),
      ),
      body:
      SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: height / 67.6),
            //select image
            GestureDetector(
              onTap: (){
                _getFromGallery();
                setState(() {
                  isloading =true;
                });
              },
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                    color: primarycolor,
                    borderRadius: BorderRadius.circular(20)
                ),
                child: imageFile==null?Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.camera_alt_rounded,size: 70,color: Colors.white,),
                          Text("Select Product \n Image",textAlign:TextAlign.center,style: GoogleFonts.poppins(
                              color: Colors.white,fontWeight: FontWeight.w600)),
                        ],
                      ),
                      isloading==true? CircularProgressIndicator():Container()
                    ],
                  ),
                ): ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.file(imageFile!,fit: BoxFit.cover,)),
              ),
            ),

            SizedBox(height: height / 75.6),
            //categeries textfield
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [

                  Container(
                    child: Column(

                      children: [
                        Text("Product Name", style: GoogleFonts.poppins(
                            color: Colors.black),),
                        SizedBox(height: height / 151.2),
                        Card(
                          elevation: 7,
                          shape: RoundedRectangleBorder(
                            borderRadius:BorderRadius.circular(7),),
                          child: Container(
                            height: height / 15.12,
                            width: width / 1.15,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                color: Colors.white38
                            ),
                            child: TextField(
                              controller: product_name,
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  fontSize: width / 30,
                                  color: Colors.black
                              ),
                              cursorColor: Colors.indigo,

                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(
                                      left: width / 18),
                                  hintText: "Apple",
                                  hintStyle: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,
                                      fontSize: width / 30,
                                      color: Colors.black54
                                  )
                              ),
                            ),
                          ),
                        ),
                      ],
                      crossAxisAlignment: CrossAxisAlignment.start,
                    ),
                  ),
                  SizedBox(width: 10,),



                ],
              ),
            ),
            SizedBox(height: height / 75.6),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [

                  Container(
                    child: Column(

                      children: [
                        Text("Product Price", style: GoogleFonts.poppins(
                            color: Colors.black),),
                        SizedBox(height: height / 151.2),
                        Card(
                          elevation: 7,
                          shape: RoundedRectangleBorder(
                            borderRadius:BorderRadius.circular(7),),
                          child: Container(
                            height: height / 15.12,
                            width: width / 1.15,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                color: Colors.white38
                            ),
                            child: TextField(
                              controller: product_price,
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  fontSize: width / 30,
                                  color: Colors.black
                              ),
                              cursorColor: Colors.indigo,

                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(
                                      left: width / 18),
                                  hintText: "100.00",
                                  hintStyle: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,
                                      fontSize: width / 30,
                                      color: Colors.black54
                                  )
                              ),
                            ),
                          ),
                        ),
                      ],
                      crossAxisAlignment: CrossAxisAlignment.start,
                    ),
                  ),
                  SizedBox(width: 10,),



                ],
              ),
            ),
            SizedBox(height: height / 75.6),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [

                  Container(
                    child: Column(

                      children: [
                        Text("Product Minimum Quantity", style: GoogleFonts.poppins(
                            color: Colors.black),),
                        SizedBox(height: height / 151.2),
                        Card(
                          elevation: 7,
                          shape: RoundedRectangleBorder(
                            borderRadius:BorderRadius.circular(7),),
                          child: Container(
                            height: height / 15.12,
                            width: width / 1.15,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                color: Colors.white38
                            ),
                            child: TextField(
                              controller: product_quvantity,
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  fontSize: width / 30,
                                  color: Colors.black
                              ),
                              cursorColor: Colors.indigo,

                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(
                                      left: width / 18),
                                  hintText: "10 Kgs",
                                  hintStyle: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,
                                      fontSize: width / 30,
                                      color: Colors.black54
                                  )
                              ),
                            ),
                          ),
                        ),
                      ],
                      crossAxisAlignment: CrossAxisAlignment.start,
                    ),
                  ),
                  SizedBox(width: 10,),



                ],
              ),
            ),
            SizedBox(height: height / 75.6),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [

                  Container(
                    child: Column(

                      children: [
                        Text("Product Description", style: GoogleFonts.poppins(
                            color: Colors.black),),
                        SizedBox(height: height / 151.2),
                        Card(
                          elevation: 7,
                          shape: RoundedRectangleBorder(
                            borderRadius:BorderRadius.circular(7),),
                          child: Container(
                            height: height / 12.12,
                            width: width / 1.15,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                color: Colors.white38
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 6.0,),
                              child: TextField(
                                keyboardType: TextInputType.multiline,
                                maxLines: 4,
                                controller: product_des,
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                    fontSize: width / 30,
                                    color: Colors.black
                                ),
                                cursorColor: Colors.indigo,

                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.only(
                                        left: width / 18),
                                    hintText: "Red apple is good for your health",
                                    hintStyle: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w500,
                                        fontSize: width / 30,
                                        color: Colors.black54
                                    )
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                      crossAxisAlignment: CrossAxisAlignment.start,
                    ),
                  ),
                  SizedBox(width: 10,),



                ],
              ),
            ),

            SizedBox(height: height / 75.6),



            //Product price textfield



            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [

                //cancel button
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Material(
                    elevation: 25,
                    child: Container(
                      height: height / 18.9,
                      width: width / 3.60,
                      decoration: BoxDecoration(
                        color: Colors.redAccent,

                          borderRadius: BorderRadius.circular(4)
                      ),
                      child: Center(
                        child: Text("Cancel", style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w700,
                            color: Colors.white
                        ),),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: width / 36.0,),

                //Submit button
                InkWell(
                  onTap: () {
                    showdialog();
                  },
                  child: Material(
                    elevation: 25,
                    color: Colors.transparent,
                    child: Container(
                      height: height / 18.9,
                      width: width / 3.60,
                      decoration: BoxDecoration(
                          color: primarycolor,
                          borderRadius: BorderRadius.circular(4)
                      ),
                      child: Center(
                        child: Text("Submit", style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w700,
                            color: Colors.white
                        ),),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: width / 12,),


              ],
            ),
            SizedBox(height: height / 25.2),


          ],
        ),
      ),


    );
  }



  String imgUrl='';
  int status=0;

  File?imageFile;
  String fileName = Uuid().v1();

  _getFromGallery() async {
    PickedFile ?pickedFile = (await ImagePicker().getImage(source: ImageSource.gallery,));
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      print(imageFile);
    }

    var ref = FirebaseStorage.instance.ref().child('NewFiles').child("$imageFile.jpg");
    var uploadTask = await ref.putFile(imageFile!).catchError((error) async {
      status = 0;
      print("error");
    });
    String imageUrl = await uploadTask.ref.getDownloadURL();
    print(imageUrl);
    setState(() {
      imgUrl=imageUrl;
    });
    print(imgUrl);
    setState(() {
      isloading=false;
    });

  }
  String name ="";
  String phone ="";
  String pincode ="";
  String address ="";
  double latitude =0.00;
  double longitude =0.00;
  getuser() async {
    var document = await FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser!.uid.toString()).get();
    Map<String, dynamic>? value = document.data();
    setState(() {
      name=value!["name"];
      phone=value["phone"];
      pincode=value["pincode"];
      address=value["address"];
      latitude=double.parse(value["latitude"].toString());
      longitude=double.parse(value["longitude"].toString());
    });
  }
  showdialog(){
    FirebaseFirestore.instance.collection("products").doc().set({
      "name":product_name.text,
      "descirpition":product_des.text,
      "image":imgUrl,
      "price":int.parse(product_price.text),
      "quantity":product_quvantity.text,
      "vender":name,
      "type":"Fruits",
      "vendorID":FirebaseAuth.instance.currentUser!.uid.toString(),
    });

    FirebaseFirestore.instance.collection("Shops").doc(FirebaseAuth.instance.currentUser!.uid.toString()).collection("Products").doc().set({
      "name":product_name.text,
      "des":product_des.text,
      "image":imgUrl,
      "price":int.parse(product_price.text),
      "quantity":product_quvantity.text,
      "vender":name,
      "type":"Fruits",
      "vendorID":FirebaseAuth.instance.currentUser!.uid.toString(),
    });

  }
  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title:  Text("Product Added Successfully...",style: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.w800,
            fontSize: 18,
          ),
            textAlign: TextAlign.center,

          ),
          content: Lottie.asset('assets/done.json',),
          alignment: Alignment.center,
          actionsAlignment: MainAxisAlignment.center,
          titlePadding: EdgeInsets.all(8),
          actions: [
            GestureDetector(
              onTap: () async {
                Navigator.of(context).pop();
                product_name.clear();
                product_des.clear();
                product_price.clear();
                product_quvantity.clear();


              },
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Container(
                  width: 60,
                  height: 30,
                  decoration: BoxDecoration(
                    color: primarycolor,
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: Center(child:  Text("Ok",style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ))),
                ),
              ),
            )
          ],


        );
      },
    );
  }
}
//firestore create data function


