import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:mobilni_zpevnik/screens/login_error_notifier.dart';
import 'package:mobilni_zpevnik/screens/screen_template.dart';
import 'package:mobilni_zpevnik/widgets/common_text_field.dart';
import 'package:mobilni_zpevnik/widgets/common_button.dart';
import 'package:provider/provider.dart';
import 'package:mobilni_zpevnik/widgets/ui_gaps.dart';
import 'package:mobilni_zpevnik/widgets/progress_indicator.dart';

class ResetPasswordScreen extends StatelessWidget {
  final String email;
  late final emailController = TextEditingController(text: email);

  ResetPasswordScreen({super.key, required this.email});

  Future _resetPassword(
      BuildContext context, LoginErrorProvider loginErrorProvider) async {
    loginErrorProvider.clearEmailErrorMessage();
    ProgressDialog.show(context);

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: emailController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      final String code = e.code;
      switch (code) {
        case 'invalid-email':
          loginErrorProvider.setEmailErrorMessage(code.i18n());
          break;
        default:
          loginErrorProvider.setEmailErrorMessage(code.i18n());
          break;
      }
    }

    if (context.mounted) {
      ProgressDialog.hide(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final loginErrorProvider =
        Provider.of<LoginErrorProvider>(context, listen: true);

    return ScreenTemplate(
      appBar: AppBar(
        title: Text('reset-password'.i18n()),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Gap(),
              CommonTextField(
                controller: emailController,
                hintText: 'e-mail'.i18n(),
                obscureText: false,
                errorText: loginErrorProvider.emailErrorMessage,
              ),
              const Gap(),
              CommonButton(
                onPressed: () {
                  _resetPassword(context, loginErrorProvider);
                },
                label: 'reset-password'.i18n(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
