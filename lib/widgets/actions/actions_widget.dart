import 'package:bolo_wallet/widgets/actions/action_widget.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:unicons/unicons.dart';

Padding actionsWidget(
    Function() forceRefresh, ThemeData themeData, BuildContext context) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 2.5.h),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        actionWidget(
            UniconsLine.download_alt, 'Send', forceRefresh, themeData, context),
        actionWidget(UniconsLine.money_bill, 'Receive', forceRefresh, themeData,
            context),
        actionWidget(
            UniconsLine.upload_alt, 'Swap', forceRefresh, themeData, context),
      ],
    ),
  );
}
