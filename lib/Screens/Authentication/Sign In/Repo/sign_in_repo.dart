import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import '../../../../Const/api_config.dart';
import '../../../../Repository/constant_functions.dart';
import '../../../../currency.dart';
import '../../../Home/home.dart';
import '../../Sign Up/verify_email.dart';
import '../../profile_setup_screen.dart';

class LogInRepo {
  Future<bool> logIn({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    final url = Uri.parse('${APIConfig.url}/sign-in');

    final body = {
      'email': email,
      'password': password,
    };
    final headers = {
      'Accept': 'application/json',
    };

    try {
      final response = await http.post(url, headers: headers, body: body);

      final responseData = jsonDecode(response.body);
      EasyLoading.dismiss();
      print('Signin ${response.statusCode}');
      print('Signin ${response.body}');
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(responseData['message'])));

        bool isSetupDone = responseData['data']['is_setup'];
        await saveUserData(
          token: responseData['data']['token'],
        );
        try {
          await CurrencyMethods()
              .saveCurrencyDataInLocalDatabase(selectedCurrencySymbol: responseData['data']['currency']['symbol'], selectedCurrencyName: responseData['data']['currency']['name']);
        } catch (error) {
          print(error);
        }
        if (!isSetupDone) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ProfileSetup()));
        } else {
          await saveUserData(
            token: responseData['data']['token'],
          );
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Home()));
        }

        return true;
      } else if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(responseData['message'])));
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VerifyEmail(
              email: email,
              isFormForgotPass: false,
            ),
          ),
        );

        return true;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(responseData['message'])));
      }
    } catch (error) {
      print(error);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $error')));
      // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Network error: Please try again')));
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Network error: Please try again')));
    }

    return false;
  }

  /// =========================
  /// SEND OTP (PHONE LOGIN)
  /// =========================
  Future<bool> sendOtp({
    required String phone,
    required BuildContext context,
  }) async {
    try {
      final url = Uri.parse('${APIConfig.url}/send-otp');

      print('➡️ SEND OTP URL: $url');
      print('➡️ SEND OTP BODY: ${jsonEncode({'phone': phone})}');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'phone': phone,
        }),
      );
      print('⬅️ SEND OTP STATUS: ${response.statusCode}');
      print('⬅️ SEND OTP RESPONSE: ${response.body}');
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e,stack) {
      print('❌ SEND OTP ERROR: $e');
      print('❌ STACK TRACE: $stack');
      return false;
    }
  }

  /// =========================
  /// VERIFY OTP (PHONE LOGIN)
  /// =========================
  Future<bool> verifyOtp({
    required String phone,
    required String otp,
    required String action,
    required BuildContext context,
  }) async {
    try {
      final url = Uri.parse('${APIConfig.url}/verify-otp');

      print('➡️ VERIFY OTP URL: $url');
      print('➡️ VERIFY OTP BODY: ${jsonEncode({'phone': phone, 'otp': otp,'action': action,
        'platform': Platform.isAndroid?'android':'ios',})}');

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'phone': phone,
          'otp': otp,
          'action': action,
          'platform': Platform.isAndroid?'android':'ios',
        }),
      );

      print('⬅️ VERIFY OTP STATUS: ${response.statusCode}');
      print('⬅️ VERIFY OTP RESPONSE: ${response.body}');

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(responseData['message'])),
        );

        final data = responseData['data'];
        final bool isSetupDone = data['is_setup'];

        try {
          await CurrencyMethods().saveCurrencyDataInLocalDatabase(
            selectedCurrencySymbol: data['currency']['symbol'],
            selectedCurrencyName: data['currency']['name'],
          );
        } catch (e) {
          print('Currency save error: $e');
        }

        await saveUserData(token: data['token']);

        if (!isSetupDone) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => const ProfileSetup(),
            ),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => const Home(),
            ),
          );
        }

        return true;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(responseData['message'] ?? 'OTP failed')),
        );
        return false;
      }
    } catch (e, stack) {
      print('❌ VERIFY OTP ERROR: $e');
      print('❌ STACK TRACE: $stack');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please try again')),
      );
      return false;
    }
  }

}



// class LogInRepo {
//   Future<bool> logIn({
//     required String email,
//     required String password,
//     required BuildContext context,
//   }) async {
//     final url = Uri.parse('${APIConfig.url}/sign-in');
//
//     final body = {
//       'email': email,
//       'password': password,
//     };
//     final headers = {
//       'Accept': 'application/json',
//     };
//
//     try {
//       final response = await http.post(url, headers: headers, body: body);
//
//       final responseData = jsonDecode(response.body);
//       EasyLoading.dismiss();
//       print('Signin ${response.statusCode}');
//       print('Signin ${response.body}');
//
//       if (response.statusCode == 200) {
//         ScaffoldMessenger.of(context)
//             .showSnackBar(SnackBar(content: Text(responseData['message'])));
//
//         bool isSetupDone = responseData['data']['is_setup'];
//
//         try {
//           await CurrencyMethods().saveCurrencyDataInLocalDatabase(
//             selectedCurrencySymbol:
//             responseData['data']['currency']['symbol'],
//             selectedCurrencyName:
//             responseData['data']['currency']['name'],
//           );
//         } catch (error) {
//           print(error);
//         }
//
//         if (!isSetupDone) {
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(
//               builder: (context) => const ProfileSetup(),
//             ),
//           );
//         } else {
//           await saveUserData(
//             token: responseData['data']['token'],
//           );
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(
//               builder: (context) => const Home(),
//             ),
//           );
//         }
//
//         return true;
//       } else if (response.statusCode == 201) {
//         ScaffoldMessenger.of(context)
//             .showSnackBar(SnackBar(content: Text(responseData['message'])));
//
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => VerifyEmail(
//               email: email,
//               isFormForgotPass: false,
//             ),
//           ),
//         );
//
//         return true;
//       } else {
//         ScaffoldMessenger.of(context)
//             .showSnackBar(SnackBar(content: Text(responseData['message'])));
//       }
//     } catch (error) {
//       print(error);
//       ScaffoldMessenger.of(context)
//           .showSnackBar(SnackBar(content: Text('Error: $error')));
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Network error: Please try again')),
//       );
//     }
//
//     return false;
//   }
//
//   /// =========================
//   /// SEND OTP (PHONE LOGIN)
//   /// =========================
//   Future<bool> sendOtp({
//     required String phone,
//     required BuildContext context,
//   }) async {
//     try {
//       final response = await http.post(
//         Uri.parse('${APIConfig.url}/send-otp'),
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode({
//           'phone': phone,
//         }),
//       );
//
//       final data = jsonDecode(response.body);
//
//       if (response.statusCode == 200) {
//         return true;
//       } else {
//         return false;
//       }
//     } catch (e) {
//       return false;
//     }
//   }
//
//   /// =========================
//   /// VERIFY OTP (PHONE LOGIN)
//   /// =========================
//   Future<bool> verifyOtp({
//     required String phone,
//     required String otp,
//     required BuildContext context,
//   }) async {
//     try {
//       final response = await http.post(
//         Uri.parse('${APIConfig.url}/verify-otp'),
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode({
//           'phone': phone,
//           'otp': otp,
//         }),
//       );
//
//       final data = jsonDecode(response.body);
//
//       if (response.statusCode == 200) {
//         return true;
//       } else {
//         return false;
//       }
//     } catch (e) {
//       return false;
//     }
//   }
// }
