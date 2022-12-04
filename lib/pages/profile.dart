import 'package:cybehawks/components/primary_button.dart';
import 'package:cybehawks/pages/login.dart';
import 'package:cybehawks/pages/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final User? _user = FirebaseAuth.instance.currentUser;
  bool notification = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: (_user != null)
            ? CustomScrollView(
                slivers: [
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Container(
                      color: Theme.of(context).primaryColor,
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          Column(
                            children: [
                              Center(
                                child: Container(
                                  height: 150,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: (_user?.photoURL != null)
                                        ? DecorationImage(
                                            fit: BoxFit.contain,
                                            image:
                                                NetworkImage(_user!.photoURL!),
                                          )
                                        : const DecorationImage(
                                            fit: BoxFit.contain,
                                            image: AssetImage(
                                              'assets/images/default-image.jpg',
                                            ),
                                          ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                _user?.displayName ?? 'no name found',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w900, fontSize: 24),
                              ),
                              _user?.email != null
                                  ? Text(
                                      _user?.email ?? 'No Email Found',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14),
                                    )
                                  : const SizedBox(),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Expanded(
                            child: Container(
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(32),
                                  topRight: Radius.circular(32),
                                ),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InfoTile(
                                    title: 'Name',
                                    value:
                                        _user?.displayName ?? 'No Name Found',
                                  ),
                                  _user?.email != null
                                      ? InfoTile(
                                          title: 'Email',
                                          value:
                                              _user?.email ?? 'No Email Found')
                                      : const SizedBox(),
                                  (_user?.phoneNumber != null)
                                      ? InfoTile(
                                          title: 'Phone No',
                                          value:
                                              _user?.phoneNumber?.toString() ??
                                                  'No Phone Number Found',
                                        )
                                      : const SizedBox(),
                                  Container(
                                    margin:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const Text(
                                          'Notification',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                        const Spacer(),
                                        Switch(
                                          value: notification,
                                          onChanged: (val) {
                                            setState(() {
                                              notification = val;
                                            });
                                          },
                                          activeColor:
                                              Theme.of(context).primaryColor,
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              )
            : (_user?.displayName == null || _user?.email == null)
                ? TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => RegisterScreen(),
                        ),
                      );
                    },
                    child: const Text('Add Your Details'),
                  )
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Login Required',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        PrimaryButton(
                          text: 'Login',
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => const LoginScreen(),
                              ),
                            );
                          },
                        )
                      ],
                    ),
                  ),
      ),
    );
  }
}

class InfoTile extends StatelessWidget {
  final String title;
  final String value;

  const InfoTile({Key? key, required this.title, required this.value})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              color: Color(0xffDCDCDC),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
