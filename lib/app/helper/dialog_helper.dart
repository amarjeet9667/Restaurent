import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DialogHelper {
  static BuildContext? _context;

  static void setContext(BuildContext? context) {
    _context = context;
  }

  static BuildContext get _currentContext {
    assert(_context != null,
        'Context has not been set. Call setContext() before using DialogHelper methods.');
    return _context!;
  }

  //show error dialog
  static void showErrorDialog(
      {String title = 'Error', String? description = 'Something went wrong'}) {
    showDialog(
      context: _currentContext,
      builder: (context) => Dialog(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(
                description ?? '',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Okay'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //show toast
  static void showFlutterToast({required String strMsg}) async {
    await Fluttertoast.showToast(msg: strMsg);
  }

  //show snack bar
  static void showSnackBar({
    required BuildContext context,
    String title = "Alert!",
    required String strMsg,
  }) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final scaffoldMessenger = ScaffoldMessenger.maybeOf(context);
      scaffoldMessenger?.showSnackBar(
        SnackBar(
          content: Text(strMsg),
        ),
      );
    });
  }

  //show loading
  static void showLoading([String? message]) {
    showDialog(
      context: _currentContext,
      barrierDismissible: false,
      builder: (context) => Dialog(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 8),
              Text(message ?? 'Loading...'),
            ],
          ),
        ),
      ),
    );
  }

  //hide loading
  static void hideLoading() {
    Navigator.of(_currentContext).pop();
  }

  //hide keyboard
  static void hideKeyboard() {
    FocusScope.of(_currentContext).unfocus();
  }
}
