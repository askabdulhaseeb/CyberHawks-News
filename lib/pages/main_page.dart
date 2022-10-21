// import 'package:cybehawks/controller/auth.dart';
// import 'package:cybehawks/pages/add_poll_screen.dart';
// import 'package:cybehawks/pages/add_post_screen.dart';
// import 'package:cybehawks/pages/home.dart';
// import 'package:cybehawks/pages/profile.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:provider/provider.dart';

// import '../controller/post_controller.dart';

// class MainPage extends StatefulWidget {
//   const MainPage({Key? key}) : super(key: key);

//   @override
//   State<MainPage> createState() => _MainPageState();
// }

// class _MainPageState extends State<MainPage> {
//   @override
//   void initState() {
//     Provider.of<PostController>(context, listen: false).checkdatainiFirestore();

//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) => DefaultTabController(
//         length: 2,
//         child: Scaffold(
//           floatingActionButton: (FirebaseAuth.instance.currentUser?.email ==
//                       'rocketnuwan30@gmail.com' ||
//                   FirebaseAuth.instance.currentUser?.email ==
//                       "cybehawksa@gmail.com")
//               ? FloatingActionButton(
//                   child: const Icon(Icons.add),
//                   onPressed: () {
//                     // Navigator.push(context,
//                     //     MaterialPageRoute(builder: (_) => const AddPostScreen()));
//                     showDialog(
//                       context: context,
//                       builder: (context) => AlertDialog(
//                         title: Text(
//                           "Create New",
//                           textAlign: TextAlign.center,
//                         ),
//                         content: SizedBox(
//                           height: MediaQuery.of(context).size.height / 7,
//                           child: Column(
//                             children: [
//                               ElevatedButton(
//                                 onPressed: () {
//                                   Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                           builder: (_) =>
//                                               const AddPostScreen()));
//                                 },
//                                 child: Text("News"),
//                                 style: ElevatedButton.styleFrom(
//                                   fixedSize: const Size(double.maxFinite, 28),
//                                   shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(50)),
//                                 ),
//                               ),
//                               ElevatedButton(
//                                 onPressed: () {
//                                   Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                           builder: (_) =>
//                                               const AddPollsScreen()));
//                                 },
//                                 child: Text("Polls"),
//                                 style: ElevatedButton.styleFrom(
//                                   fixedSize: const Size(double.maxFinite, 28),
//                                   shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(50)),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         actions: [
//                           TextButton(
//                             onPressed: () {
//                               Navigator.pop(context);
//                               return;
//                             },
//                             child: Text("Cencle"),
//                           ),
//                         ],
//                       ),
//                     );
//                   })
//               : const SizedBox(),
//           appBar: AppBar(
//             //  backgroundColor: Color.fromARGB(255, 3, 19, 18),
//             leading: Padding(
//               padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 10.0),
//               child: Image.asset('assets/images/logo-transparent.png'),
//             ),
//             title: const Text('CybeHawks News'),
//             centerTitle: true,
//             actions: [
//               if (FirebaseAuth.instance.currentUser != null)
//                 PopupMenuButton(
//                   onSelected: (value) async {
//                     switch (value) {
//                       case 0:
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (_) => const Profile(),
//                           ),
//                         );
//                         break;
//                       case 1:
//                         if (Provider.of<AuthController>(context, listen: false)
//                                 .user ==
//                             null) {
//                           await Provider.of<AuthController>(context,
//                                   listen: false)
//                               .logoutPhoneUser();

//                           Navigator.pushReplacement(
//                             context,
//                             MaterialPageRoute(
//                               builder: (_) => HomeScreen(),
//                             ),
//                           );
//                         } else {
//                           await Provider.of<AuthController>(context,
//                                   listen: false)
//                               .logoutGoogleAcc();
//                         }

//                         break;
//                       default:
//                     }
//                   },
//                   itemBuilder: (context) =>
//                       FirebaseAuth.instance.currentUser != null
//                           ? [
//                               const PopupMenuItem(
//                                 value: 0,
//                                 child: Text('Profile'),
//                               ),
//                               const PopupMenuItem(
//                                 child: Text('Log out'),
//                                 value: 1,
//                               ),
//                             ]
//                           : [],
//                 ),
//             ],
//             bottom: TabBar(
//               // padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//               tabs: [
//                 Tab(
//                   text: 'News',
//                 ),
//                 Tab(
//                   text: 'Polls',
//                 )
//               ],
//               indicator: ShapeDecoration(
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.all(
//                   Radius.circular(10),
//                 )),
//                 color: Color.fromARGB(255, 74, 189, 187),
//               ),
//             ),
//           ),
//           body: TabBarView(children: [
//             Center(
//               child: Text('Tab1'),
//             ),
//             Center(
//               child: Text('Tab1'),
//             )
//           ]),
//         ),
//       );
// }
