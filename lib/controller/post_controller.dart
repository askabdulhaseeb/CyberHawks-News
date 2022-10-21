import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cybehawks/pages/dynamic/dynamic_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:cybehawks/models/news.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

class PostController extends ChangeNotifier {
  bool islording = false;
  void setLording(bool a) {
    islording = a;
  }

  TextEditingController _questionController = TextEditingController();
  DateTime _p_date = DateTime.now();

  TextEditingController get questionController => _questionController;
  DateTime get p_date => _p_date;
  List<Student1> studentList = [Student1('', 1), Student1('', 2)];
  Map<int, Student1> studentMap = {};

  List<TextEditingController> controllrs = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];

  String an1 = "a";
  String an2 = "b";
  String an3 = "c";
  String an4 = "d";
  String an5 = "e";
  String an6 = "f";

  void setAnswers() {
    print(studentList.length);
    if (studentList.length == 2) {
      an1 = controllrs[0].text.toString();
      an2 = controllrs[1].text.toString();
    } else if (studentList.length == 3) {
      an1 = controllrs[0].text.toString();
      an2 = controllrs[1].text.toString();
      an3 = controllrs[2].text.toString();
    } else if (studentList.length == 4) {
      an1 = controllrs[0].text.toString();
      an2 = controllrs[1].text.toString();
      an3 = controllrs[2].text.toString();
      an4 = controllrs[3].text.toString();
    } else if (studentList.length == 5) {
      an1 = controllrs[0].text.toString();
      an2 = controllrs[1].text.toString();
      an3 = controllrs[2].text.toString();
      an4 = controllrs[3].text.toString();
      an5 = controllrs[4].text.toString();
    } else if (studentList.length == 6) {
      an1 = controllrs[0].text.toString();
      an2 = controllrs[1].text.toString();
      an3 = controllrs[2].text.toString();
      an4 = controllrs[3].text.toString();
      an5 = controllrs[4].text.toString();
      an6 = controllrs[5].text.toString();
    } else {
      print("not set");
    }
  }

  // bool viewR = false;
  // void viewResult() {
  //   viewR = !viewR;
  //   print(viewR);
  // }

  TextEditingController dateController = TextEditingController();

  void setdate(int d) {
    _p_date = _p_date.add(new Duration(days: d));
  }

  bool pollvalidate() {
    bool validate = false;
    if (_questionController.text.isEmpty ||
        controllrs[0].text.isEmpty ||
        controllrs[1].text.isEmpty) {
      validate = false;
      setLording(false);
    } else if (controllrs[0].text == controllrs[1].text) {
      validate = false;
      setLording(false);
    } else {
      validate = true;
    }
    notifyListeners();
    return validate;
  }

  News? toPostpoll;

  void clearColnrollers() {
    an1 = "a";
    an2 = "b";
    an3 = "c";
    an4 = "d";
    an5 = "e";
    an6 = "f";

    dateController.clear();
    questionController.clear();

    studentList = [Student1('', 1), Student1('', 2)];
    studentMap = {};

    controllrs[0].clear();
    controllrs[1].clear();
    controllrs[2].clear();
    controllrs[3].clear();
    controllrs[4].clear();
    controllrs[5].clear();
  }

  void updatePoll(String newsId) async {
    final toPostpoll = News(
        id: newsId,
        p_question: _questionController.text.toString(),
        p_enddate: _p_date,
        answer_texts: ["$an1", "$an2", "$an3", "$an4", "$an5", "$an6"],
        answer_ids: ["1", "2", "3", "4", "5", "6"],
        answerSize: studentList.length.toString(),
        p_ispoll: "yes");
    await _firestore.collection('news').doc(newsId).set(toPostpoll.toJson());

    // await docpolls.set(toPostpoll.toJson());
    print("Poll updated");

    // await FirebaseFirestore.instance.collection("news").doc(docpolls.id).set({
    //   "answer_ids": FieldValue.arrayUnion(["1", "2", "3", "4", "5", "6"]),
    //   "answer_texts": FieldValue.arrayUnion([an1, an2, an3, an4, an5, an6]),
    // }, SetOptions(merge: true));
  }

  void postPoll() async {
    final docpolls = _firestore.collection('news').doc();
    final toPostpoll = News(
      id: docpolls.id,
      description: "please update your app get new poll option.",
      // like: [],
      link: "https://play.google.com/store/apps/details?id=com.cyberhawks",
      image:
          "https://firebasestorage.googleapis.com/v0/b/cybehawks-news.appspot.com/o/aaaaa.png?alt=media&token=18a1db4e-24dd-4d76-8545-db806773e6c8",
      publishedDate: DateTime.now(),
      title: "update your application",
      p_question: _questionController.text.toString(),
      p_enddate: _p_date,
      p_ispoll: "yes",
      // answer1_votes: [],
      // answer2_votes: [],
      // answer3_votes: [],
      // answer4_votes: [],
      // answer5_votes: [],
      // answer6_votes: [],
      answer_ids: ["1", "2", "3", "4", "5", "6"],
      answer_texts: ["$an1", "$an2", "$an3", "$an4", "$an5", "$an6"],
      // answer_texts: ["an1", "an2", "an3", "an4", "an5", "an6"],
      // comment: [],
      // share: [],
      answerSize: studentList.length.toString(),
    );

    await docpolls.set(toPostpoll.toJson());
    print("Poll Id : ${docpolls.id}-------------------------------");

    // await FirebaseFirestore.instance.collection("news").doc(docpolls.id).set({
    //   "answer_ids": FieldValue.arrayUnion(["1", "2", "3", "4", "5", "6"]),
    //   "answer_texts": FieldValue.arrayUnion([an1, an2, an3, an4, an5, an6]),
    // }, SetOptions(merge: true));
  }

  setControllersUpdate(News? n) {
    if (n != null) {
      questionController.text = n.p_question!;
      controllrs[0].text = n.answer_texts![0].toString();
      controllrs[1].text = n.answer_texts![1].toString();
      controllrs[2].text = n.answer_texts![2].toString();
      controllrs[3].text = n.answer_texts![3].toString();
      controllrs[4].text = n.answer_texts![4].toString();
      controllrs[5].text = n.answer_texts![5].toString();
    }
    if (n!.answerSize == "2") {
      studentList = [
        Student1('', 1),
        Student1('', 2),
      ];
    } else if (n.answerSize == "3") {
      studentList = [
        Student1('', 1),
        Student1('', 2),
        Student1('', 3),
      ];
    } else if (n.answerSize == "4") {
      studentList = [
        Student1('', 1),
        Student1('', 2),
        Student1('', 3),
        Student1('', 4),
      ];
    } else if (n.answerSize == "5") {
      studentList = [
        Student1('', 1),
        Student1('', 2),
        Student1('', 3),
        Student1('', 4),
        Student1('', 5),
      ];
    } else if (n.answerSize == "6") {
      studentList = [
        Student1('', 1),
        Student1('', 2),
        Student1('', 3),
        Student1('', 4),
        Student1('', 5),
        Student1('', 6),
      ];

      dateController.text = n.p_enddate!.day.toString();
    }
  }

  Future<void> undovote(
    String userId,
    String newsId,
  ) async {
    var x = await _firestore.collection('news').doc(newsId).get();
    List<dynamic> answer1_votes = x['answer1_votes'];
    List<dynamic> answer2_votes = x['answer2_votes'];
    List<dynamic> answer3_votes = x['answer3_votes'];
    List<dynamic> answer4_votes = x['answer4_votes'];
    List<dynamic> answer5_votes = x['answer5_votes'];
    List<dynamic> answer6_votes = x['answer6_votes'];

    if (answer1_votes.contains(userId)) {
      await FirebaseFirestore.instance.collection("news").doc(newsId).set({
        "answer1_votes": FieldValue.arrayRemove([userId])
      }, SetOptions(merge: true));
    } else if (answer2_votes.contains(userId)) {
      await FirebaseFirestore.instance.collection("news").doc(newsId).set({
        "answer2_votes": FieldValue.arrayRemove([userId])
      }, SetOptions(merge: true));
    } else if (answer3_votes.contains(userId)) {
      await FirebaseFirestore.instance.collection("news").doc(newsId).set({
        "answer3_votes": FieldValue.arrayRemove([userId])
      }, SetOptions(merge: true));
    } else if (answer4_votes.contains(userId)) {
      await FirebaseFirestore.instance.collection("news").doc(newsId).set({
        "answer4_votes": FieldValue.arrayRemove([userId])
      }, SetOptions(merge: true));
    } else if (answer5_votes.contains(userId)) {
      await FirebaseFirestore.instance.collection("news").doc(newsId).set({
        "answer5_votes": FieldValue.arrayRemove([userId])
      }, SetOptions(merge: true));
    } else if (answer6_votes.contains(userId)) {
      await FirebaseFirestore.instance.collection("news").doc(newsId).set({
        "answer6_votes": FieldValue.arrayRemove([userId])
      }, SetOptions(merge: true));
    }
  }

  void addvote(
    String userId,
    String newsId,
    int id,
  ) async {
    var x = await _firestore.collection('news').doc(newsId).get();
    List<dynamic> answer1_votes = x['answer1_votes'];
    List<dynamic> answer2_votes = x['answer2_votes'];
    List<dynamic> answer3_votes = x['answer3_votes'];
    List<dynamic> answer4_votes = x['answer4_votes'];
    List<dynamic> answer5_votes = x['answer5_votes'];
    List<dynamic> answer6_votes = x['answer6_votes'];

    if (answer1_votes.contains(userId) ||
        answer2_votes.contains(userId) ||
        answer3_votes.contains(userId) ||
        answer4_votes.contains(userId) ||
        answer5_votes.contains(userId) ||
        answer6_votes.contains(userId)) {
      print("alrady vatedd");
    } else {
      if (id == 1) {
        await FirebaseFirestore.instance.collection("news").doc(newsId).set({
          "answer1_votes": FieldValue.arrayUnion([userId])
        }, SetOptions(merge: true));
      } else if (id == 2) {
        await FirebaseFirestore.instance.collection("news").doc(newsId).set({
          "answer2_votes": FieldValue.arrayUnion([userId])
        }, SetOptions(merge: true));
      } else if (id == 3) {
        await FirebaseFirestore.instance.collection("news").doc(newsId).set({
          "answer3_votes": FieldValue.arrayUnion([userId])
        }, SetOptions(merge: true));
      } else if (id == 4) {
        await FirebaseFirestore.instance.collection("news").doc(newsId).set({
          "answer4_votes": FieldValue.arrayUnion([userId])
        }, SetOptions(merge: true));
      } else if (id == 5) {
        await FirebaseFirestore.instance.collection("news").doc(newsId).set({
          "answer5_votes": FieldValue.arrayUnion([userId])
        }, SetOptions(merge: true));
      } else if (id == 6) {
        await FirebaseFirestore.instance.collection("news").doc(newsId).set({
          "answer6_votes": FieldValue.arrayUnion([userId])
        }, SetOptions(merge: true));
      } else {
        print("Error");
      }
    }
  }

  static const _MONTHS = {
    'Jan': '01',
    'Feb': '02',
    'Mar': '03',
    'Apr': '04',
    'May': '05',
    'Jun': '06',
    'Jul': '07',
    'Aug': '08',
    'Sep': '09',
    'Oct': '10',
    'Nov': '11',
    'Dec': '12',
  };

  DateTime? parseRfc822(String input) {
    input = input.replaceFirst('GMT', '+0000');

    final splits = input.split(' ');

    final splitYear = splits[3];

    final splitMonth = _MONTHS[splits[2]];
    if (splitMonth == null) return null;

    var splitDay = splits[1];
    if (splitDay.length == 1) {
      splitDay = '0$splitDay';
    }

    final splitTime = splits[4], splitZone = splits[5];

    var reformatted = '$splitYear-$splitMonth-$splitDay $splitTime $splitZone';

    return DateTime.tryParse(reformatted);
  }

  List<News>? _allNews;
  List<News>? get allNews => _allNews;

  List<News>? firebaseNews;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<List<News>> getAllNews() async {
    final url = Uri.parse('https://portswigger.net/daily-swig/rss');
    final response = await http.get(url);
    var raw = xml.XmlDocument.parse(response.body);
    Iterable<xml.XmlElement> channel = raw.findAllElements('channel');
    var item = channel.first.findAllElements('item');
    _allNews = item
        .map(
          (e) => News(
            title: e.findElements('title').first.text,
            description: e.findElements('description').first.text,
            publishedDate: parseRfc822(e.findElements('pubDate').first.text),
            link: e.findElements('link').first.text,
            image: e.getElement('media:thumbnail')!.getAttribute('url'),
          ),
        )
        .toList();

    notifyListeners();
    return _allNews!;
  }

  Future<void> checkdatainiFirestore() async {
    await getAllNews();
    List? allLinks = [];
    await _firestore
        .collection('news')
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        // Map<String, dynamic>? data  = doc.data() as Map<String, dynamic>?;
        Map data = doc.data() as Map;
        print(data['link']);
        allLinks.add(data['link']);
        // print(allLinks.length);
      }
    });
    print(allLinks.length);
    print('news ${allNews?.length}');
    for (var element in allNews!) {
      // print(element.title);
      if (!allLinks.contains(element.link)) {
        postNews(element);
      }
    }
  }

  Stream<List<News>> getAllNewsFromFirebase() {
    return _firestore
        .collection('news')
        .orderBy('publishedDate', descending: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((e) => News.fromJson(e.data())).toList());
  }

  Stream<List<News>> getAllPollFromFirebase() {
    return _firestore
        .collection('news')
        .where('p_ispoll', isEqualTo: 'yes')
        //.orderBy('publishedDate', descending: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((e) => News.fromJson(e.data())).toList());
  }

  Future<void> postNews(News news) async {
    final docNews = _firestore.collection('news').doc();
    final toPostNews = News(
      id: docNews.id,
      description: news.description,
      like: news.like,
      link: news.link,
      image: news.image,
      publishedDate: news.publishedDate,
      title: news.title,
    );
    print("news Id : ${docNews.id} -----------------------");
    await sendNotification(news.title!, news.description!, news.image!);
    // await sendNotification(news.title!, news.description!, news.image!);
    docNews.set(toPostNews.toJson());
  }

  Future sendNotification(String title, String detail, String image) async {
    await http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization':
            'key=AAAA-EMUP80:APA91bHYTIaCNkxJXDqpkiwXbitc2wvVF16Qu4DaiNKmaqCE3Do4YtMZfbp-MSu7Y6YY2n7tyx5w_mlTMgi0T0NhGB-vc0tdWp49yRmfXZ1eRjku4txM4R1_Eg6r0rWS4FJkQ1Wx96CD',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'body': detail,
            'title': title,
            'image': image,
            'sound': 'default'
          },
          'priority': 'normal',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'id': '1',
            'status': 'done'
          },
          'to': "/topics/all",
        },
      ),
    );
  }

  Future<void> deleteNews(String id) async {
    _firestore.collection('news').doc(id).delete();
  }

  Future<void> postComment(String id, Comment comment) async {
    await _firestore.collection("news").doc(id).set({
      "comment": FieldValue.arrayUnion([
        comment.toJson(),
      ])
    }, SetOptions(merge: true));
  }

  Future<void> toggleLike(String id, String userId) async {
    var x = await _firestore.collection('news').doc(id).get();
    List<dynamic> like = x['like'];
    debugPrint(like.toString());
    if (!like.contains(userId)) {
      await FirebaseFirestore.instance.collection("news").doc(id).set({
        "like": FieldValue.arrayUnion([userId])
      }, SetOptions(merge: true));
    } else {
      await FirebaseFirestore.instance.collection("news").doc(id).set({
        "like": FieldValue.arrayRemove([userId])
      }, SetOptions(merge: true));
    }
  }
}
