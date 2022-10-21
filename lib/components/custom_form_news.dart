import 'dart:io';

import 'package:cybehawks/components/primary_button.dart';
import 'package:cybehawks/models/news.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart' as path;

import '../controller/post_controller.dart';

class NewsForm extends StatefulWidget {
  const NewsForm({Key? key}) : super(key: key);

  @override
  State<NewsForm> createState() => _NewsFormState();
}

class _NewsFormState extends State<NewsForm> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  final TextEditingController _linkController = TextEditingController();
  bool processingStatus = false;
  final _formKey = GlobalKey<FormState>();
  FirebaseStorage storage = FirebaseStorage.instance;
  String? imageUrl;
  bool isDisabled = true;
  double progress = 0.0;
// Then upload to Firebase Storage
  XFile? pickedImage;
  Future<void> _upload(String inputSource) async {
    final picker = ImagePicker();
    try {
      pickedImage = await picker.pickImage(
          source: inputSource == 'camera'
              ? ImageSource.camera
              : ImageSource.gallery,
          maxWidth: 1920);
      setState(() {
        processingStatus = true;
      });
      final String fileName = path.basename(pickedImage!.path);
      File imageFile = File(pickedImage!.path);

      try {
        // Uploading the selected image with some custom meta data
        await storage
            .ref(fileName)
            .putFile(
                imageFile,
                SettableMetadata(customMetadata: {
                  'uploaded_by': 'cybehawks@gmail.com',
                }))
            .then((p0) async {
          imageUrl = await p0.ref.getDownloadURL();
          setState(() {});
          if (p0.state == TaskState.success) {
            setState(() {
              processingStatus = false;
            });
          }
        });

        // Refresh the UI
        setState(() {});
      } on FirebaseException catch (error) {
        if (kDebugMode) {
          print(error);
        }
      }
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
    }
  }

  @override
  void initState() {
    imageUrl = null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _titleController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: 'Title',
                  focusedBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).primaryColor),
                  ),
                  hintStyle: TextStyle(
                    fontSize: 14,
                    color: Colors.black.withOpacity(0.50),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please Enter Title';
                  }

                  return null;
                },
              ),
              TextFormField(
                controller: _linkController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: 'Link',
                  focusedBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).primaryColor),
                  ),
                  hintStyle: TextStyle(
                    fontSize: 14,
                    color: Colors.black.withOpacity(0.50),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please Enter Link';
                  }

                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: 'Description',
                  focusedBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).primaryColor),
                  ),
                  hintStyle: TextStyle(
                    fontSize: 14,
                    color: Colors.black.withOpacity(0.50),
                  ),
                ),
                minLines: 10,
                maxLines: 3000,
                maxLength: 3000,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please Enter Description';
                  }

                  return null;
                },
              ),
              pickedImage == null ? Text('Select image') : SizedBox(),
              ElevatedButton.icon(
                onPressed: () => _upload('gallery'),
                icon: const Icon(Icons.library_add),
                label: const Text('Gallery'),
              ),
              (processingStatus)
                  ? Column(
                      children: [
                        Text('Processing Image'),
                        LinearProgressIndicator()
                      ],
                    )
                  : SizedBox(),
              SizedBox(
                width: double.infinity,
                child: PrimaryButton(
                  text: 'Post News',
                  onPressed: imageUrl == null
                      ? null
                      : () async {
                          if (_formKey.currentState!.validate()) {
                            debugPrint('Posting NEws');
                            await Provider.of<PostController>(context,
                                    listen: false)
                                .postNews(
                              News(
                                image: imageUrl,
                                title: _titleController.text,
                                description: _descriptionController.text,
                                link: _linkController.text,
                                publishedDate: DateTime.now(),
                              ),
                            );
                            Navigator.of(context).pop();
                          }
                        },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class ShowNewsForm {
//   static void showForm(BuildContext context, News? model) {
//     // if (model != null) {
//     //   Provider.of<PostController>(context, listen: false)
//     //       .setTextControllers(model);
//     // }
//     // Navigator.of(context).push(new MaterialPageRoute<Null>(
//     //     builder: (BuildContext context) {
//     //       return Dialog();
//     //     },
//     //     fullscreenDialog: true));
//     showModalBottomSheet(
//         shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(20), topRight: Radius.circular(20))),
//         //  isScrollControlled: true,
//         context: context,
//         builder: (_) {
//           return Container();
//         });
//   }
// }
