import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:localization/localization.dart';
import 'package:mobilni_zpevnik/screens/login_error_notifier.dart';
import 'package:mobilni_zpevnik/screens/screen_template.dart';
import 'package:mobilni_zpevnik/widgets/common_square_button.dart';
import 'package:mobilni_zpevnik/widgets/common_text_button.dart';
import 'package:mobilni_zpevnik/widgets/common_text_field.dart';
import 'package:mobilni_zpevnik/widgets/common_button.dart';
import 'package:provider/provider.dart';
import 'package:mobilni_zpevnik/widgets/custom_divider.dart';
import 'package:mobilni_zpevnik/widgets/ui_gaps.dart';
import 'package:mobilni_zpevnik/widgets/progress_indicator.dart';
import 'package:mobilni_zpevnik/service/auth_service.dart';

class RegisterScreen extends StatelessWidget {
  final VoidCallback swapForLoginScreen;
  final _authService = GetIt.I<AuthService>();

  RegisterScreen({super.key, required this.swapForLoginScreen});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void _signUserUp(
      BuildContext context, LoginErrorProvider loginErrorProvider) async {
    loginErrorProvider.clearErrorMessages();
    ProgressDialog.show(context);

    if (passwordController.text != confirmPasswordController.text) {
      loginErrorProvider.setPasswordErrorMessage("Passwords do not match.");
      ProgressDialog.hide(context);
      return;
    }

    try {
      await _authService.signUpWithEmail(
        emailController.text,
        passwordController.text,
      );
    } on FirebaseAuthException catch (e) {
      final String code = e.code;
      switch (code) {
        case 'email-already-in-use':
          loginErrorProvider.setEmailErrorMessage(code.i18n());
          break;
        case 'weak-password':
        case 'missing-password':
          loginErrorProvider.setPasswordErrorMessage(code.i18n());
          break;
        default:
          loginErrorProvider.setEmailErrorMessage(code);
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
        title: Text('register-now'.i18n()),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              children: [
                const Gap(),
                Text('register-directive'.i18n()),
                const Gap(),
                CommonTextField(
                  controller: emailController,
                  hintText: 'e-mail'.i18n(),
                  obscureText: false,
                  errorText: loginErrorProvider.emailErrorMessage,
                ),
                const Gap(),
                CommonTextField(
                  controller: passwordController,
                  hintText: 'password'.i18n(),
                  obscureText: true,
                  errorText: loginErrorProvider.passwordErrorMessage,
                ),
                const Gap(),
                CommonTextField(
                  controller: confirmPasswordController,
                  hintText: 'confirm-password'.i18n(),
                  obscureText: true,
                  errorText: loginErrorProvider.passwordErrorMessage,
                ),
                const Gap(),
                CommonButton(
                  onPressed: () {
                    _signUserUp(context, loginErrorProvider);
                  },
                  label: 'sign-up'.i18n(),
                ),
                const Gap(),
                const CustomDivider(),
                const Gap(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CommonSquareButton(
                      onTap: () {
                        _authService.signInWithGoogle();
                      },
                      imagePath: "assets/images/google-logo.png",
                    )
                  ],
                ),
                const Gap(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'have-account'.i18n(),
                    ),
                    const SizedBox(width: 4),
                    CommonTextButton(
                      text: 'login'.i18n(),
                      onPressed: swapForLoginScreen,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
