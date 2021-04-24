part of hs_cascader;

class _AnimationMain extends AnimatedWidget {
  final Animation<double> animation;
  final Offset offset;
  final Widget child;

  _AnimationMain(
      {@required this.animation,
        @required this.offset, @required this.child})
      : super(listenable: animation);

  Animation<double> get _animation => listenable;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      child: Opacity(
        opacity: _animation.value,
        child: child,
      ),
      top: (offset.dy - 20) + (20 * _animation.value),
      left: offset.dx,
    );
  }
}