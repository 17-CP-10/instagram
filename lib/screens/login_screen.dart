import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instagramclone/screens/signup_screen.dart';
import 'package:instagramclone/utils/colors.dart';

import '../resources/auth_methods.dart';
import '../responsive/mobile_screen_layout.dart';
import '../responsive/responsive_layout.dart';
import '../responsive/web_screen_layout.dart';
import '../utils/globle_variables.dart';
import '../utils/utils.dart';
import '../widgets/text_field_input.dart';
class LooginScreen extends StatefulWidget {
  const LooginScreen({Key? key}) : super(key: key);

  @override
  State<LooginScreen> createState() => _LooginScreenState();
}

class _LooginScreenState extends State<LooginScreen> {
  final TextEditingController emailAddressController=TextEditingController();
  final TextEditingController passwordController=TextEditingController();
  bool _isLoading = false;
  @override
  void dispose(){
    emailAddressController.dispose();
    passwordController.dispose();
    super.dispose();
  }
  void loginUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().loginUser(
        email: emailAddressController.text, password: passwordController.text);
    if (res == 'success') {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const ResponsiveLayout(
              mobileScreenLayout: MobileScreenLayout(),
              webScreenLayout: WebScreenLayout(),
            ),
          ),
              (route) => false);

      setState(() {
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
      showSnackBar(context, res);
    }
  }
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            width: 500.w,
            decoration: BoxDecoration(
              border: width>webScreenSize ? Border.all(color: Colors.white):Border.all(color:Colors.black)
            ),
            padding: EdgeInsets.symmetric(horizontal: 18.w),
            margin: EdgeInsets.symmetric(
              horizontal: width > webScreenSize ? width * 0.3 : 0,
              vertical: width > webScreenSize ? 15 : 0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(flex: 2,child: Container(),),
                SvgPicture.asset("assets/ic_instagram.svg",
                  color:primaryColor,
                  height: 64.h,
                ),
                SizedBox(height: 64.h,),
                TextFieldInput(
                  hintText: "Enter your email",
                  textInputType: TextInputType.emailAddress,
                  textEditingController: emailAddressController,
                ),
                SizedBox(height: 24.h,),
                TextFieldInput(
                  hintText: "Enter your password",
                  textInputType: TextInputType.text,
                  textEditingController: passwordController,
                  isPass: true,
                ),
                SizedBox(height: 24.h,),
                InkWell(
                  onTap:loginUser,
                  child: Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    decoration: ShapeDecoration(
                        color: blueColor,
                       shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(4.r),
                        )
                      )
                    ),
                    child:!_isLoading
                        ? const Text(
                      'Log in',
                    )
                        : const CircularProgressIndicator(
                      color: primaryColor,
                    ),
                  ),
                ),
                SizedBox(height: 12.h),
                Flexible(flex: 2,child: Container(),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      child: const Text("Don't have an account? "),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const SignUpScreen(),
                        ),
                      ),
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 8.h),
                        child: const Text("Sign Up",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
