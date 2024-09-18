import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showCustomDialog({
  required String title,
  required String message,
  required VoidCallback onConfirm,
  String confirmText = 'Confirmar',
  String cancelText = 'Cancelar',
  bool showCancelButton = true,
}) {
  Get.dialog(
    AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: <Widget>[
        if (showCancelButton)
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text(cancelText),
          ),
        TextButton(
          onPressed: onConfirm,
          child: Text(confirmText),
        ),
      ],
    ),
    barrierDismissible: false, // O usuário precisa interagir com os botões para fechar
  );
}
