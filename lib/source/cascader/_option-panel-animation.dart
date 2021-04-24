part of hs_cascader;

class _OptionPanelAnimation extends AnimatedWidget {
  final Animation<Matrix4> animation;
  final Widget child;

  _OptionPanelAnimation({@required this.animation, @required this.child}):super(listenable: animation);

  Animation<Matrix4> get _animation => listenable;

  @override
  Widget build(BuildContext context) {
    return Transform(transform: _animation.value, child: child,);
  }

}

class _OptionPanelAnimationWrapper extends StatefulWidget {
  final Widget child;

  _OptionPanelAnimationWrapper({@required this.child});

  @override
  __OptionPanelAnimationWrapperState createState() => __OptionPanelAnimationWrapperState();
}

class __OptionPanelAnimationWrapperState extends State<_OptionPanelAnimationWrapper> with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<Matrix4> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 225));
    _animation = Matrix4Tween(
      begin: Matrix4.translationValues(20, 0, 0),
      end: Matrix4.identity()
    ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _OptionPanelAnimation(animation: _animation, child: widget.child);
  }
}
