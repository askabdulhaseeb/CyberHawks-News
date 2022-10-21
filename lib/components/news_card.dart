import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polls/flutter_polls.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:cybehawks/auth/auth_bloc.dart';
import 'package:cybehawks/controller/post_controller.dart';
import 'package:cybehawks/models/news.dart';
import 'package:cybehawks/pages/add_post_screen.dart';
import 'package:cybehawks/pages/comments_screen.dart';
import 'package:cybehawks/pages/dynamic/dynamic_textfield.dart';
import 'package:cybehawks/pages/home.dart';
import 'package:cybehawks/pages/login.dart';
import 'package:cybehawks/pages/news_detail.dart';

class NewsCard extends StatefulWidget {
  final News news;

  const NewsCard({Key? key, required this.news}) : super(key: key);

  @override
  State<NewsCard> createState() => _NewsCardState();
}

class _NewsCardState extends State<NewsCard> {
  Widget build(BuildContext context) {
    bool isVoted(bool b) {
      bool a = b;
      if (FirebaseAuth.instance.currentUser != null) {
        List<String>? answer1_votes = widget.news.answer1_votes;
        List<String>? answer2_votes = widget.news.answer2_votes;
        List<String>? answer3_votes = widget.news.answer3_votes;
        List<String>? answer4_votes = widget.news.answer4_votes;
        List<String>? answer5_votes = widget.news.answer5_votes;
        List<String>? answer6_votes = widget.news.answer6_votes;
        String uid = FirebaseAuth.instance.currentUser!.uid;

        if (answer1_votes!.contains(uid) ||
            answer2_votes!.contains(uid) ||
            answer3_votes!.contains(uid) ||
            answer4_votes!.contains(uid) ||
            answer5_votes!.contains(uid) ||
            answer6_votes!.contains(uid)) {
          a = true;
        } else {
          a = false;
        }
      }
      return a;
    }

    // // PollsModel model = PollsModel(id: "1", title: "Test", votes: "50");
    // PollsModel model2 = PollsModel(id: "2", title: "Test2", votes: "60");
    // List<PollsModel> listp = [model, model2];
    // News? newsPoll =
    //     Provider.of<PostController>(context, listen: false).toPostpoll;
    List polls1() => [
          {
            'id': 1,
            'question': widget.news.p_question,
            'end_date': widget.news.p_enddate,
            'options': [
              {
                'id': int.parse(widget.news.answer_ids![0].toString()),
                'title': widget.news.answer_texts![0].toString(),
                'votes':
                    int.parse(widget.news.answer1_votes!.length.toString()),
              },
              {
                'id': int.parse(widget.news.answer_ids![1].toString()),
                'title': widget.news.answer_texts![1].toString(),
                'votes':
                    int.parse(widget.news.answer2_votes!.length.toString()),
              },
            ],
          },
        ];
    List polls2() => [
          {
            'id': 1,
            'question': widget.news.p_question,
            'end_date': widget.news.p_enddate,
            'options': [
              {
                'id': int.parse(widget.news.answer_ids![0].toString()),
                'title': widget.news.answer_texts![0].toString(),
                'votes':
                    int.parse(widget.news.answer1_votes!.length.toString()),
              },
              {
                'id': int.parse(widget.news.answer_ids![1].toString()),
                'title': widget.news.answer_texts![1].toString(),
                'votes':
                    int.parse(widget.news.answer2_votes!.length.toString()),
              },
              {
                'id': int.parse(widget.news.answer_ids![2].toString()),
                'title': widget.news.answer_texts![2].toString(),
                'votes':
                    int.parse(widget.news.answer3_votes!.length.toString()),
              },
            ],
          },
        ];
    List polls3() => [
          {
            'id': 1,
            'question': widget.news.p_question,
            'end_date': widget.news.p_enddate,
            'options': [
              {
                'id': int.parse(widget.news.answer_ids![0].toString()),
                'title': widget.news.answer_texts![0].toString(),
                'votes':
                    int.parse(widget.news.answer1_votes!.length.toString()),
              },
              {
                'id': int.parse(widget.news.answer_ids![1].toString()),
                'title': widget.news.answer_texts![1].toString(),
                'votes':
                    int.parse(widget.news.answer2_votes!.length.toString()),
              },
              {
                'id': int.parse(widget.news.answer_ids![2].toString()),
                'title': widget.news.answer_texts![2].toString(),
                'votes':
                    int.parse(widget.news.answer3_votes!.length.toString()),
              },
              {
                'id': int.parse(widget.news.answer_ids![3].toString()),
                'title': widget.news.answer_texts![3].toString(),
                'votes':
                    int.parse(widget.news.answer4_votes!.length.toString()),
              },
            ],
          },
        ];
    List polls4() => [
          {
            'id': 1,
            'question': widget.news.p_question,
            'end_date': widget.news.p_enddate,
            'options': [
              {
                'id': int.parse(widget.news.answer_ids![0].toString()),
                'title': widget.news.answer_texts![0].toString(),
                'votes':
                    int.parse(widget.news.answer1_votes!.length.toString()),
              },
              {
                'id': int.parse(widget.news.answer_ids![1].toString()),
                'title': widget.news.answer_texts![1].toString(),
                'votes':
                    int.parse(widget.news.answer2_votes!.length.toString()),
              },
              {
                'id': int.parse(widget.news.answer_ids![2].toString()),
                'title': widget.news.answer_texts![2].toString(),
                'votes':
                    int.parse(widget.news.answer3_votes!.length.toString()),
              },
              {
                'id': int.parse(widget.news.answer_ids![3].toString()),
                'title': widget.news.answer_texts![3].toString(),
                'votes':
                    int.parse(widget.news.answer4_votes!.length.toString()),
              },
              {
                'id': int.parse(widget.news.answer_ids![4].toString()),
                'title': widget.news.answer_texts![4].toString(),
                'votes':
                    int.parse(widget.news.answer5_votes!.length.toString()),
              },
            ],
          },
        ];
    List polls5() => [
          {
            'id': 1,
            'question': widget.news.p_question,
            'end_date': widget.news.p_enddate,
            'options': [
              {
                'id': int.parse(widget.news.answer_ids![0].toString()),
                'title': widget.news.answer_texts![0].toString(),
                'votes':
                    int.parse(widget.news.answer1_votes!.length.toString()),
              },
              {
                'id': int.parse(widget.news.answer_ids![1].toString()),
                'title': widget.news.answer_texts![1].toString(),
                'votes':
                    int.parse(widget.news.answer2_votes!.length.toString()),
              },
              {
                'id': int.parse(widget.news.answer_ids![2].toString()),
                'title': widget.news.answer_texts![2].toString(),
                'votes':
                    int.parse(widget.news.answer3_votes!.length.toString()),
              },
              {
                'id': int.parse(widget.news.answer_ids![3].toString()),
                'title': widget.news.answer_texts![3].toString(),
                'votes':
                    int.parse(widget.news.answer4_votes!.length.toString()),
              },
              {
                'id': int.parse(widget.news.answer_ids![4].toString()),
                'title': widget.news.answer_texts![4].toString(),
                'votes':
                    int.parse(widget.news.answer5_votes!.length.toString()),
              },
              {
                'id': int.parse(widget.news.answer_ids![5].toString()),
                'title': widget.news.answer_texts![5].toString(),
                'votes':
                    int.parse(widget.news.answer6_votes!.length.toString()),
              },
            ],
          },
        ];

    List pols() => [
          {
            'id': 1,
            'question': widget.news.p_question,
            'end_date': widget.news.p_enddate,
            'options': [
              {
                'id': int.parse(widget.news.answer_ids![0].toString()),
                'title': widget.news.answer_texts![0].toString(),
                'votes':
                    int.parse(widget.news.answer1_votes!.length.toString()),
              },
              {
                'id': int.parse(widget.news.answer_ids![1].toString()),
                'title': widget.news.answer_texts![1].toString(),
                'votes':
                    int.parse(widget.news.answer2_votes!.length.toString()),
              },
              {
                'id': int.parse(widget.news.answer_ids![2].toString()),
                'title': widget.news.answer_texts![2].toString(),
                'votes':
                    int.parse(widget.news.answer3_votes!.length.toString()),
              },
              {
                'id': int.parse(widget.news.answer_ids![3].toString()),
                'title': widget.news.answer_texts![3].toString(),
                'votes':
                    int.parse(widget.news.answer4_votes!.length.toString()),
              },
            ],
          },
        ];
    bool pollended = true;
    //bool pollVoted = false;

    //Provider.of<PostController>(context,listen: false).
    double ss = double.parse(
        widget.news.answerSize); //MediaQuery.of(context).size.height / 3;
    if (ss == 2) {
      ss = 220;
    } else if (ss == 3) {
      ss = 270;
    } else if (ss == 4) {
      ss = 320;
    } else if (ss == 5) {
      ss = 370;
    } else if (ss == 6) {
      ss = 420;
    }

    return (widget.news.p_ispoll == "yes")
        // ? Container(
        //     height: 100,
        //     width: 100,
        //     color: Colors.red,
        //     child: Text(news.p_question.toString()),
        //   )
        ? Consumer<PostController>(
            builder: (context, value, child) => Card(
                  child: Column(
                    children: [
                      Container(
                        //  color: Colors.amber,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 8),
                        height: ss,
                        //padding: const EdgeInsets.all(20),
                        child: Center(
                          child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            // itemCount: polls().length,
                            itemCount: (widget.news.answerSize == "2")
                                ? polls1().length
                                : (widget.news.answerSize == "3")
                                    ? polls2().length
                                    : (widget.news.answerSize == "4")
                                        ? polls3().length
                                        : (widget.news.answerSize == "5")
                                            ? polls4().length
                                            : polls5().length,
                            itemBuilder: (BuildContext context, int index) {
                              final Map<String, dynamic> poll =
                                  (widget.news.answerSize == "2")
                                      ? polls1()[0]
                                      : (widget.news.answerSize == "3")
                                          ? polls2()[0]
                                          : (widget.news.answerSize == "4")
                                              ? polls3()[0]
                                              : (widget.news.answerSize == "5")
                                                  ? polls4()[0]
                                                  : polls5()[0];

                              final int days = DateTime(
                                poll['end_date'].year,
                                poll['end_date'].month,
                                poll['end_date'].day,
                              )
                                  .difference(DateTime(
                                    DateTime.now().year,
                                    DateTime.now().month,
                                    DateTime.now().day,
                                  ))
                                  .inDays;
                              late int voteId = 2;
                              return Container(
                                //   color: Colors.red,
                                //margin: const EdgeInsets.only(bottom: 20),
                                child: FlutterPolls(
                                  //votedBackgroundColor: Colors.red,
                                  //votedProgressColor: Colors.amber,
                                  votesTextStyle: TextStyle(
                                    color: (isVoted(true))
                                        ? Colors.grey
                                        : const Color(0xff009A98),
                                  ),
                                  leadingVotedProgessColor: Colors.grey,
                                  pollOptionsBorder: Border.all(
                                    color: const Color(0xff009A98),
                                  ),
                                  pollOptionsHeight: 44,

                                  userVotedOptionId: voteId,
                                  pollId: poll['id'].toString(),
                                  // new x
                                  // hasVoted: hasVoted.value,
                                  // userVotedOptionId: userVotedOptionId.value,
                                  onVoted: (PollOption pollOption,
                                      int newTotalVotes) async {
                                    if (FirebaseAuth.instance.currentUser ==
                                        null) {
                                      context
                                          .read<AuthBloc>()
                                          .add(AuthLoginEvent());
                                      return false;
                                    } else {
                                      setState(() {
                                        voteId =
                                            int.parse(pollOption.id.toString());
                                      });
                                      print(pollOption.id);
                                      value.addvote(
                                          FirebaseAuth
                                              .instance.currentUser!.uid,
                                          widget.news.id!,
                                          pollOption.id!);
                                      isVoted(false);
                                      await Future.delayed(
                                          const Duration(seconds: 2));

                                      /// If HTTP status is success, return true else false
                                      return true;
                                    }
                                  },
                                  pollEnded: days < 0,
                                  hasVoted: isVoted(false),
                                  pollTitle: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      poll['question'],
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  pollOptions: List<PollOption>.from(
                                    poll['options'].map(
                                      (option) {
                                        var a = PollOption(
                                          id: option['id'],
                                          title: Container(
                                            height: 70,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                150,
                                            child: Align(
                                              alignment: (isVoted(false))
                                                  ? Alignment.centerLeft
                                                  : Alignment.center,
                                              child: Text(
                                                option['title'],
                                                // textAlign: (isVoted())
                                                //     ? TextAlign.left
                                                //     : TextAlign.center,
                                                style: TextStyle(
                                                  color: (isVoted(false))
                                                      ? Colors.black
                                                      : const Color(0xff009A98),
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                                overflow: TextOverflow.clip,
                                              ),
                                            ),
                                          ),
                                          votes: option['votes'],
                                        );
                                        return a;
                                      },
                                    ),
                                  ),

                                  votedPercentageTextStyle: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  metaWidget: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: [
                                        const SizedBox(width: 6),
                                        const Text(
                                          '•',
                                        ),
                                        const SizedBox(
                                          width: 6,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              days < 0
                                                  ? "ended"
                                                  : "ends $days days",
                                              style:
                                                  TextStyle(color: Colors.grey),
                                            ),
                                            // GestureDetector(
                                            //     onTap: () {
                                            //       //   value.isVotated(
                                            //       //       FirebaseAuth.instance
                                            //       //           .currentUser!.uid,
                                            //       //       widget.news.id
                                            //       //           .toString());
                                            //       //   setState(() {
                                            //       //     Navigator.of(context).push(
                                            //       //         MaterialPageRoute(
                                            //       //             builder: (context) {
                                            //       //       return HomeScreen();
                                            //       //     }));
                                            //       //   });
                                            //     },
                                            //     child: Text(" View Result")),
                                            SizedBox(width: 15),
                                            (FirebaseAuth.instance.currentUser
                                                            ?.email ==
                                                        'cybehawksa@gmail.com' ||
                                                    FirebaseAuth
                                                            .instance
                                                            .currentUser
                                                            ?.email ==
                                                        "cybehawks@gmail.com")
                                                ? GestureDetector(
                                                    onTap: () {
                                                      value.undovote(
                                                          FirebaseAuth.instance
                                                              .currentUser!.uid,
                                                          widget.news.id
                                                              .toString());
                                                      Navigator.of(context)
                                                          .push(
                                                        MaterialPageRoute(
                                                          builder: (context) {
                                                            isVoted(false);
                                                            return HomeScreen();
                                                          },
                                                        ),
                                                      );
                                                    },
                                                    child: Text(
                                                      "Undo",
                                                      style: TextStyle(
                                                        color: (!isVoted(false))
                                                            ? Colors.grey
                                                            : const Color(
                                                                0xff009A98),
                                                      ),
                                                    ))
                                                : SizedBox(),
                                            SizedBox(width: 15),
                                            (FirebaseAuth.instance.currentUser
                                                            ?.email ==
                                                        'cybehawksa@gmail.com' ||
                                                    FirebaseAuth
                                                            .instance
                                                            .currentUser
                                                            ?.email ==
                                                        "cybehawks@gmail.com")
                                                ? GestureDetector(
                                                    onTap: () {
                                                      value.deleteNews(widget
                                                          .news.id
                                                          .toString());
                                                      Navigator.of(context)
                                                          .push(
                                                        MaterialPageRoute(
                                                          builder: (context) {
                                                            return HomeScreen();
                                                          },
                                                        ),
                                                      );
                                                    },
                                                    child: Text(
                                                      "Delete",
                                                      style: TextStyle(
                                                          color: const Color(
                                                              0xff009A98)),
                                                    ))
                                                : SizedBox(),
                                            SizedBox(width: 15),
                                            (FirebaseAuth.instance.currentUser
                                                            ?.email ==
                                                        'cybehawksa@gmail.com' ||
                                                    FirebaseAuth
                                                            .instance
                                                            .currentUser
                                                            ?.email ==
                                                        "cybehawks@gmail.com")
                                                ? GestureDetector(
                                                    onTap: () {
                                                      Navigator.of(context)
                                                          .push(
                                                        MaterialPageRoute(
                                                            builder: (_) =>
                                                                SingleListUse(
                                                                    model: widget
                                                                        .news)),
                                                      );
                                                    },
                                                    child: Text(
                                                      "Edit",
                                                      style: TextStyle(
                                                          color: const Color(
                                                              0xff009A98)),
                                                    ))
                                                : SizedBox(),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                IconButton(
                                  visualDensity: VisualDensity.compact,
                                  onPressed: () {
                                    if (FirebaseAuth.instance.currentUser ==
                                        null) {
                                      context
                                          .read<AuthBloc>()
                                          .add(AuthLoginEvent());
                                      return;
                                    }
                                    Share.share(
                                      '''CybeHawks Cyber Update you may be interested in ''' +
                                          widget.news.link!,
                                      subject:
                                          'CybeHawks Cyber Update you may be interested in',
                                    );
                                  },
                                  icon: Icon(
                                    Icons.share,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                                TextButton.icon(
                                  onPressed: () {
                                    if (FirebaseAuth.instance.currentUser ==
                                        null) {
                                      context
                                          .read<AuthBloc>()
                                          .add(AuthLoginEvent());
                                      return;
                                    }
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) =>
                                            CommentsScreen(news: widget.news),
                                      ),
                                    );
                                  },
                                  icon: Icon(Icons.mode_comment_outlined),
                                  style: ButtonStyle(
                                    foregroundColor:
                                        MaterialStateColor.resolveWith(
                                      (states) =>
                                          Theme.of(context).primaryColor,
                                    ),
                                  ),
                                  label: (widget.news.comment!.length > 0)
                                      ? Text(
                                          widget.news.comment!.length
                                              .toString(),
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )
                                      : SizedBox(),
                                )
                              ],
                            ),
                            const Spacer(),
                            StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection('news')
                                  .doc(widget.news.id)
                                  .snapshots(),
                              builder: (context, AsyncSnapshot snapshot) {
                                bool liked = false;
                                if (snapshot.hasData) {
                                  if (snapshot.data['like'].contains(
                                      FirebaseAuth.instance.currentUser?.uid)) {
                                    liked = true;
                                  } else {
                                    liked = false;
                                  }
                                }
                                if (snapshot.hasData) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      color: liked
                                          ? Theme.of(context).primaryColor
                                          : Colors.white,
                                      border: Border.all(
                                        color: Theme.of(context).primaryColor,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: InkWell(
                                      onTap: () async {
                                        if (FirebaseAuth.instance.currentUser ==
                                            null) {
                                          context
                                              .read<AuthBloc>()
                                              .add(AuthLoginEvent());
                                          return;
                                        }
                                        await Provider.of<PostController>(
                                                context,
                                                listen: false)
                                            .toggleLike(
                                          widget.news.id!,
                                          FirebaseAuth
                                              .instance.currentUser!.uid,
                                        );
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 4,
                                        ),
                                        child: Row(
                                          children: [
                                            Text(
                                              snapshot.data['like'].length
                                                  .toString(),
                                              style: TextStyle(
                                                color: liked
                                                    ? Colors.white
                                                    : Theme.of(context)
                                                        .primaryColor,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            Icon(
                                              Icons.thumb_up_alt_outlined,
                                              size: 20,
                                              color: liked
                                                  ? Colors.white
                                                  : Theme.of(context)
                                                      .primaryColor,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                } else
                                  return CircularProgressIndicator();
                              },
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ))
        : GestureDetector(
            onTap: () {
              if (kIsWeb) {
                launch(widget.news.link!);
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => NewsDetails(
                      url: widget.news.link!,
                    ),
                  ),
                );
              }
            },
            child: Card(
              child: Column(
                children: [
                  widget.news.image != null
                      ? Hero(
                          tag: widget.news.title!,
                          child: Image.network(
                            widget.news.image!,
                            height: 150,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        )
                      : SizedBox(),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.news.publishedDate.toString(),
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w900,
                            color: Color(0xffD6DDE2),
                          ),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          widget.news.title!,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          widget.news.description!,
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                IconButton(
                                  visualDensity: VisualDensity.compact,
                                  onPressed: () {
                                    if (FirebaseAuth.instance.currentUser ==
                                        null) {
                                      context
                                          .read<AuthBloc>()
                                          .add(AuthLoginEvent());
                                      return;
                                    }
                                    Share.share(
                                      '''CybeHawks Cyber Update you may be interested in ''' +
                                          widget.news.link!,
                                      subject:
                                          'CybeHawks Cyber Update you may be interested in',
                                    );
                                  },
                                  icon: Icon(
                                    Icons.share,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                                TextButton.icon(
                                  onPressed: () {
                                    if (FirebaseAuth.instance.currentUser ==
                                        null) {
                                      context
                                          .read<AuthBloc>()
                                          .add(AuthLoginEvent());
                                      return;
                                    }
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) =>
                                            CommentsScreen(news: widget.news),
                                      ),
                                    );
                                  },
                                  icon: Icon(Icons.mode_comment_outlined),
                                  style: ButtonStyle(
                                    foregroundColor:
                                        MaterialStateColor.resolveWith(
                                      (states) =>
                                          Theme.of(context).primaryColor,
                                    ),
                                  ),
                                  label: (widget.news.comment!.length > 0)
                                      ? Text(
                                          widget.news.comment!.length
                                              .toString(),
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )
                                      : SizedBox(),
                                )
                              ],
                            ),
                            const Spacer(),
                            StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection('news')
                                  .doc(widget.news.id)
                                  .snapshots(),
                              builder: (context, AsyncSnapshot snapshot) {
                                bool liked = false;
                                if (snapshot.hasData) {
                                  if (snapshot.data['like'].contains(
                                      FirebaseAuth.instance.currentUser?.uid)) {
                                    liked = true;
                                  } else {
                                    liked = false;
                                  }
                                }
                                if (snapshot.hasData) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      color: liked
                                          ? Theme.of(context).primaryColor
                                          : Colors.white,
                                      border: Border.all(
                                        color: Theme.of(context).primaryColor,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: InkWell(
                                      onTap: () async {
                                        if (FirebaseAuth.instance.currentUser ==
                                            null) {
                                          context
                                              .read<AuthBloc>()
                                              .add(AuthLoginEvent());
                                          return;
                                        }
                                        await Provider.of<PostController>(
                                                context,
                                                listen: false)
                                            .toggleLike(
                                          widget.news.id!,
                                          FirebaseAuth
                                              .instance.currentUser!.uid,
                                        );
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 4,
                                        ),
                                        child: Row(
                                          children: [
                                            Text(
                                              snapshot.data['like'].length
                                                  .toString(),
                                              style: TextStyle(
                                                color: liked
                                                    ? Colors.white
                                                    : Theme.of(context)
                                                        .primaryColor,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            Icon(
                                              Icons.thumb_up_alt_outlined,
                                              size: 20,
                                              color: liked
                                                  ? Colors.white
                                                  : Theme.of(context)
                                                      .primaryColor,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                } else
                                  return CircularProgressIndicator();
                              },
                            ),
                          ],
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
