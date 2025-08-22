import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/widgets.dart';
// import './widgets/text_field.dart';
import './screens/auth/login_screen.dart';
// import './screens/pages/feed.dart';
// import 'screens/auth/sigup_screen.dart';
// import 'screens/auth/upload_image_screen.dart';
import 'screens/home.dart';
// import 'providers/user_provider.dart';
// import 'screens/pages/profile_screen.dart';
// import 'screens/pages/add_image.dart';
// import 'package:provider/provider.dart';


Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

// Future main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(
//     MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (context) => UserProvider()),
//       ],
//       child: const MyApp(),
//     ),
//   );
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const AddPicture(
//         email: 'test@mail.com',
//         password: 'test123',
//         username: 'taro',
//     );
//   }
// }
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: SignUp(
//         emailController: TextEditingController(),
//         usernameController: TextEditingController(),
//         passwordController: TextEditingController(),
//         passwordConfirmController: TextEditingController(),
//       ), 
//     );
//   }
// }

//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const Profile(),
//     );
//   }
// }



  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? currentUser = auth.currentUser;

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: currentUser != null ? const Home() : LoginScreen(
        emailController: TextEditingController(),
        passwordController:TextEditingController(),
      ),
    );
  }
}
  
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
        
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: Scaffold(
//         appBar: AppBar(title: const Text('TextField Example')),
//         body: Center(
//           child: TextFieldInput(
//             controller: TextEditingController(),
//             isPassword: true,
//             hintText: 'Password',
//             keyboardType: TextInputType.emailAddress,
//             suffixIcon: const Icon(Icons.visibility_off),
//           ),
//         ),
//       ),
//     );
//   }
// }