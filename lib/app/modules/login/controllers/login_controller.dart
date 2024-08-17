import 'package:crud_app/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  var isLoading = false.obs;
  var obscureText = true.obs;

  Future<void> login(String email, String password) async {
    isLoading.value = true;
    final prefs = await SharedPreferences.getInstance();
    final storedEmail = prefs.getString('email');
    final storedPassword = prefs.getString('password');
    isLoading.value = false;
    if (email.isEmpty) {
      Get.snackbar('Error', 'Email is required');
      return;
    }
    if (!_isValidEmail(email)) {
      Get.snackbar('Error', 'Invalid email format');
      return;
    }
    if (password.isEmpty) {
      Get.snackbar('Error', 'Password is required');
      return;
    }

    if (email == storedEmail && password == storedPassword) {
      Get.offAllNamed(Routes.HOME);
    } else {
      Get.snackbar('Login Failed', 'Invalid email or password');
    }
  }

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(
      r'^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9\-]+\.)+[a-zA-Z]{2,6}$',
    );
    return emailRegex.hasMatch(email);
  }
}
