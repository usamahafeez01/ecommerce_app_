import 'package:ecommerce_app/utlis/App%20Colors/app_colors.dart';
// ignore: depend_on_referenced_packages
import 'package:fluttertoast/fluttertoast.dart';

class CustomToast {
  static void showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: AppColors.redColor,
        textColor: AppColors.pwhiteColor,
        fontSize: 16.0);
  }
}
