import 'package:cipra/auth/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';

final authPro = ChangeNotifierProvider(
  (ref) {
    return AuthProvider();
  },
);

class AuthProvider with ChangeNotifier {
  var http = Client();

  Future<bool> login(
      BuildContext context, String email, String password) async {
    try {
      final url = Uri.parse('https://api.cipra.ai:5000/takehome/signin')
          .replace(queryParameters: {'email': email, 'password': password});

      final response = await http.get(url);

      if (response.statusCode == 200) {
        print("object");
        return true;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Invalid credentials')),
        );
        return false;
      }
    } catch (e) {
      print(e.toString());

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $e')),
      );
      return false;
    }
  }
}
