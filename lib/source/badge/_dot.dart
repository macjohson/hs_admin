part of hs_badge;

class _Dot extends _Badge {
  final BadgeCustom custom;
  final Widget child;

  _Dot(this.child, {this.custom});

  static const double _size = 6.0;

  @override
  Widget get widget => Stack(
    clipBehavior: Clip.none,
    children: [
      child,
      Positioned(child: Transform(
        transform: Matrix4.translationValues(custom.offset.dx, custom.offset.dy, 0),
        child: Container(
          width: _size,
          height: _size,
          decoration: BoxDecoration(
            color: custom.color,
            borderRadius: BorderRadius.circular(_size)
          ),
        ),
      ),right: -2, top: -2, )
    ],
  );
}
