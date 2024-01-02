import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:mobilni_zpevnik/models/song.dart';
import 'package:mobilni_zpevnik/screens/screen_template.dart';
import 'package:mobilni_zpevnik/widgets/common_button.dart';
import 'package:mobilni_zpevnik/widgets/common_text_field.dart';
import 'package:mobilni_zpevnik/widgets/ui_gaps.dart';

class CreateSongbookScreen extends StatelessWidget {
  final Function(String name, List<Song> songs) onCreate;

  CreateSongbookScreen({Key? key, required this.onCreate}) : super(key: key);

  final songbookNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    songbookNameController.text = '${'songbook'.i18n()} name';
    songbookNameController.selection = TextSelection(
      baseOffset: 0,
      extentOffset: songbookNameController.text.length,
    );

    return ScreenTemplate(
      appBar: AppBar(
        title: const Text('Create Songbook'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Gap(),
              const Text('Enter songbook name.'),
              const Gap(),
              CommonTextField(
                controller: songbookNameController,
                hintText: 'Songbook name',
              ),
              const Gap(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CommonButton(
                    width: 200,
                    label: 'Cancel',
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  CommonButton(
                    width: 200,
                    label: 'Create',
                    onPressed: () {
                      onCreate(songbookNameController.text, []);
                      Navigator.popUntil(context, (route) => route.isFirst);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
