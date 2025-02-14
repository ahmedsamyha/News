import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppDrawer extends StatefulWidget {
  Function onTap;

  AppDrawer({required this.onTap, super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    String dropdownLanguage = "english";
    String dropdownTheme = "light";

    return Container(
      color: Color(0xFF171717),
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width * 0.8,
      height: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              color: Colors.white,
              width: double.infinity,
              height: 220,
              alignment: Alignment.center,
              child: Text("News App",style: TextStyle(fontSize: 36,fontWeight: FontWeight.w500),)),
          InkWell(
            onTap: () {
              widget.onTap();
            },
            child: ListTile(
              leading: Icon(
                Icons.home_outlined,
                color: Colors.white,
              ),
              title: Text(
                "Back TO Home",
                style: TextStyle(color: Colors.white),
              ),
              subtitle: Text(
                "Click Here",
                style: TextStyle(color: Colors.white),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 24),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset('assets/images/them.svg'),
                Text('  Theme',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Colors.white)),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            padding: EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(width: 1, color: Colors.white),
            ),
            child: DropdownButton<String>(
              borderRadius: BorderRadius.circular(16),

              dropdownColor: Colors.black,
              isExpanded: true,
              value: ["Light", "Dark"].contains(dropdownTheme) ? dropdownTheme : "Light",
              underline: SizedBox(),
              items: [
                DropdownMenuItem(value: "Light", child: Text('light' , style: TextStyle(color: Colors.white),)),
                DropdownMenuItem(value: "Dark", child: Text('dark', style: TextStyle(color: Colors.white),)),
              ],
              onChanged: (String? value) {
                if (value != null) {
                  setState(() {
                    dropdownLanguage = value;
                    if (value == 'Light') {
                      //context.setLocale(Locale('en'));
                    } else {
                      //context.setLocale(Locale('ar'));
                    }
                  });
                }
              },
            ),
          ),
          SizedBox(height: 24),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset('assets/images/lang.svg'),
                Text('  Language',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Colors.white)),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            padding: EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(width: 1, color: Colors.white),
            ),
            child: DropdownButton<String>(
              borderRadius: BorderRadius.circular(16),

              dropdownColor: Colors.black,
              isExpanded: true,
              value: ["English", "Arabic"].contains(dropdownLanguage) ? dropdownLanguage : "English",
              underline: SizedBox(),
              items: [
                DropdownMenuItem(value: "English", child: Text('english' , style: TextStyle(color: Colors.white),)),
                DropdownMenuItem(value: "Arabic", child: Text('arabic', style: TextStyle(color: Colors.white),)),
              ],
              onChanged: (String? value) {
                if (value != null) {
                  setState(() {
                    dropdownLanguage = value;
                    if (value == 'English') {
                      //context.setLocale(Locale('en'));
                    } else {
                      //context.setLocale(Locale('ar'));
                    }
                  });
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
