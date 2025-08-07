class User {
  String uid;
  String email;
  String username;
  String bio;
  String photoUrl;
  List<dynamic> followers;
  List<dynamic> following;
  List<dynamic> posts;
  List<dynamic> saved;
  String searchKey;

  User({
    required this.uid,
    required this.email,
    required this.username,
    required this.bio,
    required this.photoUrl,
    required this.followers,
    required this.following,
    required this.posts,
    required this.saved,
    required this.searchKey,
  });

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return User(
      uid: snapshot['uid'],
      email: snapshot['email'],
      username: snapshot['username'],
      bio: snapshot['bio'],
      photoUrl: snapshot['photoUrl'],
      followers: snapshot['followers'],
      following: snapshot['following'],
      posts: snapshot['posts'],
      saved: snapshot['saved'],
      searchKey: snapshot['searchKey'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "uid": uid,
      "email": email,
      "username": username,
      "bio": bio,
      "photoUrl": photoUrl,
      "followers": followers,
      "following": following,
      "posts": posts,
      "saved": saved,
      "searchKey": searchKey,
    };
  }
}
