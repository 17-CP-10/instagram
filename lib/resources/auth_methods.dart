import 'dart:typed_data';
import 'package:instagramclone/models/user.dart' as model;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as developer;
import 'package:instagramclone/resources/storage_methods.dart';
class AuthMethods {
  final FirebaseAuth _auth=FirebaseAuth.instance;
  final FirebaseFirestore _firestore=FirebaseFirestore.instance;
  // get user details
  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;
    developer.log("UId :${currentUser.uid.toString()}");
    DocumentSnapshot documentSnapshot = await _firestore.collection('users').doc(currentUser.uid).get();
    developer.log("UId :${model.User.fromSnap(documentSnapshot).toString()}");
    return model.User.fromSnap(documentSnapshot);
  }
//signUp User
Future<String>signUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List file,
})async{
 String res="Some Error occurred";
 try {
  if(email.isNotEmpty||password.isNotEmpty||username.isNotEmpty||bio.isNotEmpty||file!=null){
   UserCredential credential=await _auth.createUserWithEmailAndPassword(email: email, password: password);
  String photoUrl= await StorageMethods().uploadImageToStorage("profilePics", file, false);
   model.User _user = model.User(
     username: username,
     uid: credential.user!.uid,
     photoUrl: photoUrl,
     email: email,
     bio: bio,
     followers: [],
     following: [],
   );

   await _firestore.collection("users").doc(credential.user?.uid).set(_user.toJson());
  res="success";
  }
 } on FirebaseAuthException catch(err){
   if(err.code=='invalid-email'){
   res="Email is badly formatted";
   }
   else if(err.code=='weak-password'){
     res="Password should be at least 6 characters";
   }
 }
 catch(err) {
 res=err.toString();
 }
 return res;
}
  // logging in user
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Some error Occurred";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        // logging in user with email and password
        await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        res = "success";
      } else {
        res = "Please enter all the fields";
      }
    } catch (err) {
      return err.toString();
    }
    return res;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}