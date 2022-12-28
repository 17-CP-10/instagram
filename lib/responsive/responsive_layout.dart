import 'package:flutter/material.dart';
import 'package:instagramclone/providers/user_provider.dart';
import 'package:instagramclone/utils/globle_variables.dart';
import 'package:provider/provider.dart';
class ResponsiveLayout extends StatefulWidget {
  final Widget webScreenLayout;
  final Widget mobileScreenLayout;
  const ResponsiveLayout({Key? key,required this.mobileScreenLayout,required this.webScreenLayout}) : super(key: key);

  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {
  @override
  void initState(){
    super.initState();
    addData();
  }
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context,constraints){
    if(constraints.maxWidth>webScreenSize)
      {
        return widget.webScreenLayout;
        //WebScreens
      }
    else
    {
    //Mobile Screens
      return widget.mobileScreenLayout;
    }
    });
  }

  Future<void> addData() async {
    UserProvider userProvider=Provider.of(context,listen: false);
    await userProvider.refreshUser();

  }
}
