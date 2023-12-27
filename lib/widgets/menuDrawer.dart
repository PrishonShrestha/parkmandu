import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class MenuDrawer extends StatelessWidget {
  const MenuDrawer({super.key});

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
                              image: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR-vbvUQGPXlB91GQ3KiO7daFXSrHxoztyy2GhPk5q6k4l7B71dgxxh0Tde6FfKRxZVCNE&usqp=CAU"),
                              fit: BoxFit.fill
                          )
                      ),
                    ),
                    SizedBox(width: 20,),
                    Text(
                      "Username",
                      style: GoogleFonts.lora(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ],
                ),
              ),
              Container(height: 20, color: Color(0xFFADD8E6),),
              SizedBox(height:20),
              ListTile(
                title: Text('Your parking history'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              Divider(
                thickness: 0.5,
                color: Colors.grey,
                indent: 5,
                endIndent: 5,
              ),
              ListTile(
                title: Text('About us'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              Divider(
                thickness: 0.5,
                color: Colors.grey,
                indent: 5,
                endIndent: 5,
              ),
              ListTile(
                title: Text('Contact us'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 50,
                    width: 180,
                    child: ElevatedButton.icon(
                        onPressed: null,
                        icon: Icon(Icons.exit_to_app_outlined),
                        label: Text("Sign Out"),
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
