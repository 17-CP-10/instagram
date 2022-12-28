import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
class StorageMethods{
  final FirebaseStorage firebaseStorage=FirebaseStorage.instance;
  final FirebaseAuth auth=FirebaseAuth.instance;
  Future<String> uploadImageToStorage(String childName,Uint8List file,bool isPost) async {
   Reference ref= firebaseStorage.ref().child(childName).child(auth.currentUser!.uid);
   UploadTask uploadTask=ref.putData(file);
   TaskSnapshot snap=await uploadTask;
   String url=await snap.ref.getDownloadURL();
   return url;
  }

}