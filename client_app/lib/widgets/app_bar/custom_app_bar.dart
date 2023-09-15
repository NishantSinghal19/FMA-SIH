import 'package:flutter/material.dart';
import 'package:client_app/core/app_export.dart';

// ignore: must_be_immutable
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppBar(
      {required this.height,
      this.leadingWidth,
      this.leading,
      this.title,
      this.centerTitle,
      this.actions});

  double height;

  double? leadingWidth;

  Widget? leading;

  Widget? title;

  bool? centerTitle;

  List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      toolbarHeight: height,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      leadingWidth: leadingWidth ?? 0,
      leading: leading,
      title: title,
      titleSpacing: 0,
      centerTitle: centerTitle ?? false,
      actions: actions,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(4),
        child: Container(
            margin: EdgeInsets.only(top: 5),
            color: Colors.orange,
            height: 2.5,
        ),
      )
    );
  }

  @override
  Size get preferredSize => Size(
        size.width,
        height,
      );
}
