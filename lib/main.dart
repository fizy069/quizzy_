// ignore_for_file: library_private_types_in_public_api

import 'package:cp_quiz/login.dart';
import 'package:cp_quiz/splashScreen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:firebase_core/firebase_core.dart';

import 'home.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const QuizApp());
}

class QuizApp extends StatelessWidget {
  const QuizApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'COMPUTER PROGRAMMING QUIZ',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.redAccent, // Set the accent color
        scaffoldBackgroundColor:
        Colors.grey[900], // Set the background color of the app
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red, // Set the button color
            textStyle:
            const TextStyle(fontSize: 24), // Set the button text style
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32.0),
            ),
          ),
        ),
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.red),
      ),
      initialRoute: '/login',
      routes: {

        '/': (context) => const SplashScreen(),
        '/home': (context) => const HomePage(),
        // '/name_contact': (context) => const NameContactScreen(),
        '/login' : (context) => LoginPage(),
      },
    );
  }
}

// class NameContactScreen extends StatefulWidget {
//   const NameContactScreen({Key? key}) : super(key: key);
//
//   @override
//   _NameContactScreenState createState() => _NameContactScreenState();
// }
//
// class _NameContactScreenState extends State<NameContactScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _contactController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         backgroundColor: Colors.redAccent,
//         title: const Text('Please enter your details!'),
//       ),
//       body: SingleChildScrollView(
//         child: Center(
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Lottie.asset(
//                     'assets/animations/name_contact_animation.json',
//                     height: 200,
//                     width: 200,
//                   ),
//                   TextFormField(
//                     controller: _nameController,
//                     decoration: const InputDecoration(
//                       labelText: 'Enter your name',
//                       labelStyle: TextStyle(fontSize: 24),
//                     ),
//                     style: const TextStyle(
//                         fontSize: 24), // Set the input text style
//                     validator: (value) {
//                       if (value!.isEmpty) {
//                         return 'Please enter your name';
//                       }
//                       return null;
//                     },
//                   ),
//                   const SizedBox(height: 24.0),
//                   TextFormField(
//                     controller: _contactController,
//                     decoration: const InputDecoration(
//                       labelText: 'Enter Your Contact Details',
//                       labelStyle: TextStyle(fontSize: 24),
//                     ),
//                     style: const TextStyle(
//                         fontSize: 24), // Set the input text style
//                     validator: (value) {
//                       if (value!.isEmpty) {
//                         return 'Please enter your contact details';
//                       }
//                       return null;
//                     },
//                   ),
//                   const SizedBox(height: 24.0),
//                   ElevatedButton(
//                     onPressed: () {
//                       if (_formKey.currentState!.validate()) {
//                         // Form is valid, navigate to the home screen
//                         Navigator.pushReplacementNamed(context, '/home');
//                       }
//                     },
//                     child: const Text(
//                       'Enter the quiz',
//                       style: TextStyle(fontSize: 24),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

