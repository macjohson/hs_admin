import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hs_common_components/hs_common_components.dart';
import 'package:path_drawing/path_drawing.dart';

enum HsButtonType { primary, dashed, link, text, normal, danger }

class HsButton extends StatefulWidget {
  final HsButtonType type;
  final IconData icon;
  final String label;
  final Function onTap;

  HsButton(
      {this.type = HsButtonType.normal,
        this.icon,
        @required this.label,
        this.onTap});

  @override
  _HsButtonState createState() => _HsButtonState();
}

class _HsButtonState extends State<HsButton> with TickerProviderStateMixin {
  double get _space {
    return widget.icon == null ? 0 : 4;
  }

  Color _primaryButtonBackgroundColor(Set<MaterialState> status) {
    return widget.type == HsButtonType.danger ? Colors.redAccent : Theme.of(context).primaryColor;
  }

  Color _primaryButtonOverlayColor(Set<MaterialState> status) {
    return status.any((element) => element == MaterialState.hovered)
        ? Colors.transparent
        : Colors.white.withOpacity(.5);
  }

  AnimationController _textButtonHoveredAnimationController;
  AnimationController _textButtonClickController;
  Animation<Color> _textButtonBorderAnimation;
  Animation<Color> _textButtonTextAnimation;
  Animation<double> _textButtonShadowAnimation;

  Color _textButtonBorderColor = Colors.black38;
  Color _textButtonTextColor = Colors.black87;
  double _textButtonShadow = 0;

  @override
  void initState() {
    super.initState();
  }

  _initTextButtonHoveredAnimation() {
    _textButtonHoveredAnimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    _textButtonBorderAnimation =
        ColorTween(begin: Colors.black38, end: Theme.of(context).primaryColor)
            .animate(CurvedAnimation(
            parent: _textButtonHoveredAnimationController,
            curve: Curves.bounceInOut));

    _textButtonTextAnimation =
        ColorTween(begin: Colors.black87, end: Theme.of(context).primaryColor)
            .animate(CurvedAnimation(
            parent: _textButtonHoveredAnimationController,
            curve: Curves.bounceInOut));

    _textButtonHoveredAnimationController.addListener(() {
      setState(() {
        _textButtonBorderColor = _textButtonBorderAnimation.value;
        _textButtonTextColor = _textButtonTextAnimation.value;
      });
    });

    _textButtonClickController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 120));
    _textButtonShadowAnimation = Tween<double>(begin: 0, end: 10).animate(
        CurvedAnimation(
            parent: _textButtonClickController, curve: Curves.bounceInOut));

    _textButtonClickController.addListener(() {
      setState(() {
        _textButtonShadow = _textButtonShadowAnimation.value;
      });
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _initTextButtonHoveredAnimation();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.type == HsButtonType.normal ||
        widget.type == HsButtonType.dashed) {
      return Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        elevation: _textButtonShadow,
        shadowColor: Theme.of(context).primaryColor,
        child: MouseRegion(
          onHover: (e) {
            _textButtonHoveredAnimationController.forward();
          },
          onExit: (e) {
            _textButtonHoveredAnimationController.reverse();
          },
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () {
              _textButtonClickController
                  .forward()
                  .whenComplete(() => _textButtonClickController.reverse());
            },
            child: CustomPaint(
              painter: _ButtonBorderPainter(
                  color: _textButtonBorderColor,
                  dashed: widget.type == HsButtonType.dashed),
              child: SpaceRow(
                space: _space,
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                children: [
                  widget.icon != null
                      ? Icon(
                    widget.icon,
                    size: 16,
                    color: _textButtonTextColor,
                  )
                      : null,
                  Text(
                    widget.label,
                    style: TextStyle(fontSize: 16, color: _textButtonTextColor),
                  )
                ]..removeWhere((element) => element == null),
              ),
            ),
          ),
        ),
      );
    }

    if (widget.type == HsButtonType.primary || widget.type == HsButtonType.danger) {
      return ElevatedButton(
          onPressed: widget.onTap,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith(
                _primaryButtonBackgroundColor),
            overlayColor:
            MaterialStateProperty.resolveWith(_primaryButtonOverlayColor),
          ),
          child: SpaceRow(
            space: _space,
            children: [
              widget.icon != null
                  ? Icon(
                widget.icon,
                size: 16,
              )
                  : null,
              Text(
                widget.label,
                style: TextStyle(fontSize: 16, color: Colors.white),
              )
            ]..removeWhere((element) => element == null),
          ));
    }

    if (widget.type == HsButtonType.link || widget.type == HsButtonType.text) {
      return TextButton(
          style: ButtonStyle(
              overlayColor: MaterialStateProperty.resolveWith((status) =>
              status.any((element) => element == MaterialState.pressed)
                  ? Theme.of(context).primaryColor.withOpacity(.5)
                  : Colors.transparent)),
          onPressed: widget.onTap,
          child: SpaceRow(
            space: _space,
            children: [
              widget.icon != null
                  ? Icon(
                widget.icon,
                size: 16,
                color: Colors.black87,
              )
                  : null,
              Text(
                widget.label,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                  decoration: widget.type == HsButtonType.text ? TextDecoration.none : TextDecoration.underline,
                ),
              )
            ]..removeWhere((element) => element == null),
          ));
    }


    return Container();
  }
}

class _ButtonBorderPainter extends CustomPainter {
  final Color color;
  final bool dashed;

  _ButtonBorderPainter({@required this.color, this.dashed = false});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.butt
      ..strokeWidth = 1;

    final path = Path()
      ..addRRect(RRect.fromRectAndRadius(
          Rect.fromLTWH(0, 0, size.width, size.height), Radius.circular(4)));

    if (dashed) {
      canvas.drawPath(
          dashPath(path, dashArray: CircularIntervalList([3, 2])), paint);
    } else {
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(_ButtonBorderPainter oldDelegate) {
    if (oldDelegate.color != this.color) return true;
    return false;
  }
}
