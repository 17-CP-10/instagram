import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:video_player/video_player.dart';

import '../utils/colors.dart';
import '../utils/globle_variables.dart';
import '../widgets/post_card.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor:
      width > webScreenSize ? webBackgroundColor : mobileBackgroundColor,
      appBar: width > webScreenSize
          ? null
          : AppBar(
        backgroundColor: mobileBackgroundColor,
        centerTitle: false,
           title: SvgPicture.asset(
          'assets/ic_instagram.svg',
          color: primaryColor,
          height: 32,
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.messenger_outline,
              color: primaryColor,
            ),
            onPressed: () {

            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              height: 100,
              color: Colors.white,
              margin: EdgeInsets.symmetric(
                horizontal: width > webScreenSize ? width * 0.3 : 0,
                vertical: width > webScreenSize ? 15 : 0,
              ),
               child: ListView.separated(
                   scrollDirection: Axis.horizontal,
                   itemBuilder:(context,int index){
                  return CircleAvatar(
                    radius: 40.r,
                    backgroundImage: const NetworkImage(
                      "https://images.unsplash.com/photo-1671736505318-eb19f2bb2304?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80",
                    ),
                  );
               }, separatorBuilder:(context,int index){
                 return SizedBox(width: 5.w,);
               }, itemCount:20),
            ),
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance.collection('posts').snapshots(),
                builder: (context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView.separated(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (ctx, index) => Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: width > webScreenSize ? width * 0.3 : 0,
                        vertical: width > webScreenSize ? 15 : 0,
                      ),
                      child: PostCard(
                        snap: snapshot.data!.docs[index].data(),
                        controller: VideoPlayerController.network(
                          'https://player.vimeo.com/external/373983931.sd.mp4?s=6a705db9bd37ef34484e08e74e2cd2a9347c8f51&profile_id=164&oauth2_token_id=57447761',
                        ),
                      ),
                    ), separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(height: 8.h,);
                  },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}