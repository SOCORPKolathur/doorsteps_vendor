import 'package:doorsteps_vendor/signin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'const.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    final double width=MediaQuery.of(context).size.width;
    final double height=MediaQuery.of(context).size.height;
    return Scaffold(
      body: Padding(
        padding:  EdgeInsets.only(top: 40.0),
        child: Column(

          children: [
            Container(
              width: 300,
                height: 300,

                child: SvgPicture.asset("assets/welcome.svg")),
            Text("Welcome \n to Door Steps Vendor",style: GoogleFonts.poppins(
              color: primarycolor,
              fontWeight: FontWeight.w800,
              fontSize: width/7.84,
            ),
            textAlign: TextAlign.center,),
            Text("May you sales more with us",style: GoogleFonts.poppins(
            color: Colors.black,
              fontWeight: FontWeight.w700,
              fontSize: width/22.84,
            )),
            Padding(
              padding: const EdgeInsets.only(top: 35.0,left: 18,right: 18),
              child: GestureDetector(
                onTap: (){
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context)=> Signin())
                  );
                },
                child: Container(

                  width: 300,
                  height: 60,
                  decoration: BoxDecoration(
                      color: primarycolor,
                    borderRadius: BorderRadius.circular(15)
                  ),
                  child: Center(
                    child: Text("Get Started",style: GoogleFonts.poppins(
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

    );
  }
}
