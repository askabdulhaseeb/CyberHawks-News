import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cybehawks/controller/post_controller.dart';
import 'package:cybehawks/models/news.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CommentsScreen extends StatelessWidget {
  final News news;
  CommentsScreen({required this.news});
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _commentController = TextEditingController();
  final _currentUser = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            (news.p_ispoll == "yes")
                ? SizedBox()
                : Hero(
                    tag: news.title!,
                    child: Image.network(
                      news.image!,
                      height: 250,
                      fit: BoxFit.cover,
                    ),
                  ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  (news.p_ispoll == "yes")
                      ? Text(
                          news.p_question!,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        )
                      : Text(
                          news.title!,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                  const SizedBox(
                    height: 16,
                  ),
                  Form(
                    key: _formKey,
                    child: TextFormField(
                      controller: _commentController,
                      validator: (val) {
                        if (val!.trim().isEmpty) {
                          return 'Enter Comment to post';
                        }
                      },
                      decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        hintText: 'Comment',
                        suffixIcon: IconButton(
                          icon: Icon(
                            Icons.send,
                            color: Theme.of(context).primaryColor,
                          ),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              await Provider.of<PostController>(context,
                                      listen: false)
                                  .postComment(
                                news.id!,
                                Comment(
                                  username: _currentUser!.displayName,
                                  date: DateTime.now(),
                                  email: _currentUser!.email,
                                  text: _commentController.text,
                                ),
                              );
                              FocusScope.of(context).unfocus();
                              _commentController.clear();
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  news.comment!.length > 0
                      ? Text(
                          'All Comments',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      : SizedBox(),
                  StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('news')
                        .doc(news.id)
                        .snapshots(),
                    builder: (context, AsyncSnapshot snaphot) {
                      if (snaphot.hasData) {
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: snaphot.data['comment'].length,
                          itemBuilder: (context, idx) {
                            Comment _comment = Comment.fromJson(
                              snaphot.data['comment'][idx],
                            );
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 4.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        _comment.username ?? '',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        DateFormat('EEE, MMM d, ' 'yy')
                                            .format(_comment.date!),
                                        style: TextStyle(
                                          color: Color(0xffB7B7BA),
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    _comment.text!,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      } else
                        return CircularProgressIndicator();
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
