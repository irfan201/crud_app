import 'package:crud_app/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterController extends GetxController {
  var isLoading = false.obs;
  var obscureText = true.obs;

  Future<void> register(String username, String email, String password) async {
    if (!_isValidEmail(email)) {
      Get.snackbar('Error', 'Invalid email format');
      return;
    }
    if (username.isEmpty) {
      Get.snackbar('Error', 'Username is required');
      return ;
    }
    if (email.isEmpty) {
      Get.snackbar('Error', 'Email is required');
      return ;
    }
    if (password.isEmpty) {
      Get.snackbar('Error', 'Password is required');
      return ;
    }

    try {
      isLoading.value = true;
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('username', username);
      await prefs.setString('email', email);
      await prefs.setString('password', password);
      isLoading.value = false;

      Get.offAllNamed(Routes.HOME);
      Get.snackbar(
          'Registration Success', 'You can now log in with your credentials');
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Error', 'Failed to register. Please try again.');
    }
  }

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(
      r'^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9\-]+\.)+[a-zA-Z]{2,6}$',
    );
    return emailRegex.hasMatch(email);
  }
}
