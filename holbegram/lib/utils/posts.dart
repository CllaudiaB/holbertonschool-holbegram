import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../screens/auth/login_screen.dart';
import '../screens/pages/methods/post_storage.dart';
// import 'package:provider/provider.dart';


class Posts extends StatefulWidget {
  Posts({super.key});
  final PostStorage postStorage = PostStorage();
  
  @override
  PostsState createState() => PostsState();
}

class PostsState extends State<Posts> {
  final User? user = FirebaseAuth.instance.currentUser;
  bool isFavorite = false;
  List saved = [];

  @override
    void initState() {
      super.initState();
      if (user != null) { 
        getSavedData();
      }
    }

  void getSavedData() async {
    String userId = user!.uid;
    var userDoc = await FirebaseFirestore.instance.collection('users').doc(userId).get();
    List<String> savedList = List<String>.from(userDoc.data()?['saved'] ?? []);
    setState(() {
      saved = savedList;
    });
  }  

  void _toggleFavorite(String postUrl) async {
    if (user == null) {
      if (!mounted) return;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen(
          emailController: TextEditingController(),
          passwordController: TextEditingController(),
        )),
      );
    return;
    }
    
    setState(() {
      if (saved.contains(postUrl)) {
        saved.remove(postUrl);
      } else {
        saved.add(postUrl);
      }
    });
    await FirebaseFirestore.instance.collection('users').doc(user!.uid).update({'saved': saved});
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('posts').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var docData = snapshot.data!.docs[index].data();
              bool isPostSaved = saved.contains(docData['postUrl']); 
          return SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.all(8),
              height: 540,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Column(
                children: [
                  Container(
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(docData['profImage']),
                              ),
                            ),
                          ),
                        ),
                        Text(docData['username']),
                        const Spacer(),
                        IconButton(
                          icon: const Icon(Icons.more_horiz),
                          onPressed: () async {
                            try {
                              await widget.postStorage.deletePost(docData['postId']);
                              if (!context.mounted) return; 
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Post Deleted'))
                                );
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('delete post Failed'))
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    child: Text(docData['caption']),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: 350,
                    height: 350,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(docData['postUrl']),
                      ),
                    ),
                  ),
                  Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.favorite_border),
              onPressed: () {
              },
            ),
            IconButton(
              icon: const Icon(Icons.messenger_outline),
              onPressed: () {
              },
            ),
            IconButton(
              icon: const Icon(Icons.send),
              onPressed: () {
              },
            ),
            const Spacer(),
            IconButton(
              icon: Icon(isPostSaved ? Icons.bookmark : Icons.bookmark_border),
              onPressed: () {
                _toggleFavorite(docData['postUrl']);
              },
            ),
          ],
        ),
                ],
              ),
            ),
          );
        },
      );
        } else {
            return const CircularProgressIndicator();
        }
      }
    );
  }
}