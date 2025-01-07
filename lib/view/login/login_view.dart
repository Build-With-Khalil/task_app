import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:task_app/utils/constants/app_strings.dart';
import 'package:task_app/view/login/components/sign_up_section.dart';

import '../../controller/auth/login_controller.dart';
import '../../utils/constants/colors.dart';
import '../../utils/validation.dart';
import '../../widget/custom_icon.dart';
import '../../widget/custom_text_field.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    /// Get the height and width of the screen
    var height = MediaQuery.sizeOf(context).height;
    var width = MediaQuery.sizeOf(context).width;

    /// Create the formKey locally in the LoginView
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      body: Stack(
        children: [
          /// Background Gradient
          Container(
            height: height,
            width: width,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.primary,
                  AppColors.secondary,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.only(
                top: height * 0.1,
                left: width * 0.05,
              ),
              child: Text(
                AppStrings.helloSignIn,
                style: Theme.of(context).textTheme.headlineLarge!.apply(
                      color: AppColors.whiteColor,
                    ),
              ),
            ),
          ),

          /// Login Form
          Positioned(
            top: height * 0.25,
            child: Container(
              height: height * 0.75,
              width: width,
              decoration: const BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: width * 0.05,
                  vertical: height * 0.05,
                ),
                child: Consumer<LoginProvider>(
                  builder: (context, loginProvider, child) {
                    return Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          /// Email CustomTextField
                          CustomTextField(
                            controller: loginProvider.emailController,
                            hintText: AppStrings.email,
                            hintStyle:
                                Theme.of(context).textTheme.titleMedium!.apply(
                                      color: AppColors.grey,
                                    ),
                            prefixIcon: const CustomIcon(
                              icon: Iconsax.sms5,
                            ),
                            onTapOutside: (event) {
                              FocusScope.of(context).unfocus();
                            },
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) =>
                                AppValidators.validateEmail(value),
                            txtColor: AppColors.black,
                            borderColor: AppColors.grey,
                            focusedBorderColor: AppColors.primary,
                          ),
                          SizedBox(height: height * 0.02),

                          /// Password CustomTextField
                          CustomTextField(
                            controller: loginProvider.passwordController,
                            hintText: AppStrings.password,
                            hintStyle:
                                Theme.of(context).textTheme.titleMedium!.apply(
                                      color: AppColors.grey,
                                    ),
                            prefixIcon: const CustomIcon(
                              icon: Iconsax.password_check5,
                            ),
                            suffixIcon: CustomIcon(
                              icon: loginProvider.isObscure
                                  ? Iconsax.eye_slash5
                                  : Iconsax.eye4,
                              onPressed: loginProvider.toggleObscure,
                            ),
                            onTapOutside: (event) {
                              FocusScope.of(context).unfocus();
                            },
                            isObSecure: loginProvider.isObscure,
                            keyboardType: TextInputType.visiblePassword,
                            validator: (value) =>
                                AppValidators.validateSimplePassword(value),
                            txtColor: AppColors.black,
                            borderColor: AppColors.grey,
                            focusedBorderColor: AppColors.primary,
                          ),
                          SizedBox(height: height * 0.02),

                          /// Forgot Password
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              AppStrings.forgotPassword,
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                          ),
                          SizedBox(height: height * 0.03),

                          /// Sign In Button
                          _buildSignInButton(
                            height,
                            width,
                            loginProvider,
                            formKey,
                            context,
                          ),
                          SizedBox(height: height * 0.02),

                          /// Sign Up Section
                          SignUpSection(height: height),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Builds the Sign In Button with MediaQuery dimensions
  Widget _buildSignInButton(
      double height,
      double width,
      LoginProvider loginProvider,
      GlobalKey<FormState> formKey,
      BuildContext context) {
    return InkWell(
      onTap: () {
        if (formKey.currentState!.validate()) {
          loginProvider.login(context);
        }
      },
      child: Container(
        height: height * 0.07,
        width: width * 0.8,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: const LinearGradient(
            colors: [
              AppColors.primary,
              AppColors.secondary,
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: Center(
          child: loginProvider.isLoading
              ? const CircularProgressIndicator(
                  color: AppColors.whiteColor,
                  strokeWidth: 2.0,
                )
              : Text(
                  AppStrings.signInC,
                  style: Theme.of(context).textTheme.headlineMedium!.apply(
                        color: AppColors.whiteColor,
                      ),
                ),
        ),
      ),
    );
  }
}
