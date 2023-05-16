import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

Padding cryptoIcon(IconData icon, ThemeData themeData) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 0.5.w),
    child: Container(
      decoration: BoxDecoration(
        // ignore: deprecated_member_use
        color: themeData.backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(
          icon,
          size: 15.sp,
        ),
      ),
    ),
  );
}
