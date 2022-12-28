import 'dart:typed_data';
import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagramclone/resources/auth_methods.dart';
import 'package:instagramclone/screens/login_screen.dart';
import 'package:instagramclone/utils/colors.dart';
import 'package:instagramclone/utils/utils.dart';

import '../responsive/mobile_screen_layout.dart';
import '../responsive/responsive_layout.dart';
import '../responsive/web_screen_layout.dart';
import '../utils/globle_variables.dart';
import '../widgets/text_field_input.dart';
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController emailAddressController=TextEditingController();
  final TextEditingController passwordController=TextEditingController();
  final TextEditingController bioController=TextEditingController();
  final TextEditingController userNameController=TextEditingController();
  Uint8List? image;
  bool isLoading=false;
  @override
  void dispose(){
    emailAddressController.dispose();
    passwordController.dispose();
    bioController.dispose();
    userNameController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
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
              Stack(
                children: [
               image!=null ? CircleAvatar(
              radius: 64.r,
                backgroundImage:MemoryImage(image!),
              ):CircleAvatar(
                  radius: 64.r,
                  backgroundImage: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRjbWmOsZ7qxLjEOZYNDLEemNAD97_ppqHWcHL3GTy6Og&s"),
                ),
                  Positioned(
                      bottom: -10,
                      left: 90,
                      child: IconButton(
                      onPressed: (){
                             selectImage();
                            },icon: const Icon(Icons.add_a_photo),))
                ],
              ),
              SizedBox(height: 24.h,),
              TextFieldInput(
                hintText: "Enter your username",
                textInputType: TextInputType.text,
                textEditingController: userNameController,
              ),
              SizedBox(height: 24.h,),
              TextFieldInput(
                hintText: "Enter your bio",
                textInputType: TextInputType.text,
                textEditingController:bioController,
              ),
              SizedBox(height: 24.h,),
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
                onTap:signUpUser,
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
                  child: isLoading ? const Center(child: CircularProgressIndicator(color: Colors.white,),): const Text("SignUp"),
                ),
              ),
              SizedBox(height: 12.h),
              Flexible(flex: 2,child: Container(),),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                    child: const Text("You have already an account? "),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const LooginScreen(),
                      ),
                    ),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      child: const Text("Login",
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
    );
  }
  Future<void> selectImage() async {
   Uint8List im=await pickImage(ImageSource.gallery);
   setState(() {
     image=im;
   });
  }

  Future<void> signUpUser() async {
    setState(() {
      isLoading=true;
    });
    String res= await AuthMethods().signUpUser(
      email:emailAddressController.text,
      password: passwordController.text,
      username: userNameController.text,
      bio: bioController.text,
      file: image!,
    );
    if(res!='success')
    {
      setState(() {
        isLoading=false;
      });
     showSnackBar(context, res);
    }
    else
    {
      setState(() {
        isLoading = false;
      });
      // navigate to the home screen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
            mobileScreenLayout: MobileScreenLayout(),
            webScreenLayout: WebScreenLayout(),
          ),
        ),
      );
    }
  }
}
