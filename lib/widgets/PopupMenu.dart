import 'package:flutter/material.dart';

class TooltipShape extends ShapeBorder {
  const TooltipShape();

  final BorderSide _side = BorderSide.none;
  final BorderRadiusGeometry _borderRadius = BorderRadius.zero;

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.all(_side.width);

  @override
  Path getInnerPath(
    Rect rect, {
    TextDirection? textDirection,
  }) {
    final Path path = Path();

    path.addRRect(
      _borderRadius.resolve(textDirection).toRRect(rect).deflate(_side.width),
    );

    return path;
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    final Path path = Path();
    final RRect rrect = _borderRadius.resolve(textDirection).toRRect(rect);

    path.moveTo(0, 10);
    path.quadraticBezierTo(0, 0, 10, 0);

    path.lineTo(rrect.width - 10, 0);
    path.quadraticBezierTo(rrect.width, 0, rrect.width, 10);
    path.lineTo(rrect.width, rrect.height - 10);
    path.quadraticBezierTo(
        rrect.width, rrect.height, rrect.width - 10, rrect.height);
    path.lineTo(10, rrect.height);
    path.quadraticBezierTo(0, rrect.height, 0, rrect.height - 1);

    path.moveTo(rrect.width/2, rrect.height +30);
    path.lineTo(0, rrect.height - 10);
    path.lineTo(rrect.width, rrect.height -10);
    return path;
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}

  @override
  ShapeBorder scale(double t) => RoundedRectangleBorder(
        side: _side.scale(t),
        borderRadius: _borderRadius * t,
      );
}

class PopupMenu extends StatelessWidget{

  
  @override
  Widget build(BuildContext context) {

    return PopupMenuButton(
            offset: Offset(0, 50),
            shape: const TooltipShape(),
            itemBuilder: (_) => <PopupMenuEntry>[
              PopupMenuItem(
                  child: ListTile(
                leading: const Icon(Icons.calculate_outlined),
                title: const Text('a'),
              )),
              PopupMenuItem(
                  child: ListTile(
                  leading: const Icon(Icons.av_timer_outlined),
                  title: const Text('b'),
              )),
            ],
          );
  }

}