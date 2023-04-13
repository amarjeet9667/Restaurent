// import 'package:flutter/material.dart';
// import 'package:restaurent_test1/app/util/colors.dart';

// class LoginHome extends StatefulWidget {
//   const LoginHome({super.key});

//   @override
//   State<LoginHome> createState() => _LoginHomeState();
// }

// class _LoginHomeState extends State<LoginHome> {
//   bool hasFocus = false;
//   late final FocusNode focusNode;

//   @override
//   void initState() {
//     super.initState();
//     focusNode = FocusNode();
//     focusNode.addListener(() {
//       setState(() {
//         hasFocus = focusNode.hasFocus;
//       });
//     });
//   }

//   @override
//   void dispose() {
//     focusNode.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 30),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               "Login",
//               style: TextStyle(
//                 color: black,
//                 fontSize: 40,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const Text(
//               "Please sign in to continue.",
//               style: TextStyle(
//                 color: grey,
//                 fontSize: 18,
//                 fontWeight: FontWeight.w400,
//               ),
//             ),
//             const SizedBox(height: 30),
//             AnimatedContainer(
//               duration: const Duration(milliseconds: 300),
//               height: hasFocus ? 50 : 50,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10),
//                 color: hasFocus ? Colors.white : Colors.transparent,
//                 boxShadow: hasFocus
//                     ? [
//                         BoxShadow(
//                           color: Colors.grey.withOpacity(0.5),
//                           spreadRadius: 2,
//                           blurRadius: 5,
//                           offset: const Offset(0, 3),
//                         ),
//                       ]
//                     : [],
//               ),
//               child: TextField(
//                 focusNode: focusNode,
//                 decoration: const InputDecoration(
//                   hintText: 'Email',
//                   border: InputBorder.none,
//                   contentPadding: EdgeInsets.all(16),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }




// Container(
//         padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 20),
//         decoration: const BoxDecoration(
//           color: white,
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Column(
//               children: [
//                 const Text(
//                   "Welcome Sir",
//                   style: TextStyle(
//                     color: Colors.green,
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 Text(
//                   '${String.fromCharCode(0x1F60B)} FUN FOOD',
//                   style: const TextStyle(
//                     color: Colors.green,
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 30),
//             Image.asset(
//               "assets/login.png",
//               fit: BoxFit.cover,
//             ),
//             const SizedBox(height: 30),
//             Column(
//               children: [
//                 Buttons(
//                     buttonText: "LOG IN",
//                     onPressed: () {
//                       Navigator.of(context).push(
//                         MaterialPageRoute(
//                           builder: (contex) => const LoginView(),
//                         ),
//                       );
//                     }),
//                 const SizedBox(height: 50),
//                 Buttons(
//                     buttonText: "SIGN UP",
//                     onPressed: () {
//                       Navigator.of(context).push(MaterialPageRoute(
//                           builder: (context) => const SignUpView()));
//                     }),
//               ],
//             )
//           ],
//         ),
//       ),
    