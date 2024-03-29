import 'package:fashionstown/core/theme/colors.dart';
import 'package:fashionstown/core/theme/text_style.dart';
import 'package:fashionstown/features/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:fashionstown/features/auth/presentation/view/sign_in_view.dart';
import 'package:fashionstown/features/auth/presentation/view/widgets/custom_sign_button.dart';
import 'package:fashionstown/features/auth/presentation/view/widgets/header_body_text.dart';
import 'package:fashionstown/features/home/presentation/view/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/constant/assets_manager.dart';
import '../../manager/auth_cubit/auth_state.dart';
import 'custom_text_field_sign.dart';
import 'divider.dart';
import 'social_media_auth.dart';

class SignUpViewBody extends StatelessWidget {
  SignUpViewBody({super.key});
  final emailConteoller = TextEditingController();
  final nameConteoller = TextEditingController();
  final passwordConteoller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double heightMedia = MediaQuery.of(context).size.height;
    double widthMedia = MediaQuery.of(context).size.width;
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is FeiledCreatedUserState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: errorColor,
              content: Text(
                state.massage,
                style: TextStyles.textStyle14
                    .copyWith(color: textButtonAndMassage),
              )));
        } else if (state is FeiledSendUserDataState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: errorColor,
              content: Text(
                state.massage,
                style: TextStyles.textStyle14
                    .copyWith(color: textButtonAndMassage),
              )));
        } else if (state is UserSignSuccessState) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const HomeView()));
        }
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(top: 80, left: 24, right: 24),
          child: ListView(
            children: [
              const HeaderBodyText(
                textHeader: 'Create Account',
                textBody:
                    'Hi fill your information below or register\n           with your social account.',
              ),
              SizedBox(
                height: heightMedia * 0.06,
              ),
              CustomTextFieldSign(
                  controller: nameConteoller,
                  labelText: 'Name',
                  keyboardType: TextInputType.text),
              SizedBox(
                height: heightMedia * 0.02,
              ),
              CustomTextFieldSign(
                  controller: emailConteoller,
                  labelText: 'Email',
                  keyboardType: TextInputType.emailAddress),
              SizedBox(
                height: heightMedia * 0.02,
              ),
              CustomTextFieldSign(
                controller: passwordConteoller,
                labelText: 'Password',
                keyboardType: TextInputType.visiblePassword,
              ),
              SizedBox(
                height: heightMedia * 0.02,
              ),
              CustomSignButton(
                textButton: 'Sign Up',
                heightButton: heightMedia * 0.07,
                widthButton: widthMedia * 0.9,
                onPressed: () {
                  if (emailConteoller.text.isNotEmpty &&
                      passwordConteoller.text.isNotEmpty &&
                      nameConteoller.text.isNotEmpty) {
                    BlocProvider.of<AuthCubit>(context).registerWithEmail(
                        name: nameConteoller.text,
                        email: emailConteoller.text,
                        password: passwordConteoller.text);
                  } else {
                    if (emailConteoller.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          backgroundColor: errorColor,
                          content: Text('Check Email Field Is Empty')));
                    } else if (passwordConteoller.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          backgroundColor: errorColor,
                          content: Text('Check Password Field Is Empty')));
                    } else if (nameConteoller.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          backgroundColor: errorColor,
                          content: Text('Check Name Field Is Empty')));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          backgroundColor: errorColor,
                          content:
                              Text('Check Password And Email Field Is Empty')));
                    }
                  }
                },
              ),
              const DividerWidget(
                textDivider: 'Or Sign Up With',
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SocialAuthButton(
                    socialAuthIcon: AssetsManager.googleAuth,
                    heightButton: heightMedia * 0.07,
                    widthButton: widthMedia * 0.85,
                    textButton: 'Sign With Google',
                    onPressed: () {
                      BlocProvider.of<AuthCubit>(context).signInWithGoogle();
                    },
                  ),
                ],
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  'Already have an acount?',
                  style: TextStyles.textStyle14,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignInView()));
                  },
                  child: Text(
                    'Sign In',
                    style: TextStyles.textStyle14.copyWith(
                      color: appColor,
                    ),
                  ),
                ),
              ]),
            ],
          ),
        );
      },
    );
  }
}