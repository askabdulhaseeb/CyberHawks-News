import 'package:cybehawks/models/news.dart';
import 'package:cybehawks/pages/add_post_screen.dart';
import 'package:cybehawks/pages/dynamic/dynamic_textfield.dart';

import 'package:flutter/material.dart';

class ShowForm {
  static void showForm(BuildContext context, News? model) {
    // if (model != null) {
    //   Provider.of<PostController>(context, listen: false)
    //       .setTextControllers(model);
    // }
    // Navigator.of(context).push(new MaterialPageRoute<Null>(
    //     builder: (BuildContext context) {
    //       return Dialog();
    //     },
    //     fullscreenDialog: true));
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        //  isScrollControlled: true,
        context: context,
        builder: (_) {
          return Container(
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: (() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const AddPostScreen(),
                        ),
                      );
                    }),
                    child: Row(
                      children: [
                        Image.asset('assets/images/world.png'),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Create News',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: (() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => SingleListUse(),
                        ),
                      );
                    }),
                    child: Row(
                      children: [
                        Icon(
                          Icons.bar_chart_outlined,
                          size: 32,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Create Poll',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.close_rounded,
                          size: 32,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Close',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            height: 200,
          );
        });
  }
}
