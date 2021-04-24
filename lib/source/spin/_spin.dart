part of hs_spin;

class _Spin extends StatefulWidget {
  final HsSpinSize size;
  final String text;
  final bool loading;

  _Spin({@required this.size, this.text, this.loading});
  @override
  __SpinState createState() => __SpinState();
}

class __SpinState extends State<_Spin> with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _animation;

  double _opacity = 0;

  bool _show = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: Duration(seconds: 1, milliseconds: 200))..repeat();
    _animation = CurvedAnimation(parent: _animationController, curve: Curves.linear);

  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant _Spin oldWidget) {
    super.didUpdateWidget(oldWidget);
    if(!oldWidget.loading && widget.loading){
      setState(() {
        _show = true;
      });

      Future.delayed(Duration(milliseconds: 10)).then((value) {
        setState(() {
          _opacity = 1;
        });
      });
    }

    if(oldWidget.loading && !widget.loading){
      setState(() {
        _opacity = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).primaryColor;
    return Positioned.fill(child: AnimatedOpacity(
      opacity: _opacity,
      onEnd: () {
        if(!_show && !widget.loading){
          setState(() {
            _show = false;
          });
        }
      },
      duration: Duration(milliseconds: 450),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RotationTransition(turns: _animation, child: SizedBox(
              width: widget.size.size.width,
              height: widget.size.size.height,
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                primary: false,
                children: [
                  _SpinDot(),
                  _SpinDot(
                    delay: Duration(milliseconds: 500),
                  ),
                  _SpinDot(
                    delay: Duration(milliseconds: 1000),
                  ),
                  _SpinDot(
                    delay: Duration(milliseconds: 1500),
                  ),
                ],
              ),
            ),),
            widget.text != null ? Padding(padding: EdgeInsets.only(top: 12), child: Text(widget.text, style: TextStyle(color: textColor, fontSize: 16),),) : null
          ]..removeWhere((element) => element == null),
        ),
      ),
    ));
  }
}
