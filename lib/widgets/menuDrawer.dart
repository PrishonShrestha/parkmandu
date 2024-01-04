import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parkmandu/screens/aboutUs_screen.dart';
import 'package:parkmandu/screens/parkingHistory_screen.dart';
import 'package:provider/provider.dart';
import '../controllers/auth_controller.dart';

class MenuDrawer extends StatelessWidget {
  MenuDrawer({super.key});

  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Drawer(
      backgroundColor: Color(0xFFADD8E6),
      width: size.width*0.75,
      child: Padding(
        padding: const EdgeInsets.only(top: 40, bottom: 40, left: 15, right: 15),
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFFFFFFF).withOpacity(0.5),
            borderRadius: BorderRadius.circular(20),
          ),

          child: Column(
            children: [
              ListTile(
                title: Row(
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                              image: NetworkImage(user?.photoURL ?? "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR-vbvUQGPXlB91GQ3KiO7daFXSrHxoztyy2GhPk5q6k4l7B71dgxxh0Tde6FfKRxZVCNE&usqp=CAU"),
                              fit: BoxFit.fill
                          )
                      ),
                    ),
                    SizedBox(width: 20,),
                    Container(
                      width: size.width*0.35,
                      child: Text(
                        user?.displayName ??
                        "Username",
                        style: GoogleFonts.lora(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
              Container(height: 20, color: Color(0xFFADD8E6),),
              SizedBox(height:20),
              ListTile(
                title: Text('Parking history', style: GoogleFonts.oswald(fontSize: 18, color: Color(0xFF1E1E1E)),),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context)=> ParkingHistory()),
                  );
                },
              ),
              /*Divider(
                thickness: 0.5,
                color: Colors.grey,
                indent: 5,
                endIndent: 5,
              ),*/
              ListTile(
                title: Text('User guide', style: GoogleFonts.oswald(fontSize: 18, color: Color(0xFF1E1E1E)),),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('About us', style: GoogleFonts.oswald(fontSize: 18, color: Color(0xFF1E1E1E)),),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context)=> AboutUs()),
                  );
                },
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 50,
                    width: 180,
                    child: ElevatedButton.icon(
                        onPressed: (){
                          final provider = Provider.of<AuthController>(context, listen: false);
                          provider.logoutUser();
                        },
                        icon: Icon(Icons.exit_to_app_outlined),
                        label: Text("Sign Out"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF1E1E1E),
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20,),
            ],
          ),
        ),
      ),
    );
  }
}
