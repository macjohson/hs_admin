part of hs_spin;

class _SpinDot extends StatefulWidget {
  final Duration delay;

  _SpinDot({this.delay = Duration.zero});
  @override
  __SpinDotState createState() => __SpinDotState();
}

class __SpinDotState extends State<_SpinDot> with SingleTickerProviderStateMixin {

  AnimationController _animationController;
  Animation<double> _animation;

  double opacity = 1.0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: Duration(seconds: 1));
    _animation = Tween<double>(
      begin: .5,
      end: 1.0
    ).animate(CurvedAnimation(parent: _animationController, curve: Curves.linear));

    _animationController.addListener(() {
      opacity = _animation.value;
      setState(() {

      });
    });

    Future.delayed(widget.delay).then((value){
      _animationController.repeat(reverse: true);
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).primaryColor;

    return Opacity(opacity: opacity, child: Container(
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(45)
      ),
    ),);
  }
}
