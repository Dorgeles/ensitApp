import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';

import 'custom-loading.dialog.dart';

ProgressDialog showprogressDialog(BuildContext context,
    {double dotRaduis, double raduis}) {
  final progressDialog =
      ProgressDialog(context, type: ProgressDialogType.Normal);
  progressDialog.style(
      message: "    Chargement",
      child: ColorLoader3(dotRadius: dotRaduis, radius: raduis));
  return progressDialog;
}
