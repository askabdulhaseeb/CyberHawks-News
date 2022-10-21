import 'package:cybehawks/components/primary_button.dart';
import 'package:cybehawks/controller/post_controller.dart';
import 'package:cybehawks/models/news.dart';
import 'package:cybehawks/pages/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

class SingleListUse extends StatefulWidget {
  static final String tag = 'single-list-use';
  SingleListUse({Key? key, this.model = null}) : super(key: key);
  @override
  _SingleListUseState createState() => _SingleListUseState();
  News? model;
}

class Student1 {
  String _name;
  int _sessionId;

  Student1(this._name, this._sessionId);

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  int get sessionId => _sessionId;

  set sessionId(int value) {
    _sessionId = value;
  }

  @override
  String toString() {
    return 'Student $_name from session $_sessionId';
  }
}

class _SingleListUseState extends State<SingleListUse> {
  void _addNewStudent() {
    setState(() {
      print("max");

      Provider.of<PostController>(context, listen: false)
          .studentList
          .add(Student1('', 1));
    });
  }

  @override
  void initState() {
    if (widget.model != null) {
      print(widget.model!.p_question);
      Provider.of<PostController>(context, listen: false)
          .setControllersUpdate(widget.model);
    }

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: (widget.model == null)
              ? Text('Create Poll')
              : Text('Update Poll'),
          centerTitle: true,
        ),
        body: Consumer<PostController>(
          builder: (context, value, child) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Your quection *',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  TextFormField(
                    controller: value.questionController,
                    maxLength: 200,
                    maxLines: 3,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter Your Quection',
                      hintStyle: TextStyle(
                        fontSize: 14,
                        color: Colors.black.withOpacity(0.50),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please Enter Quection';
                      }

                      return null;
                    },
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height / 3,
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
                    child: Builder(
                      builder: (context) {
                        print(
                            "List : ${Provider.of<PostController>(context, listen: false).studentList.toString()}");
                        Provider.of<PostController>(context, listen: false)
                                .studentMap =
                            Provider.of<PostController>(context, listen: false)
                                .studentList
                                .asMap();
                        print(
                            "MAP : ${Provider.of<PostController>(context, listen: false).studentMap.toString()}");
                        return ListView.builder(
                          itemCount: Provider.of<PostController>(context,
                                  listen: false)
                              .studentMap
                              .length,
                          itemBuilder: (context, position) {
                            print('Item Position $position');

                            return Padding(
                              padding: EdgeInsets.only(top: 5.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Option',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Expanded(
                                        child: TextFormField(
                                          maxLength: 135,
                                          maxLines: 3,
                                          controller:
                                              value.controllrs[position],
                                          // initialValue: _studentMap[position].name.length != 0
                                          //     ? _studentMap[position].name
                                          // : '',
                                          onFieldSubmitted: (name) {
                                            setState(() {
                                              Provider.of<PostController>(
                                                      context,
                                                      listen: false)
                                                  .studentList[position]
                                                  .name = name;
                                            });
                                          },
                                          decoration: InputDecoration(
                                            hintText: 'Add option',
                                            hintStyle: TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.black26,
                                            ),
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.black12,
                                              ),
                                              // borderRadius: BorderRadius.all(
                                              //   Radius.circular(15.0),
                                              // ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      (position == 0)
                                          ? SizedBox()
                                          : (position == 1)
                                              ? SizedBox()
                                              : (position + 1 ==
                                                      Provider.of<PostController>(
                                                              context,
                                                              listen: false)
                                                          .studentList
                                                          .length)
                                                  ? IconButton(
                                                      icon: Icon(
                                                        Icons.delete,
                                                        color: Colors.red,
                                                      ),
                                                      onPressed: () {
                                                        setState(() {
                                                          Provider.of<PostController>(
                                                                  context,
                                                                  listen: false)
                                                              .studentList
                                                              .removeAt(
                                                                  position);
                                                        });
                                                      },
                                                    )
                                                  : SizedBox(),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _addNewStudent();
                    },
                    child: Container(
                      width: 100,
                      height: 30,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.amber),
                      child: Row(
                        children: [
                          Icon(
                            Icons.add,
                          ),
                          GestureDetector(
                              onTap: () {
                                print("length");
                                print(Provider.of<PostController>(context,
                                        listen: false)
                                    .studentList
                                    .length);
                                if (Provider.of<PostController>(context,
                                            listen: false)
                                        .studentList
                                        .length <=
                                    5) {
                                  _addNewStudent();
                                }
                              },
                              child: Text('Add option'))
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Poll duration *',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  TextFormField(
                    controller: value.dateController,
                    readOnly: true,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              // _dateController.text = _selectedValue.toString();
                            });

                            _showPicker(context);
                          },
                          icon: Icon(Icons.arrow_drop_down)),
                      border: OutlineInputBorder(),
                      //  hintText: 'Value: $_selectedValue',
                      hintStyle: TextStyle(
                        fontSize: 14,
                        color: Colors.black.withOpacity(0.50),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please Enter Quection';
                      }

                      return null;
                    },
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: (value.islording)
                        ? SpinKitThreeInOut(
                            color: Color.fromARGB(255, 41, 127, 184),
                            size: 50.0,
                          )
                        : (widget.model == null)
                            ? PrimaryButton(
                                text: 'Add Poll',
                                onPressed: () {
                                  print("Add");
                                  setState(() {
                                    value.setLording(true);
                                  });
                                  if (value.pollvalidate()) {
                                    value.setAnswers();
                                    value.postPoll();
                                    Future.delayed(Duration(seconds: 2), () {
                                      // Navigator.of(context).pop();

                                      Navigator.pushReplacement(context,
                                          MaterialPageRoute(builder: (context) {
                                        return HomeScreen();
                                      }));

                                      value.clearColnrollers();
                                      setState(() {
                                        value.setLording(false);
                                      });
                                    });
                                  } else {
                                    print("error");
                                  }
                                })
                            : PrimaryButton(
                                text: "Update Poll",
                                onPressed: () {
                                  print("update");
                                  setState(() {
                                    value.setLording(true);
                                  });
                                  if (value.pollvalidate()) {
                                    value.setAnswers();
                                    value.updatePoll(
                                        widget.model!.id.toString());
                                    Future.delayed(Duration(seconds: 2), () {
                                      Navigator.of(context).pop();
                                      value.clearColnrollers();
                                      setState(() {
                                        value.setLording(false);
                                      });
                                    });
                                  } else {
                                    print("error");
                                  }
                                }),
                  )
                ],
              ),
            ),
          ),
        ));
  }

  int selectedValue = 0;

  void _showPicker(BuildContext ctx) {
    showCupertinoModalBottomSheet(
        context: ctx,
        builder: (_) => Consumer<PostController>(
              builder: (context, value3, child) => Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 250,
                    child: CupertinoPicker(
                      backgroundColor: Color.fromARGB(255, 230, 228, 228),
                      itemExtent: 30,
                      scrollController:
                          FixedExtentScrollController(initialItem: 0),
                      children: [
                        Text('1 Days'),
                        Text('3 Days'),
                        Text('7 Days'),
                        Text('2 Weeks'),
                      ],
                      onSelectedItemChanged: (value) {
                        print(value);

                        selectedValue = value;

                        print(value3.dateController.text);
                        if (value == 0) {
                          value3.dateController.text = "1 Days";
                        } else if (value == 1) {
                          value3.dateController.text = "3 Days";
                        } else if (value == 2) {
                          value3.dateController.text = "7 Days";
                        } else if (value == 3) {
                          value3.dateController.text = "2 Weeks";
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              int d = 1;
                              if (value3.dateController == "1 Days") {
                                d = 1;
                              } else if (value3.dateController == "3 Days") {
                                d = 3;
                              } else if (value3.dateController == "7 Days") {
                                d = 7;
                              } else if (value3.dateController == "14 Days") {
                                d = 14;
                              }
                              value3.setdate(d);
                              setState(() {});
                              Navigator.pop(context);
                            },
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Color.fromARGB(255, 152, 147, 147)),
                                padding: MaterialStateProperty.all(
                                    EdgeInsets.all(5)),
                                textStyle: MaterialStateProperty.all(
                                    TextStyle(fontSize: 12))),
                            child: Text("Done")),
                      ],
                    ),
                  ),
                ],
              ),
            ));
  }
}
