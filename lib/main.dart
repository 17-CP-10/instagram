import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagramclone/providers/user_provider.dart';
import 'package:instagramclone/responsive/mobile_screen_layout.dart';
import 'package:instagramclone/responsive/responsive_layout.dart';
import 'package:instagramclone/responsive/web_screen_layout.dart';
import 'package:instagramclone/screens/login_screen.dart';
import 'package:instagramclone/screens/signup_screen.dart';
import 'package:instagramclone/utils/colors.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if(kIsWeb)
    {
   await Firebase.initializeApp(
     options:const FirebaseOptions(
         apiKey: "AIzaSyA7ktqVZURBA4Q--tZwcYC5Jt_yv5rXpTo",
         authDomain: "instagram-clone-f2130.firebaseapp.com",
         projectId: "instagram-clone-f2130",
         storageBucket: "instagram-clone-f2130.appspot.com",
         messagingSenderId: "29109477136",
         appId: "1:29109477136:web:17a63ee40bd32fd105cf95",
         measurementId: "G-PH359EYH0B"
     )
   );
    }
  else{
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context , child) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => UserProvider(),),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Instagram Clone',
            theme: ThemeData.dark().copyWith(
              scaffoldBackgroundColor: mobileBackgroundColor,
            ),
            home:child,
          ),
        );
      },
      // child: const ResponsiveLayout(mobileScreenLayout: MobileScreenLayout(),webScreenLayout: WebScreenLayout(),),
      child:StreamBuilder(
             stream: FirebaseAuth.instance.authStateChanges(),
                  builder: (context, snapshot) {
               if (snapshot.connectionState == ConnectionState.active) {
                    // Checking if the snapshot has any data or not
                      if (snapshot.hasData) {
                                  // if snapshot has data which means user is logged in then we check the width of screen and accordingly display the screen layout
                              return const ResponsiveLayout(
                                  mobileScreenLayout: MobileScreenLayout(),
                                     webScreenLayout: WebScreenLayout(),
                                                         );
                                               } else if (snapshot.hasError) {
                                                     return Center(
                                                      child: Text('${snapshot.error}'),
                    );
                    }
                       }

    // means connection to future hasnt been made yet
                  if (snapshot.connectionState == ConnectionState.waiting) {
                             return const Center(
                                  child: CircularProgressIndicator(),
                                   );
                                             }

       return const LooginScreen();
    },
    ),
    );
  }
}
