import 'package:assignment_ecommerce_project_final/app/app_colors.dart';
import 'package:assignment_ecommerce_project_final/core/extensions/localization_extension.dart';
import 'package:assignment_ecommerce_project_final/core/widgets/centered_circular_progress_indicator.dart';
import 'package:assignment_ecommerce_project_final/core/widgets/show_snack_bar_message.dart';
import 'package:assignment_ecommerce_project_final/features/auth/data/models/sign_in_request_model.dart';
import 'package:assignment_ecommerce_project_final/features/auth/ui/controllers/sign_in_controller.dart';
import 'package:assignment_ecommerce_project_final/features/auth/ui/screens/sign_up_screen.dart';
import 'package:assignment_ecommerce_project_final/features/auth/ui/widgets/app_logo.dart';
import 'package:assignment_ecommerce_project_final/features/common/ui/screens/main_bottom_nav_bar_screen.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  static const String name = '/sign-in';

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();

  final SignInController _signInController = Get.find<SignInController>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 60),
                const AppLogo(),
                const SizedBox(height: 24),
                Text(
                  context.localization.welcomeBack,
                  style: textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Text(
                  context.localization.enterYourEmailAndPassword,
                  style: const TextStyle(color: Colors.grey, fontSize: 16),
                ),
                const SizedBox(height: 16),
                TextFormField(
                    controller: _emailTEController,
                    decoration:
                        InputDecoration(hintText: context.localization.email),
                    validator: (String? value) {
                      String email = value ?? '';
                      if (!EmailValidator.validate(email)) {
                        return 'Enter a valid email';
                      }
                      return null;
                    }),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _passwordTEController,
                  obscureText: true,
                  decoration:
                      InputDecoration(hintText: context.localization.password),
                ),
                const SizedBox(height: 16),
                GetBuilder<SignInController>(builder: (controller) {
                  return Visibility(
                    visible: controller.inProgress == false,
                    replacement: const CenteredCircularProgressIndicator(),
                    child: ElevatedButton(
                      onPressed: _onTapSignInButton,
                      child: Text(context.localization.signIn),
                    ),
                  );
                }),
                const SizedBox(height: 24),
                RichText(
                  text: TextSpan(
                    text: "Don't have an account? ",
                    style: const TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.w600),
                    children: [
                      TextSpan(
                          text: 'Sign up',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.themeColor,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = _onTapSignUpButton),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _onTapSignInButton() async {
    // TODO: validate the form
    SignInRequestModel signInRequestModel = SignInRequestModel(
      email: _emailTEController.text.trim(),
      password: _passwordTEController.text,
    );
    final bool isSuccess = await _signInController.signIn(signInRequestModel);
    if (isSuccess) {
      Navigator.pushNamedAndRemoveUntil(
          context, MainBottomNavBarScreen.name, (value) => false);
    } else {
      showSnackBarMessage(context, _signInController.errorMessage!, true);
    }
  }

  void _onTapSignUpButton() {
    Navigator.pushNamed(context, SignUpScreen.name);
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }
}
