import 'package:flutter/material.dart';

void confirmDialog({
  required BuildContext context,
  required Function action,
  required String titleText,
  required String contentText,
  required String notConfirmButtonText,
  required String confirmButtonText,
}) async {
  final shouldContinue = await showDialog<bool>(
    context: context,
    builder: (dialogContext) {
      return AlertDialog(
        title: Text(titleText),
        content: Text(contentText),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: Text(notConfirmButtonText),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: Text(confirmButtonText),
          ),
        ],
      );
    },
  );

  if (shouldContinue != true) return;
  if (context.mounted) {
    action();
  }
}
