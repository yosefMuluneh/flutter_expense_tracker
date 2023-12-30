import 'dart:async';
import 'dart:convert';
import 'package:expense_tracker/user_dto.dart';
import 'package:expense_tracker/utils.dart';
import 'package:http/http.dart' as http;

class Fetcher {
  Future<User> signUpUser({
    required String username,
    required String password,
  }) async {
    try {
      http.Response response = await http.post(
        Uri.parse("$uri/auth/signup"),
        body: jsonEncode(
          {
            'username': username,
            'password': password,
          },
        ),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
      );

      if (response.statusCode == 200) {
        User user = User.fromJson(jsonDecode(response.body));
        User.save(user);
        return user;
      } else {
        return User.empty;
      }
    } catch (e) {
      throw Exception("Something went wrong");
    }
  }

  Future<User> signInUser({
    required String username,
    required String password,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/auth/signin'),
        body: jsonEncode({
          'username': username,
          'password': password,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
      );

      if (res.statusCode == 200) {
        User user = User.fromJson(jsonDecode(res.body));
        User.save(user);
        return user;
      } else {
        throw Exception(jsonDecode(res.body)['error']);
      }
    } catch (e) {
      throw Exception('$e');
    }
  }

//   Future<bool> forgetPassword(
//       phoenNumber, question, answer, newPassword) async {
//     try {
//       http.Response res = await http.put(
//         Uri.parse('$uri/auth/forgetpassword'),
//         body: jsonEncode({
//           'phoneNumber': phoenNumber,
//           'question': question,
//           'answer': answer,
//           'newPassword': newPassword,
//           'reqUrl': "forget"
//         }),
//         headers: <String, String>{
//           'Content-Type': 'application/json; charset=UTF-8'
//         },
//       );

//       if (res.statusCode == 200) {
//         return true;
//       } else {
//         throw Exception(jsonDecode(res.body)['error']);
//       }
//     } catch (e) {
//       rethrow;
//     }
//   }

  Future<bool> changePassword({
    required String oldPassword,
    required String newPassword,
    required int id,
  }) async {
    try {
      http.Response res = await http.put(
        Uri.parse('$uri/auth/changepassword/$id'),
        body: jsonEncode({
          'oldPassword': oldPassword,
          'newPassword': newPassword,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      print("======iii==========${res.statusCode}");

      if (res.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (err) {
      rethrow;
    }
  }

//   // phone number validation
//   Future<bool> phoneValidate({
//     required String phoneNumber,
//   }) async {
//     try {
//       http.Response res = await http.post(
//         Uri.parse('$uri/auth/signupInputValidate'),
//         body: jsonEncode({
//           'phoneNumber': phoneNumber,
//         }),
//         headers: <String, String>{
//           'Content-Type': 'application/json; charset=UTF-8'
//         },
//       );
//       if (res.statusCode == 200) {
//         return true;
//       } else {
//         throw Exception(jsonDecode(res.body)['error']);
//       }
//     } catch (e) {
//       // ignore: avoid_print
//       print(e);
//     }
//     return false;
//   }

//   Future<User> editProfile(attribute, value, token) async {
//     try {
//       http.Response response = await http.put(
//         Uri.parse('$uri/profile/update'),
//         body: jsonEncode({"attribute": attribute, "value": value}),
//         headers: <String, String>{
//           'Content-Type': 'application/json; charset=UTF-8',
//           'auth-token': token
//         },
//       );

//       if (response.statusCode == 200) {
//         User user = User.fromJson(response.body);
//         return user;
//       } else {
//         throw Exception(jsonDecode(response.body)['error']);
//       }
//     } catch (err) {
//       rethrow;
//     }
//   }

  Future<bool> deleteProfile(id) async {
    try {
      http.Response response = await http.delete(
        Uri.parse('$uri/auth/deleteaccount/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 204) {
        return true;
      } else {
        return false;
      }
    } catch (err) {
      rethrow;
    }
  }
}
