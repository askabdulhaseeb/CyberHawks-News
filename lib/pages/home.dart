import 'package:cybehawks/auth/auth_bloc.dart';
import 'package:cybehawks/components/custom_form.dart';
import 'package:cybehawks/components/news_card.dart';
import 'package:cybehawks/controller/auth.dart';
import 'package:cybehawks/controller/post_controller.dart';
import 'package:cybehawks/models/news.dart';
import 'package:cybehawks/pages/login.dart';
import 'package:cybehawks/pages/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
  const HomeScreen({Key? key}) : super(key: key);
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
  }

  @override
  void didUpdateWidget(HomeScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    if (mounted) {
      FirebaseAuth.instance.userChanges().listen((User? user) {
        if (user == null) {
          print('User is currently signed out!');
          context.read<AuthBloc>().add(AuthChangeEvent(isLogin: false));
        } else {
          print('User is signed in!');
          context.read<AuthBloc>().add(AuthChangeEvent(isLogin: true));
        }
      });
    }
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, snapshot) {
            if (snapshot is AuthSuccess) {
              return Home();
            }

            if (snapshot is AuthFail) {
              return Anonymous();
            }

            if (snapshot is AuthLogin) {
              return LoginScreen();
            }
            return CircularProgressIndicator(
              color: Theme.of(context).primaryColor,
            );
          },
        ),
      ),
    );
  }
}

class Anonymous extends StatelessWidget {
  const Anonymous({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Home(
      key: ValueKey('Anonymous'),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    Provider.of<PostController>(context, listen: false).checkdatainiFirestore();

    super.initState();
  }

  @override
  Widget build(BuildContext context) => DefaultTabController(
      length: 2,
      child: Scaffold(
        floatingActionButton: (FirebaseAuth.instance.currentUser?.email ==
                    'cybehawksa@gmail.com' ||
                FirebaseAuth.instance.currentUser?.email ==
                    "cybehawks@gmail.com")
            ? FloatingActionButton(
                child: const Icon(Icons.add),
                onPressed: () {
                  ShowForm.showForm(context, null);
                })
            : const SizedBox(),
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 10.0),
            child: Image.asset('assets/images/logo-transparent.png'),
          ),
          title: const Text('CybeHawks News'),
          actions: [
            if (FirebaseAuth.instance.currentUser != null)
              PopupMenuButton(
                onSelected: (value) async {
                  switch (value) {
                    case 0:
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const Profile(),
                        ),
                      );
                      break;
                    case 1:
                      if (Provider.of<AuthController>(context, listen: false)
                              .user ==
                          null) {
                        await Provider.of<AuthController>(context,
                                listen: false)
                            .logoutPhoneUser();

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => HomeScreen(),
                          ),
                        );
                      } else {
                        await Provider.of<AuthController>(context,
                                listen: false)
                            .logoutGoogleAcc();
                      }

                      break;
                    default:
                  }
                },
                itemBuilder: (context) =>
                    FirebaseAuth.instance.currentUser != null
                        ? [
                            const PopupMenuItem(
                              value: 0,
                              child: Text('Profile'),
                            ),
                            const PopupMenuItem(
                              child: Text('Log out'),
                              value: 1,
                            ),
                          ]
                        : [],
              ),
          ],
          bottom: TabBar(
            // padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            tabs: [
              Tab(
                text: 'News',
              ),
              Tab(
                text: 'Polls',
              )
            ],
            indicator: ShapeDecoration(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                Radius.circular(10),
              )),
              color: Color.fromARGB(255, 74, 189, 187),
            ),
          ),
        ),
        body: TabBarView(children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: StreamBuilder(
              stream: Provider.of<PostController>(context, listen: false)
                  .getAllNewsFromFirebase(),
              builder: (context, AsyncSnapshot<List<News>> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return NewsCard(
                        news: snapshot.data![index],
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(
                        'Error fetching data: ' + snapshot.error.toString()),
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: StreamBuilder(
              stream: Provider.of<PostController>(context, listen: false)
                  .getAllPollFromFirebase(),
              builder: (context, AsyncSnapshot<List<News>> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return NewsCard(
                        news: snapshot.data![index],
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(
                        'Error fetching data: ' + snapshot.error.toString()),
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ]),
      ));
}
