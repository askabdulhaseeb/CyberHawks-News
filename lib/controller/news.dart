import 'package:cloud_firestore/cloud_firestore.dart';

class News {
  final String? title;
  final String? description;
  final DateTime? publishedDate;
  final String? link;
  final String? image;
  final List<Comment>? comment;
  late final String? id;
  final List<String>? like;
  final List<String>? share;
  //
  late final String? p_ispoll;
  late final String? p_question;
  late final DateTime? p_enddate;
  // final List<PollsModel>? p_polls;

  final List<String>? answer_ids;
  final List<String>? answer_texts;
  // final List<String>? answer_votes;
  final List<String>? answer1_votes;
  final List<String>? answer2_votes;
  final List<String>? answer3_votes;
  final List<String>? answer4_votes;

  News({
    this.title = '',
    this.like = const [],
    this.description = '',
    this.publishedDate,
    this.link = '',
    this.id = '',
    this.share = const [],
    this.image = '',
    this.comment = const [],
    //
    this.p_ispoll = "no",
    this.p_question = '',
    this.p_enddate,
    //  this.p_polls = const [],
    this.answer_ids,
    this.answer_texts,
    //this.answer_votes,
    this.answer1_votes = const [],
    this.answer2_votes = const [],
    this.answer3_votes = const [],
    this.answer4_votes = const [],
  });
  Map<String, dynamic> toJson() => {
        'comment': List<Comment>.from(comment!.map((e) => e.toJson())),
        'description': description,
        'id': id,
        'image': image,
        'like': List<String>.from(like!.map((e) => e)),
        'share': List<String>.from(share!.map((e) => e)),
        'title': title,
        'link': link,
        'publishedDate': publishedDate ?? DateTime.now(),
        //
        'p_ispoll': p_ispoll,
        'p_question': p_question,
        'p_enddate': p_enddate ?? DateTime.now(),

        // 'p_polls': List<PollsModel>.from(p_polls!.map((e) => e)),
        "answer_ids": List<String>.from(like!.map((e) => e)),
        "answer_texts": List<String>.from(like!.map((e) => e)),
        // "answer_votes": List<String>.from(like!.map((e) => e)),
        "answer1_votes": List<String>.from(like!.map((e) => e)),
        "answer2_votes": List<String>.from(like!.map((e) => e)),
        "answer3_votes": List<String>.from(like!.map((e) => e)),
        "answer4_votes": List<String>.from(like!.map((e) => e)),
      };

  static News fromJson(Map<String, dynamic> json) => News(
        id: json['id'],
        title: json['title'],
        comment: ((json['comment']) == null)
            ? (null)
            : List<Comment>.from(
                json["comment"].map((x) => Comment.fromJson(x))),
        description: json['description'],
        image: json['image'],
        like: List<String>.from(json['like'].map((x) => x)),
        link: json['link'],
        publishedDate: (json['publishedDate'] as Timestamp).toDate(),
        share: List<String>.from(json["share"].map((x) => x)),
        //
        p_ispoll: json['p_ispoll'],
        p_question: json['p_question'],
        p_enddate: ((json['p_enddate']) == null)
            ? (DateTime.now())
            : ((json['p_enddate'] as Timestamp).toDate()),
        // p_polls: ((json['p_polls']) == null)
        //     ? (null)
        //     : List<PollsModel>.from(
        //         json["p_polls"].map((x) => PollsModel.fromJson(x))),
        answer_ids: ((json['answer_ids']) == null)
            ? (null)
            : List<String>.from(json["answer_ids"].map((x) => x)),
        answer_texts: ((json['answer_texts']) == null)
            ? (null)
            : List<String>.from(json["answer_texts"].map((x) => x)),
        // answer_votes: ((json['answer_votes']) == null)
        //     ? (null)
        //     : List<String>.from(json["answer_votes"].map((x) => x)),
        answer1_votes: List<String>.from(json['answer1_votes'].map((x) => x)),
        answer2_votes: List<String>.from(json['answer2_votes'].map((x) => x)),
        answer3_votes: List<String>.from(json['answer3_votes'].map((x) => x)),
        answer4_votes: List<String>.from(json['answer4_votes'].map((x) => x)),
      );
}

class Comment {
  final DateTime? date;
  final String? email;
  final String? text;
  final String? username;

  Comment({this.date, this.email, this.text, this.username});
  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        email: json["email"],
        text: json["text"],
        username: json["username"],
        date: (json['date'] as Timestamp).toDate(),
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "text": text,
        "username": username,
        "date": date,
      };
}

class PollsModel {
  String? id;
  String? title;
  String? votes;

  PollsModel({
    this.id,
    this.title,
    this.votes,
  });
  factory PollsModel.fromJson(Map<String, dynamic> json) => PollsModel(
        id: json["id"],
        title: json["title"],
        votes: json["votes"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "votes": votes,
      };
}
