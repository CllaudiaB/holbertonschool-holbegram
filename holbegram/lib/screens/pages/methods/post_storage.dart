import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:typed_data';
import '../../../screens/auth/methods/user_storage.dart';


class PostStorage {

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final StorageMethods _storageMethods = StorageMethods(); 

  Future<String> uploadPost(String caption,String uid,String username,String profImage,Uint8List image) async {
    if (caption.isEmpty || uid.isEmpty || username.isEmpty || profImage.isEmpty || image.isEmpty) {
      return 'something is missing';
    }
    try {
      String imageUrl = await _storageMethods.uploadImageToStorage(true, 'post_images', image); 
      DocumentReference postRef = await _firestore.collection('posts').add({
        'caption': caption,
        'uid': uid,
        'username': username,
        'likes': 0, 
        'postId': '',
        'datePublished': FieldValue.serverTimestamp(), 
        'postUrl': imageUrl, 
        'profImage': profImage,
        'searchKey': username.substring(0, 1).toUpperCase(), 
      });

      await postRef.update({
            'postId': postRef.id,
        });

      await _firestore.collection('users').doc(uid).update({
          'posts': FieldValue.arrayUnion([postRef.id])
      });
      return 'Ok';
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> deletePost(String postId) async {
    try {
       await _firestore.collection('posts').doc(postId).delete();
    } catch (e) {
      throw Exception();
    }
  }
}
