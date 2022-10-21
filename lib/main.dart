import 'package:cybehawks/controller/auth.dart';
import 'package:cybehawks/controller/post_controller.dart';
import 'package:cybehawks/pages/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth/auth_bloc.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Handling a background message ${message.messageId}');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  FlutterLocalNotificationsPlugin? fltNotification;

  @override
  void initState() {
    // TO
    // DO: implement initState
    super.initState();
    notitficationPermission();
    initMessaging();
    if (!kIsWeb) messaging.subscribeToTopic('all');
  }

  void notitficationPermission() async {
    await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }

  void initMessaging() async {
    var androiInit = const AndroidInitializationSettings('@mipmap/ic_launcher');

    var iosInit = const IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    var initSetting = InitializationSettings(android: androiInit, iOS: iosInit);

    fltNotification = FlutterLocalNotificationsPlugin();

    fltNotification!.initialize(initSetting);

    if (messaging != null) {
      print('vvvvvvv');
    }

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      showNotification(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((event) {});
  }

  void showNotification(RemoteMessage message) async {
    var androidDetails = AndroidNotificationDetails(
      '1',
      message.notification!.title ?? '',
      icon: '@mipmap/launcher_icon',
      color: const Color(0xFF0f90f3),
    );
    var iosDetails = const IOSNotificationDetails();
    var generalNotificationDetails =
        NotificationDetails(android: androidDetails, iOS: iosDetails);
    await fltNotification!.show(0, message.notification!.title ?? '',
        message.notification!.body ?? '', generalNotificationDetails,
        payload: 'Notification');
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthController()),
        ChangeNotifierProvider(create: (_) => PostController()),
      ],
      child: BlocProvider(
        create: (context) => AuthBloc(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          key: UniqueKey(),
          title: 'CyberHawks News',
          theme: ThemeData(
            primaryColor: const Color(0xff009A98),
            appBarTheme: const AppBarTheme(
              backgroundColor: Color(0xff009A98),
              elevation: 1.4,
            ),
          ),
          home: const SplashScreen(),
          //home: Profile(),
        ),
      ),
    );
  }
}
