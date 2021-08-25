import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SlidingAppBar extends PreferredSize {
  SlidingAppBar({
    required this.child,
    required this.controller,
    required this.visible,
  }):super(child: child,preferredSize: child.preferredSize);

  @override
  final PreferredSizeWidget child;

  @override
  Size get preferredSize => child.preferredSize;

  final AnimationController controller;
  final bool visible;

  @override
  Widget build(BuildContext context) {

    if(!visible) SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]) ;
    else SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);

    visible ? controller.reverse() : controller.forward();
    return SlideTransition(
      position: Tween<Offset>(begin: Offset.zero, end: Offset(0, -1)).animate(
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn),
      ),
      child: child,
    );
  }
}