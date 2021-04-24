part of hs_tree;

class _PanelAnimation extends AnimatedWidget {
  final Animation<double> animation;
  final Offset offset;
  final Widget child;

  _PanelAnimation({@required this.animation, @required this.offset, @required this.child})
      : super(listenable: animation);

  Animation<double> get _animation => this.listenable;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: offset.dx,
            top: offset.dy,
            child: Opacity(opacity: _animation.value, child: SizeTransition(
              sizeFactor: _animation,
              child: child,
            ),))
      ],
    );
  }
}
