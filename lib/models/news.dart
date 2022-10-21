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
  late DateTime? p_enddate;
  // final List<PollsModel>? p_polls;

  final List<String>? answer_ids;
  final List<String>? answer_texts;
  // final List<String>? answer_votes;
  final List<String>? answer1_votes;
  final List<String>? answer2_votes;
  final List<String>? answer3_votes;
  final List<String>? answer4_votes;
  final List<String>? answer5_votes;
  final List<String>? answer6_votes;

  late final String answerSize;

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
    this.answer5_votes = const [],
    this.answer6_votes = const [],
    this.answerSize = '0',
  });
  Map<String, dynamic> toJson() => {
        'comment': List<Comment>.from(comment!.map((e) => e.toJson())),
        'description': description ?? "#",
        'id': id,
        'image': image ?? "#",
        'like': List<String>.from(like!.map((e) => e)),
        'share': List<String>.from(share!.map((e) => e)),
        'title': title ?? "#",
        'link': link ?? "#",
        'publishedDate': publishedDate ?? DateTime.now(),
        //
        'p_ispoll': p_ispoll ?? "#",
        'p_question': p_question ?? "#",
        'p_enddate': p_enddate ?? DateTime.now(),

        // 'p_polls': List<PollsModel>.from(p_polls!.map((e) => e)),
        "answer_ids": answer_ids ?? [],
        "answer_texts": answer_texts ?? [],
        // "answer_votes": List<String>.from(like!.map((e) => e)),
        "answer1_votes": answer1_votes ?? [],
        "answer2_votes": answer2_votes ?? [],
        "answer3_votes": answer3_votes ?? [],
        "answer4_votes": answer4_votes ?? [],
        "answer5_votes": answer5_votes ?? [],
        "answer6_votes": answer6_votes ?? [],
        'answerSize': answerSize,
      };

  static News fromJson(Map<String, dynamic> json) => News(
        id: json['id'],
        title: json['title'],
        comment: ((json['comment']) == null)
            ? ([])
            : List<Comment>.from(
                json["comment"].map((x) => Comment.fromJson(x))),
        description: json['description'],
        image: json['image'],
        like: List<String>.from(json['like'].map((x) => x)),
        link: json['link'],
        publishedDate: (json['publishedDate'] as Timestamp).toDate(),
        share: ((json['share']) == null)
            ? ([])
            : List<String>.from(json["share"].map((x) => x)),
        //
        p_ispoll: json['p_ispoll'],
        p_question: json['p_question'],
        p_enddate: ((json['p_enddate']) == null)
            ? (DateTime.now())
            : ((json['p_enddate'] as Timestamp).toDate()),

        answer_ids: ((json['answer_ids']) == null)
            ? ([])
            : List<String>.from(json["answer_ids"].map((x) => x)),
        answer_texts: ((json['answer_texts']) == null)
            ? ([])
            : List<String>.from(json["answer_texts"].map((x) => x)),

        answer1_votes: ((json['answer1_votes']) == null)
            ? ([])
            : List<String>.from(json['answer1_votes'].map((x) => x)),
        answer2_votes: ((json['answer2_votes']) == null)
            ? ([])
            : List<String>.from(json['answer2_votes'].map((x) => x)),
        answer3_votes: ((json['answer3_votes']) == null)
            ? ([])
            : List<String>.from(json['answer3_votes'].map((x) => x)),
        answer4_votes: ((json['answer4_votes']) == null)
            ? ([])
            : List<String>.from(json['answer4_votes'].map((x) => x)),
        answer5_votes: ((json['answer5_votes']) == null)
            ? ([])
            : List<String>.from(json['answer5_votes'].map((x) => x)),
        answer6_votes: ((json['answer6_votes']) == null)
            ? ([])
            : List<String>.from(json['answer6_votes'].map((x) => x)),
        answerSize: ((json['answerSize']) == null) ? ("4") : json['answerSize'],
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
