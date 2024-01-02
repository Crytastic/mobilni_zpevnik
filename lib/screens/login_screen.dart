import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:localization/localization.dart';
import 'package:mobilni_zpevnik/screens/login_error_notifier.dart';
import 'package:mobilni_zpevnik/screens/reset_password_screen.dart';
import 'package:mobilni_zpevnik/screens/screen_template.dart';
import 'package:mobilni_zpevnik/service/auth_service.dart';
import 'package:mobilni_zpevnik/widgets/common_square_button.dart';
import 'package:mobilni_zpevnik/widgets/common_text_button.dart';
import 'package:mobilni_zpevnik/widgets/common_text_field.dart';
import 'package:mobilni_zpevnik/widgets/common_button.dart';
import 'package:mobilni_zpevnik/widgets/custom_divider.dart';
import 'package:provider/provider.dart';
import 'package:mobilni_zpevnik/widgets/ui_gaps.dart';
import 'package:mobilni_zpevnik/widgets/progress_indicator.dart';

class LoginScreen extends StatelessWidget {
  final VoidCallback swapForRegisterScreen;
  final _authService = GetIt.I<AuthService>();

  LoginScreen({super.key, required this.swapForRegisterScreen});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void _signUserIn(
    BuildContext context,
    LoginErrorProvider loginErrorProvider,
  ) async {
    loginErrorProvider.clearErrorMessages();
    ProgressDialog.show(context);

    try {
      await _authService.signInWithEmail(
        emailController.text,
        passwordController.text,
      );
    } on FirebaseAuthException catch (e) {
      final String code = e.code;
      switch (code) {
        case 'invalid-email':
          loginErrorProvider.setEmailErrorMessage(code.i18n());
          break;
        case 'invalid-credential':
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
        title: Text('login-now'.i18n()),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              children: [
                const Gap(),
                Text('login-directive'.i18n()),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CommonTextButton(
                      text: 'forgot-password'.i18n(),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ResetPasswordScreen(
                                email: emailController.text),
                          ),
                        );
                      },
                    )
                  ],
                ),
                const Gap(),
                CommonButton(
                  onPressed: () {
                    _signUserIn(context, loginErrorProvider);
                  },
                  label: 'sign-in'.i18n(),
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
                      'no-account'.i18n(),
                    ),
                    const SizedBox(width: 4),
                    CommonTextButton(
                      text: 'register-now'.i18n(),
                      onPressed: swapForRegisterScreen,
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
