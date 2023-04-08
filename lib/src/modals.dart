import 'package:flutter/material.dart';


class SCBottomBarDetails {
  Color? backgroundColor;
  double? elevation;
  List<Color>? circleColors;
  IconThemeData? activeIconTheme;
  IconThemeData? iconTheme;
  TextStyle? activeTitleStyle;
  TextStyle? titleStyle;
  List<SCBottomBarItem?> items;
  List<SCItem> circleItems;
  SCActionButtonDetails actionButtonDetails;
  double? bnbHeight;
  List<BoxShadow>? shadow;
  Border? border;
  Color? planColor;

  SCBottomBarDetails({
    required this.items,
    required this.circleItems,
    this.bnbHeight,
    this.planColor,
    required this.actionButtonDetails,
    this.activeIconTheme,
    this.iconTheme,
    this.activeTitleStyle,
    this.titleStyle,
    this.circleColors,
    this.shadow,
    this.border,
    this.backgroundColor,
    this.elevation
  });
}

class SCActionButtonDetails{

  Widget activeWidget;
  Widget closeWidget;
  double? width;
  double? height;
  EdgeInsets? padding;
  EdgeInsets? textPadding;
  EdgeInsets? margin;
  BorderRadius? borderRadius;
  Border? border;
  List<BoxShadow>? boxShadow;
  String? actionButtonText;
  Color? backgorundColor;

  SCActionButtonDetails({
    required this.activeWidget,
    required this.closeWidget,
    this.width,
    this.height,
    this.actionButtonText,
    this.padding,
    this.textPadding,
    this.margin,
    this.borderRadius,
    this.backgorundColor,
    this.border,
    this.boxShadow
  });
}

class SCItem {
  Widget icon;
  void Function() onPressed;

  SCItem({
    required this.icon,
    required this.onPressed
  });
}

class SCBottomBarItem {
  IconData? activeIcon;
  IconData? icon;
  String? title;
  String? svgPicture;
  String? activeSvgPicture;
  double? width;
  double? height;
  BoxFit? boxFit;
  Function onPressed;

  SCBottomBarItem({
    this.activeIcon,
    this.icon,
    this.svgPicture,
    this.activeSvgPicture,
    this.width,
    this.height,
    this.title,
    this.boxFit,
    required this.onPressed
  });
}
