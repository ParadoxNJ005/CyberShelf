import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:opinionx/pages/developerPage.dart';
import 'package:opinionx/utils/constants.dart';
import 'package:toggle_switch/toggle_switch.dart';

class CustomNavDrawer extends StatefulWidget {
  const CustomNavDrawer({super.key});

  @override
  State<CustomNavDrawer> createState() => _CustomNavDrawerState();
}

class _CustomNavDrawerState extends State<CustomNavDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
              color: Constants.WHITE,
              height: 150,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(top: 50),
                child: ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(80),
                    child: Container(
                      height: 60,
                      width: 60,
                      child: CachedNetworkImage(
                        // imageUrl: APIs.me!.imageUrl!,
                        imageUrl:
                            "https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&ixid=eyJhcHBfaWQiOjEyMDd9",
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                                colorFilter: ColorFilter.mode(
                                    Colors.white, BlendMode.colorBurn)),
                          ),
                        ),
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                  ),
                  title: Text(
                    // APIs.me!.name!,
                    "Naitik Jain",
                    style: GoogleFonts.epilogue(
                      textStyle: TextStyle(
                        fontSize: 20,
                        color: Constants.BLACK,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  subtitle: Text(
                    // APIs.me!.email!,
                    "naitikjain2005@gmail.com",
                    style: GoogleFonts.epilogue(
                      textStyle: TextStyle(
                        color: Constants.BLACK,
                      ),
                    ),
                  ),
                ),
              )),
          _list(Icons.calendar_today_rounded, "Subjects", () {
            // Navigator.push(context, MaterialPageRoute(builder: (_)=>SemViseSubjects()));
          }),
          _list(Icons.notifications_active, "Notifications", () {}),
          _list(Icons.location_on_outlined, "Address", () {}),
          _list(Icons.person, "Profile", () {
            // Navigator.push(context, MaterialPageRoute(builder: (_) => ProfilePage()));
          }),
          _list(Icons.payment, "Payment Methods", () {}),
          _list(Icons.local_offer_outlined, "Offers", () {}),
          _list(Icons.share, "Share", () {}),
          _list(Icons.support_agent_outlined, "About", () {Navigator.push(context, MaterialPageRoute(builder: (_)=>DeveloperPage()));}),
          _list(Icons.logout_outlined, "Sign out", () async {
            //  await APIs.Signout(); Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=>Auth()), (route) => false,);
          }),
          const Spacer(),
          Text(
            'Made with ❤️ By OpinionX',
            style: GoogleFonts.epilogue(
              textStyle: const TextStyle(
                fontSize: 15,
                color: Constants.BLACK,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 50,
          )
        ],
      ),
    );
  }

  Widget _list(IconData icon, String name, VoidCallback onPress) {
    return ListTile(
      onTap: onPress,
      leading: IconButton(
        icon: Icon(icon),
        onPressed: onPress,
      ),
      title: Text(name,
          style: GoogleFonts.epilogue(
            textStyle: TextStyle(
              fontSize: 20,
              color: Constants.BLACK,
              fontWeight: FontWeight.bold,
            ),
          )),
    );
  }
}
