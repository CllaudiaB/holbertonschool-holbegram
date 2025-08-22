import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
	String caption;
  String uid;
  String username;
  List likes;
  String postId;
  DateTime datePublished;
  String postUrl;
  String profImage;
  String searchKey;

	Post({
    required this.caption,
    required this.uid,
    required this.username,
    required this.likes,
    required this.postId,
    required this.datePublished,
    required this.postUrl,
    required this.profImage,
    required this.searchKey,
  });

  static Post fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data();
    if (snapshot == null) {
      throw Exception('Document does not exist');
    }
    var postData = snapshot as Map<String, dynamic>;
    
   DateTime publishedDate;
    if (postData['datePublished'] is Timestamp) {
      publishedDate = postData['datePublished'].toDate();
    } else {
      publishedDate = DateTime.now();
    }

    return Post(
      uid: postData['uid'],
      caption: postData['caption'],
      username: postData['username'],
      likes: postData['likes'],
      postId: postData['postId'],
      datePublished: publishedDate,
      postUrl: postData['postUrl'],
      profImage: postData['profImage'],
      searchKey: postData['searchKey'],
    );
  }

  toJson() {
    return {
    'uid': uid,
    'caption': caption,
    'username': username,
    'likes': likes,
    'postId': postId,
    'datePublished': Timestamp.fromDate(datePublished),
    'postUrl': postUrl,
    'profImage': profImage,
    'searchKey': searchKey,
    };
  }
}