// import 'package:flutter/material.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:flutter_feather_icons/flutter_feather_icons.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:mobile_pos/GlobalComponents/button_global.dart';
// import 'package:mobile_pos/GlobalComponents/glonal_popup.dart';
// import 'package:mobile_pos/Screens/Authentication/Sign%20In/webview_login.dart';
// import 'package:mobile_pos/generated/l10n.dart' as lang;
// import 'package:shared_preferences/shared_preferences.dart';
// import '../../../Const/api_config.dart';
// import '../../../constant.dart';
// import 'Repo/sign_in_repo.dart';
// import '../../../Repository/check_addon_providers.dart';
//
// class SignIn extends StatefulWidget {
//   const SignIn({super.key});
//
//   @override
//   State<SignIn> createState() => _SignInState();
// }
//
// class _SignInState extends State<SignIn> {
//   bool showPassword = true;
//   bool _isChecked = false;
//
//   ///__________variables_____________
//   bool isClicked = false;
//
//   final key = GlobalKey<FormState>();
//
//   TextEditingController emailController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//     _loadUserCredentials();
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     emailController.dispose();
//     passwordController.dispose();
//   }
//
//   void _loadUserCredentials() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     setState(() {
//       _isChecked = prefs.getBool('remember_me') ?? false;
//       if (_isChecked) {
//         emailController.text = prefs.getString('email') ?? '';
//         passwordController.text = prefs.getString('password') ?? '';
//       }
//     });
//   }
//
//   void _saveUserCredentials() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.setBool('remember_me', _isChecked);
//     if (_isChecked) {
//       prefs.setString('email', emailController.text);
//       prefs.setString('password', passwordController.text);
//     } else {
//       prefs.remove('email');
//       prefs.remove('password');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     TextTheme textTheme = Theme.of(context).textTheme;
//     final _theme = Theme.of(context);
//     return GlobalPopup(
//       child: Consumer(
//         builder: (_, ref, watch) {
//           final socialNetworkProvider = ref.watch(socialLoginCheckProvider);
//           return Scaffold(
//             backgroundColor: kWhite,
//             appBar: AppBar(
//               surfaceTintColor: kWhite,
//               centerTitle: false,
//               automaticallyImplyLeading: false,
//               backgroundColor: kWhite,
//               titleSpacing: 16,
//               title: Text(
//                 // 'Sign in',
//                 lang.S.of(context).signIn,
//               ),
//             ),
//             body: SingleChildScrollView(
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
//                 child: Form(
//                   key: key,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       const NameWithLogo(),
//                       // const SizedBox(height: 24),
//                       // Text(
//                       //   // 'Welcome back!',f
//                       //   lang.S.of(context).welcomeBack,
//                       //   style: textTheme.titleMedium?.copyWith(fontSize: 24.0, fontWeight: FontWeight.w600),
//                       // ),
//                       // Text(
//                       //   lang.S.of(context).pleaseEnterYourDetails,
//                       //   //'Please enter your details.',
//                       //   style: textTheme.bodyMedium?.copyWith(color: kGreyTextColor, fontSize: 16),
//                       // ),
//                       const SizedBox(height: 34.0),
//                       TextFormField(
//                         controller: emailController,
//                         keyboardType: TextInputType.emailAddress,
//                         decoration: InputDecoration(
//                           floatingLabelBehavior: FloatingLabelBehavior.always,
//                           // labelText: 'Email',
//                           labelText: lang.S.of(context).lableEmail,
//                           //hintText: 'Enter email address',
//                           hintText: lang.S.of(context).hintEmail,
//                         ),
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             // return 'Email can\'t be empty';
//                             return lang.S.of(context).emailCannotBeEmpty;
//                           } else if (!value.contains('@')) {
//                             //return 'Please enter a valid email';
//                             return lang.S.of(context).pleaseEnterAValidEmail;
//                           }
//                           return null;
//                         },
//                       ),
//                       const SizedBox(height: 20.0),
//                       TextFormField(
//                         controller: passwordController,
//                         keyboardType: TextInputType.text,
//                         obscureText: showPassword,
//                         decoration: InputDecoration(
//                           //labelText: 'Password',
//                           labelText: lang.S.of(context).lablePassword,
//                           //hintText: 'Enter password',
//                           hintText: lang.S.of(context).hintPassword,
//                           suffixIcon: IconButton(
//                             onPressed: () {
//                               setState(() {
//                                 showPassword = !showPassword;
//                               });
//                             },
//                             icon: Icon(
//                               showPassword ? FeatherIcons.eyeOff : FeatherIcons.eye,
//                               color: kGreyTextColor,
//                               size: 18,
//                             ),
//                           ),
//                         ),
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             // return 'Password can\'t be empty';
//                             return lang.S.of(context).passwordCannotBeEmpty;
//                           } else if (value.length < 6) {
//                             //return 'Please enter a bigger password';
//                             return lang.S.of(context).pleaseEnterABiggerPassword;
//                           }
//                           return null;
//                         },
//                       ),
//                       const SizedBox(height: 4.0),
//                       Row(
//                         children: [
//                           Checkbox(
//                             materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//                             checkColor: Colors.white,
//                             activeColor: kMainColor,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(3.0),
//                             ),
//                             fillColor: WidgetStateProperty.all(_isChecked ? kMainColor : Colors.transparent),
//                             visualDensity: const VisualDensity(horizontal: -4),
//                             side: const BorderSide(color: kGreyTextColor),
//                             value: _isChecked,
//                             onChanged: (newValue) {
//                               setState(() {
//                                 _isChecked = newValue!;
//                               });
//                             },
//                           ),
//                           const SizedBox(width: 8.0),
//                           Text(
//                             lang.S.of(context).rememberMe,
//                             //'Remember me',
//                             style: textTheme.bodyMedium?.copyWith(color: kGreyTextColor),
//                           ),
//                           // const Spacer(),
//                           // TextButton(
//                           //   style: ButtonStyle(
//                           //     shape: WidgetStateProperty.all(
//                           //       RoundedRectangleBorder(
//                           //         borderRadius: BorderRadius.circular(6.0),
//                           //       ),
//                           //     ),
//                           //   ),
//                           //   onPressed: () => Navigator.push(
//                           //     context,
//                           //     MaterialPageRoute(
//                           //       builder: (context) => const ForgotPassword(),
//                           //     ),
//                           //   ),
//                           //   child: Text(
//                           //     lang.S.of(context).forgotPassword,
//                           //     //'Forgot password?',
//                           //     style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold, fontSize: 14),
//                           //   ),
//                           // ),
//                         ],
//                       ),
//                       const SizedBox(height: 24.0),
//                       ElevatedButton(
//                         style: OutlinedButton.styleFrom(
//                           maximumSize: const Size(double.infinity, 48),
//                           minimumSize: const Size(double.infinity, 48),
//                           disabledBackgroundColor: _theme.colorScheme.primary.withValues(alpha: 0.15),
//                         ),
//                         onPressed: () async {
//                           if (isClicked) {
//                             return;
//                           }
//                           if (key.currentState?.validate() ?? false) {
//                             isClicked = true;
//                             EasyLoading.show();
//                             LogInRepo repo = LogInRepo();
//                             if (await repo.logIn(email: emailController.text, password: passwordController.text, context: context)) {
//                               _saveUserCredentials();
//                               EasyLoading.showSuccess('Done');
//                             } else {
//                               isClicked = false;
//                             }
//                           }
//                         },
//                         child: Text(
//                           lang.S.of(context).logIn,
//                           maxLines: 1,
//                           overflow: TextOverflow.ellipsis,
//                           style: _theme.textTheme.bodyMedium?.copyWith(
//                             color: _theme.colorScheme.primaryContainer,
//                             fontWeight: FontWeight.w600,
//                             fontSize: 16,
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 16),
//                       // Column(
//                       //   mainAxisSize: MainAxisSize.min,
//                       //   crossAxisAlignment: CrossAxisAlignment.center,
//                       //   mainAxisAlignment: MainAxisAlignment.center,
//                       //   children: [
//                       //     InkWell(
//                       //       highlightColor: kMainColor.withValues(alpha: 0.1),
//                       //       borderRadius: BorderRadius.circular(3.0),
//                       //       onTap: () {
//                       //         Navigator.push(context, MaterialPageRoute(
//                       //           builder: (context) {
//                       //             return const SignUpScreen();
//                       //           },
//                       //         ));
//                       //       },
//                       //       hoverColor: kMainColor.withValues(alpha: 0.1),
//                       //       child: RichText(
//                       //         text: TextSpan(
//                       //           text: lang.S.of(context).donNotHaveAnAccount,
//                       //           //'Don’t have an account? ',
//                       //           style: textTheme.bodyMedium?.copyWith(color: kGreyTextColor),
//                       //           children: [
//                       //             TextSpan(
//                       //               text: lang.S.of(context).signUp,
//                       //               // text:'Sign Up',
//                       //               style: textTheme.bodyMedium?.copyWith(color: kMainColor, fontWeight: FontWeight.bold),
//                       //             )
//                       //           ],
//                       //         ),
//                       //       ),
//                       //     ),
//                       //   ],
//                       // ),
//                       // socialNetworkProvider.when(data: (isEnable) {
//                       //   if (isEnable) {
//                       //     return Column(
//                       //       children: [
//                       //         SizedBox(height: 20),
//                       //         // Divider
//                       //         SizedBox(
//                       //           height: 28,
//                       //           child: Row(
//                       //             mainAxisAlignment: MainAxisAlignment.center,
//                       //             spacing: 6,
//                       //             children: [
//                       //               Expanded(child: Divider()),
//                       //               Text(
//                       //                 'Or Continue with',
//                       //                 style: _theme.textTheme.bodyLarge,
//                       //               ),
//                       //               Expanded(child: Divider()),
//                       //             ],
//                       //           ),
//                       //         ),
//                       //         const SizedBox.square(dimension: 30),
//                       //         // Social Login
//                       //         Row(
//                       //           spacing: 16,
//                       //           children: [
//                       //             // Facebook
//                       //             Expanded(
//                       //               child: OutlinedButton.icon(
//                       //                 onPressed: () {
//                       //                   Navigator.push(
//                       //                     context,
//                       //                     MaterialPageRoute(
//                       //                       builder: (context) => WebViewLogin(
//                       //                         loginUrl: "${APIConfig.domain}login/x?platform=app",
//                       //                       ),
//                       //                     ),
//                       //                   );
//                       //                 },
//                       //                 style: ElevatedButton.styleFrom(
//                       //                   padding: EdgeInsets.symmetric(horizontal: 8),
//                       //                   minimumSize: Size(double.infinity, 48),
//                       //                   side: const BorderSide(color: kBorder),
//                       //                   foregroundColor: _theme.colorScheme.onPrimaryContainer,
//                       //                 ),
//                       //                 label: Text(
//                       //                   'Login X',
//                       //                   style: _theme.textTheme.titleMedium?.copyWith(
//                       //                     fontWeight: FontWeight.w600,
//                       //                   ),
//                       //                 ),
//                       //                 icon: Container(
//                       //                   height: 26,
//                       //                   width: 26,
//                       //                   decoration: BoxDecoration(shape: BoxShape.circle, image: DecorationImage(fit: BoxFit.cover, image: AssetImage('images/x.png'))),
//                       //                 ),
//                       //               ),
//                       //             ),
//                       //
//                       //             // Google
//                       //             Expanded(
//                       //               child: OutlinedButton.icon(
//                       //                 onPressed: () {
//                       //                   Navigator.push(
//                       //                     context,
//                       //                     MaterialPageRoute(
//                       //                       builder: (context) => WebViewLogin(
//                       //                         loginUrl: "${APIConfig.domain}login/google?platform=app",
//                       //                       ),
//                       //                     ),
//                       //                   );
//                       //                 },
//                       //                 style: ElevatedButton.styleFrom(
//                       //                   padding: EdgeInsets.symmetric(
//                       //                     horizontal: 8,
//                       //                   ),
//                       //                   minimumSize: Size(double.infinity, 48),
//                       //                   side: const BorderSide(color: kBorder),
//                       //                   foregroundColor: _theme.colorScheme.onPrimaryContainer,
//                       //                 ),
//                       //                 label: Text(
//                       //                   'Login Google',
//                       //                   style: _theme.textTheme.titleMedium?.copyWith(
//                       //                     color: Colors.black,
//                       //                     fontWeight: FontWeight.w600,
//                       //                   ),
//                       //                 ),
//                       //                 icon: SvgPicture.asset(
//                       //                   'assets/google.svg',
//                       //                   width: 26,
//                       //                 ),
//                       //               ),
//                       //             ),
//                       //           ],
//                       //         ),
//                       //       ],
//                       //     );
//                       //   } else {
//                       //     return SizedBox.shrink();
//                       //   }
//                       // }, error: (e, stack) {
//                       //   return Center(
//                       //     child: Text(e.toString()),
//                       //   );
//                       // }, loading: () {
//                       //   return Center(
//                       //     child: Padding(
//                       //       padding: const EdgeInsets.all(20.0),
//                       //       child: CircularProgressIndicator(),
//                       //     ),
//                       //   );
//                       // }),
//                       OutlinedButton.icon(
//                         onPressed: () {
//                           // Navigator.push(
//                           //   context,
//                           //   MaterialPageRoute(
//                           //     builder: (context) => WebViewLogin(
//                           //       loginUrl: "${APIConfig.domain}login/google?platform=app",
//                           //     ),
//                           //   ),
//                           // );
//                           Navigator.pushReplacement(
//                             context,
//                             MaterialPageRoute(
//                               builder: (_) => const WebViewLogin(
//                                 loginUrl: "https://prime-partner.gpcagro.in/login",
//                               ),
//                             ),
//                           );
//
//                         },
//                         style: ElevatedButton.styleFrom(
//                           padding: EdgeInsets.symmetric(
//                             horizontal: 8,
//                           ),
//                           minimumSize: Size(double.infinity, 48),
//                           side: const BorderSide(color: kBorder),
//                           foregroundColor: _theme.colorScheme.onPrimaryContainer,
//                         ),
//                         label: Text(
//                           'Login on web',
//                           style: _theme.textTheme.titleMedium?.copyWith(
//                             color: Colors.black,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                         icon: SvgPicture.asset(
//                           'assets/google.svg',
//                           width: 26,
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }


import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobile_pos/GlobalComponents/glonal_popup.dart';
import 'package:mobile_pos/Screens/Authentication/Sign In/webview_login.dart';
import 'package:mobile_pos/generated/l10n.dart' as lang;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../GlobalComponents/button_global.dart';
import '../../../constant.dart';
import 'Repo/sign_in_repo.dart';
import 'package:sms_autofill/sms_autofill.dart';

// enum LoginType { email, phone }
//
// class SignIn extends StatefulWidget {
//   const SignIn({super.key});
//
//   @override
//   State<SignIn> createState() => _SignInState();
// }
//
// class _SignInState extends State<SignIn> {
//   bool showPassword = true;
//   bool _isChecked = false;
//   bool isClicked = false;
//
//   final key = GlobalKey<FormState>();
//
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();
//   final phoneController = TextEditingController();
//   final otpController = TextEditingController();
//   final FocusNode emailFocus = FocusNode();
//   final FocusNode phoneFocus = FocusNode();
//   final FocusNode otpFocus = FocusNode();
//
//   LoginType loginType = LoginType.phone;
//   bool otpSent = false;
//
//   Timer? _timer;
//   int _seconds = 0;
//
//   @override
//   void initState() {
//     super.initState();
//     _loadUserCredentials();
//   }
//
//   @override
//   void dispose() {
//     emailController.dispose();
//     passwordController.dispose();
//     phoneController.dispose();
//     otpController.dispose();
//     emailFocus.dispose();
//     phoneFocus.dispose();
//     otpFocus.dispose();
//     _timer?.cancel();
//     super.dispose();
//   }
//
//   void _startTimer() {
//     _timer?.cancel();
//     setState(() => _seconds = 30);
//     _timer = Timer.periodic(const Duration(seconds: 1), (t) {
//       if (_seconds == 0) {
//         t.cancel();
//       } else {
//         setState(() => _seconds--);
//       }
//     });
//   }
//
//   void _loadUserCredentials() async {
//     final prefs = await SharedPreferences.getInstance();
//     setState(() {
//       _isChecked = prefs.getBool('remember_me') ?? false;
//       if (_isChecked) {
//         emailController.text = prefs.getString('email') ?? '';
//         passwordController.text = prefs.getString('password') ?? '';
//       }
//     });
//   }
//
//   void _saveUserCredentials() async {
//     final prefs = await SharedPreferences.getInstance();
//     prefs.setBool('remember_me', _isChecked);
//     if (_isChecked) {
//       prefs.setString('email', emailController.text);
//       prefs.setString('password', passwordController.text);
//     } else {
//       prefs.remove('email');
//       prefs.remove('password');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//
//     return GlobalPopup(
//       child: Consumer(builder: (_, ref, __) {
//         return Scaffold(
//           backgroundColor: kWhite,
//           appBar: AppBar(
//             backgroundColor: kWhite,
//             surfaceTintColor: kWhite,
//             title: Text(lang.S.of(context).signIn),
//           ),
//           body: SingleChildScrollView(
//             padding: const EdgeInsets.all(16),
//             child: Form(
//               key: key,
//               child: Column(
//                 children: [
//                   const NameWithLogo(),
//                   const SizedBox(height: 24),
//
//                   /// TOGGLE
//                   Container(
//                     height: 48,
//                     decoration: BoxDecoration(
//                       color: kBorder,
//                       border: Border.all(color: kMainColor),
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: Row(
//                       children: [
//                         _tab(LoginType.phone, 'Phone'),
//                         _tab(LoginType.email, 'Email'),
//
//                       ],
//                     ),
//                   ),
//
//                   const SizedBox(height: 24),
//
//                   /// EMAIL LOGIN (UNCHANGED)
//                   if (loginType == LoginType.email) ...[
//                     TextFormField(
//                       controller: emailController,
//                       focusNode: emailFocus,
//                       decoration: InputDecoration(
//                         labelText: lang.S.of(context).lableEmail,
//                         hintText: lang.S.of(context).hintEmail,
//                       ),
//                       validator: (v) {
//                         if (v == null || v.isEmpty) {
//                           return lang.S.of(context).emailCannotBeEmpty;
//                         }
//                         if (!v.contains('@')) {
//                           return lang.S.of(context).pleaseEnterAValidEmail;
//                         }
//                         return null;
//                       },
//                     ),
//                     const SizedBox(height: 20),
//                     TextFormField(
//                       controller: passwordController,
//                       obscureText: showPassword,
//                       decoration: InputDecoration(
//                         labelText: lang.S.of(context).lablePassword,
//                         hintText: lang.S.of(context).hintPassword,
//                         suffixIcon: IconButton(
//                           icon: Icon(
//                             showPassword
//                                 ? FeatherIcons.eyeOff
//                                 : FeatherIcons.eye,
//                           ),
//                           onPressed: () =>
//                               setState(() => showPassword = !showPassword),
//                         ),
//                       ),
//                       validator: (v) {
//                         if (v == null || v.isEmpty) {
//                           return lang.S.of(context).passwordCannotBeEmpty;
//                         }
//                         if (v.length < 6) {
//                           return lang.S.of(context)
//                               .pleaseEnterABiggerPassword;
//                         }
//                         return null;
//                       },
//                     ),
//                   ],
//
//                   /// PHONE LOGIN
//                   if (loginType == LoginType.phone) ...[
//                     TextFormField(
//                       controller: phoneController,
//                       focusNode: phoneFocus,
//                       keyboardType: TextInputType.phone,
//                       maxLength: 10,
//                       inputFormatters: [
//                         FilteringTextInputFormatter.digitsOnly,
//                         LengthLimitingTextInputFormatter(10),
//                       ],
//                       decoration: InputDecoration(
//                         labelText: 'Phone',
//                         hintText: 'Enter phone number',
//                         counterText: '',
//                         suffixIcon: TextButton(
//                           onPressed: _seconds > 0
//                               ? null
//                               : () async {
//                             EasyLoading.show();
//                             final ok = await LogInRepo().sendOtp(
//                               phone: phoneController.text,
//                               context: context,
//                             );
//                             EasyLoading.dismiss();
//                             if (ok) {
//                               setState(() => otpSent = true);
//                               _startTimer();
//                             }
//                           },
//                           child: Text(
//                             _seconds > 0
//                                 ? '$_seconds s'
//                                 : (otpSent ? 'Resend' : 'Send OTP'),
//                           ),
//                         ),
//                       ),
//                       validator: (v) {
//                         if (v == null || v.isEmpty) {
//                           return 'Mobile number required';
//                         }
//                         if (v.length != 10) {
//                           return 'Enter phone number';
//                         }
//                         return null;
//                       },
//                     ),
//
//                     if (otpSent) ...[
//                       const SizedBox(height: 20),
//                       TextFormField(
//                         controller: otpController,
//                         focusNode: otpFocus,
//                         keyboardType: TextInputType.number,
//                         maxLength: 4,
//                         inputFormatters: [
//                           FilteringTextInputFormatter.digitsOnly,
//                           LengthLimitingTextInputFormatter(4),
//                         ],
//                         decoration: const InputDecoration(
//                           labelText: 'OTP',
//                           hintText: 'Enter 4 digit OTP',
//                           counterText: '',
//                         ),
//                         validator: (v) {
//                           if (v == null || v.isEmpty) {
//                             return 'OTP required';
//                           }
//                           if (v.length != 4) {
//                             return 'Enter valid 4 digit OTP';
//                           }
//                           return null;
//                         },
//                       ),
//
//                     ],
//                   ],
//
//                   const SizedBox(height: 24),
//
//                   /// LOGIN BUTTON
//                   ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       minimumSize: const Size(double.infinity, 48),
//                     ),
//                     onPressed: () async {
//                       if (isClicked) return;
//                       if (!(key.currentState?.validate() ?? false)) return;
//
//                       isClicked = true;
//                       EasyLoading.show();
//
//                       bool success = false;
//                       final repo = LogInRepo();
//
//                       if (loginType == LoginType.email) {
//                         success = await repo.logIn(
//                           email: emailController.text,
//                           password: passwordController.text,
//                           context: context,
//                         );
//                         if (success) {
//                           _saveUserCredentials();
//                         }
//                       } else {
//                         success = await repo.verifyOtp(
//                           phone: phoneController.text,
//                           otp: otpController.text,
//                           action: 'login',
//                           context: context,
//                         );
//                       }
//
//                       // ✅ IMPORTANT FIX
//                       EasyLoading.dismiss();
//
//                       if (!success) {
//                         setState(() {
//                           isClicked = false;
//                         });
//                       }
//                     },
//                     child: Text(
//                       lang.S.of(context).logIn,
//                       style: theme.textTheme.bodyLarge
//                           ?.copyWith(fontWeight: FontWeight.w600),
//                     ),
//                   ),
//
//                   const SizedBox(height: 16),
//                   // Column(
//                   //   mainAxisSize: MainAxisSize.min,
//                   //   crossAxisAlignment: CrossAxisAlignment.center,
//                   //   mainAxisAlignment: MainAxisAlignment.center,
//                   //   children: [
//                   //     InkWell(
//                   //       highlightColor: kMainColor.withValues(alpha: 0.1),
//                   //       borderRadius: BorderRadius.circular(3.0),
//                   //       onTap: () {
//                   //         Navigator.push(context, MaterialPageRoute(
//                   //           builder: (context) {
//                   //             return const SignUpScreen();
//                   //           },
//                   //         ));
//                   //       },
//                   //       hoverColor: kMainColor.withValues(alpha: 0.1),
//                   //       child: RichText(
//                   //         text: TextSpan(
//                   //           text: lang.S.of(context).donNotHaveAnAccount,
//                   //           //'Don’t have an account? ',
//                   //           style: theme.textTheme.bodyMedium?.copyWith(color: kGreyTextColor),
//                   //           children: [
//                   //             TextSpan(
//                   //               text: lang.S.of(context).signUp,
//                   //               // text:'Sign Up',
//                   //               style: theme.textTheme.bodyMedium?.copyWith(color: kMainColor, fontWeight: FontWeight.bold),
//                   //             )
//                   //           ],
//                   //         ),
//                   //       ),
//                   //     ),
//                   //   ],
//                   // ),
//
//                   /// WEB LOGIN (UNCHANGED)
//                   OutlinedButton.icon(
//                     onPressed: () {
//                       Navigator.pushReplacement(
//                         context,
//                         MaterialPageRoute(
//                           builder: (_) => const WebViewLogin(
//                             loginUrl:
//                             'https://prime-partner.gpcagro.in/login',
//                           ),
//                         ),
//                       );
//                     },
//                     icon: SvgPicture.asset('assets/google.svg', width: 26),
//                     label: const Text('Login on web'),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       }),
//     );
//   }
//
//   Widget _tab(LoginType type, String text) {
//     final selected = loginType == type;
//     return Expanded(
//       child: GestureDetector(
//         onTap: () {
//           FocusScope.of(context).unfocus();
//           setState(() {
//             loginType = type;
//             otpSent = false;
//             _seconds = 0;
//             _timer?.cancel();
//           });
//           Future.delayed(const Duration(milliseconds: 120), () {
//             if (type == LoginType.phone) {
//               FocusScope.of(context).requestFocus(phoneFocus);
//             } else {
//               FocusScope.of(context).requestFocus(emailFocus);
//             }
//           });
//         },
//         child: Container(
//           alignment: Alignment.center,
//           decoration: BoxDecoration(
//             color: selected ? kWhite : Colors.transparent,
//             borderRadius: BorderRadius.circular(8),
//           ),
//           child: Text(
//             text,
//             style: TextStyle(
//               fontWeight: FontWeight.w600,
//               color: selected ? kMainColor : kMainColor50,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }




enum LoginType { email, phone }

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

/// 🔥 CodeAutoFill mixin for Android OTP auto read
class _SignInState extends State<SignIn> with CodeAutoFill {
  bool showPassword = true;
  bool _isChecked = false;
  bool isClicked = false;

  final key = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  final otpController = TextEditingController();

  final FocusNode emailFocus = FocusNode();
  final FocusNode phoneFocus = FocusNode();
  final FocusNode otpFocus = FocusNode();

  LoginType loginType = LoginType.phone;
  bool otpSent = false;

  Timer? _timer;
  int _seconds = 0;

  @override
  void initState() {
    super.initState();
    _loadUserCredentials();
    listenForCode();
  }

  @override
  void dispose() {
    cancel(); // stop SMS listener
    emailController.dispose();
    passwordController.dispose();
    phoneController.dispose();
    otpController.dispose();
    emailFocus.dispose();
    phoneFocus.dispose();
    otpFocus.dispose();
    _timer?.cancel();
    super.dispose();
  }

  // ================= TIMER =================
  void _startTimer() {
    _timer?.cancel();
    setState(() => _seconds = 30);
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (_seconds == 0) {
        t.cancel();
      } else {
        setState(() => _seconds--);
      }
    });
  }

  // ================= REMEMBER ME =================
  void _loadUserCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isChecked = prefs.getBool('remember_me') ?? false;
      if (_isChecked) {
        emailController.text = prefs.getString('email') ?? '';
        passwordController.text = prefs.getString('password') ?? '';
      }
    });
  }

  void _saveUserCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('remember_me', _isChecked);
    if (_isChecked) {
      prefs.setString('email', emailController.text);
      prefs.setString('password', passwordController.text);
    } else {
      prefs.remove('email');
      prefs.remove('password');
    }
  }

  // ================= ANDROID OTP AUTO =================
  @override
  void codeUpdated() {
    if (code == null) return;
    final otp = code!.replaceAll(RegExp(r'[^0-9]'), '');
    if (otp.length == 4) {
      _verifyOtpAuto(otp);
    }
  }

  // ================= COMMON AUTO VERIFY =================
  Future<void> _verifyOtpAuto(String otp) async {
    otpController.text = otp;
    FocusScope.of(context).unfocus();

    if (isClicked) return;
    isClicked = true;

    EasyLoading.show();
    final success = await LogInRepo().verifyOtp(
      phone: phoneController.text,
      otp: otp,
      action: 'login',
      context: context,
    );
    EasyLoading.dismiss();

    if (!success) {
      setState(() => isClicked = false);
    }
  }

  // ================= UI =================
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GlobalPopup(
      child: Consumer(builder: (_, ref, __) {
        return Scaffold(
          backgroundColor: kWhite,
          appBar: AppBar(
            backgroundColor: kWhite,
            surfaceTintColor: kWhite,
            title: Text(lang.S.of(context).signIn),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: key,
              child: Column(
                children: [
                  const NameWithLogo(),
                  const SizedBox(height: 24),

                  // ========== TOGGLE ==========
                  Container(
                    height: 48,
                    decoration: BoxDecoration(
                      color: kBorder,
                      border: Border.all(color: kMainColor),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        _tab(LoginType.phone, 'Phone'),
                        _tab(LoginType.email, 'Email'),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // ========== EMAIL LOGIN ==========
                  if (loginType == LoginType.email) ...[
                    TextFormField(
                      controller: emailController,
                      focusNode: emailFocus,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: lang.S.of(context).lableEmail,
                        hintText: lang.S.of(context).hintEmail,
                      ),
                      validator: (v) {
                        if (v == null || v.isEmpty) {
                          return lang.S.of(context).emailCannotBeEmpty;
                        }
                        if (!v.contains('@')) {
                          return lang.S.of(context).pleaseEnterAValidEmail;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: passwordController,
                      obscureText: showPassword,
                      decoration: InputDecoration(
                        labelText: lang.S.of(context).lablePassword,
                        hintText: lang.S.of(context).hintPassword,
                        suffixIcon: IconButton(
                          icon: Icon(
                            showPassword
                                ? FeatherIcons.eyeOff
                                : FeatherIcons.eye,
                          ),
                          onPressed: () =>
                              setState(() => showPassword = !showPassword),
                        ),
                      ),
                      validator: (v) {
                        if (v == null || v.isEmpty) {
                          return lang.S.of(context).passwordCannotBeEmpty;
                        }
                        if (v.length < 6) {
                          return lang.S.of(context)
                              .pleaseEnterABiggerPassword;
                        }
                        return null;
                      },
                    ),
                  ],

                  // ========== PHONE LOGIN ==========
                  if (loginType == LoginType.phone) ...[
                    TextFormField(
                      controller: phoneController,
                      focusNode: phoneFocus,
                      keyboardType: TextInputType.phone,
                      maxLength: 10,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(10),
                      ],
                      decoration: InputDecoration(
                        labelText: 'Phone',
                        hintText: 'Enter phone number',
                        counterText: '',
                        suffixIcon: TextButton(
                          onPressed: _seconds > 0
                              ? null
                              : () async {
                            EasyLoading.show();
                            final ok = await LogInRepo().sendOtp(
                              phone: phoneController.text,
                              context: context,
                            );
                            EasyLoading.dismiss();
                            if (ok) {
                              setState(() => otpSent = true);
                              _startTimer();
                              FocusScope.of(context)
                                  .requestFocus(otpFocus);
                            }
                          },
                          child: Text(
                            _seconds > 0
                                ? '$_seconds s'
                                : (otpSent ? 'Resend' : 'Send OTP'),
                          ),
                        ),
                      ),
                      validator: (v) {
                        if (v == null || v.length != 10) {
                          return 'Enter valid 10 digit number';
                        }
                        return null;
                      },
                    ),

                    if (otpSent) ...[
                      const SizedBox(height: 20),

                      /// 🔥 ONE FIELD – Android auto + iOS autofill
                      TextFormField(
                        controller: otpController,
                        focusNode: otpFocus,
                        keyboardType: TextInputType.number,
                        maxLength: 4,
                        autofillHints: const [
                          AutofillHints.oneTimeCode
                        ], // iOS key
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(4),
                        ],
                        decoration: const InputDecoration(
                          labelText: 'OTP',
                          hintText: 'Enter 4 digit OTP',
                          counterText: '',
                        ),
                        onChanged: (value) {
                          if (value.length == 4) {
                            _verifyOtpAuto(value);
                          }
                        },
                        validator: (v) {
                          if (v == null || v.length != 4) {
                            return 'Enter valid OTP';
                          }
                          return null;
                        },
                      ),
                    ],
                  ],

                  const SizedBox(height: 24),

                  // ========== LOGIN BUTTON ==========
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 48),
                    ),
                    onPressed: () async {
                      if (isClicked) return;
                      if (!(key.currentState?.validate() ?? false)) return;

                      isClicked = true;
                      EasyLoading.show();

                      bool success = false;
                      final repo = LogInRepo();

                      if (loginType == LoginType.email) {
                        success = await repo.logIn(
                          email: emailController.text,
                          password: passwordController.text,
                          context: context,
                        );
                        if (success) _saveUserCredentials();
                      } else {
                        success = await repo.verifyOtp(
                          phone: phoneController.text,
                          otp: otpController.text,
                          action: 'login',
                          context: context,
                        );
                      }

                      EasyLoading.dismiss();

                      if (!success) {
                        setState(() => isClicked = false);
                      }
                    },
                    child: Text(
                      lang.S.of(context).logIn,
                      style: theme.textTheme.bodyLarge
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // ========== WEB LOGIN ==========
                  OutlinedButton.icon(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const WebViewLogin(
                            loginUrl:
                            'https://prime-partner.gpcagro.in/login',
                          ),
                        ),
                      );
                    },
                    icon: SvgPicture.asset('assets/google.svg', width: 26),
                    label: const Text('Login on web'),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  // ================= TOGGLE TAB =================
  Widget _tab(LoginType type, String text) {
    final selected = loginType == type;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
          setState(() {
            loginType = type;
            otpSent = false;
            _seconds = 0;
            _timer?.cancel();
          });
          Future.delayed(const Duration(milliseconds: 120), () {
            if (type == LoginType.phone) {
              FocusScope.of(context).requestFocus(phoneFocus);
            } else {
              FocusScope.of(context).requestFocus(emailFocus);
            }
          });
        },
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: selected ? kWhite : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: selected ? kMainColor : kMainColor50,
            ),
          ),
        ),
      ),
    );
  }
}
