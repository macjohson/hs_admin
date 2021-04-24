part of hs_tree;

class _DropArrow extends StatefulWidget {
  final bool expanded;
  final Function() onTap;

  _DropArrow({@required this.expanded, @required this.onTap});

  @override
  ___DropArrowState createState() => ___DropArrowState();
}

class ___DropArrowState extends State<_DropArrow> with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 225));

    _animation = Tween<double>(
      begin: 0,
      end: 0.25
    ).animate(CurvedAnimation(parent: _animationController, curve: Curves.bounceInOut));
  }

  @override
  void didUpdateWidget(covariant _DropArrow oldWidget) {
    super.didUpdateWidget(oldWidget);

    if(!oldWidget.expanded && widget.expanded){
      _animationController.forward();
    }

    if(oldWidget.expanded && !widget.expanded){
      _animationController.reverse();
    }
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(turns: _animation, child: Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(50),
        child: Padding(padding: EdgeInsets.all(8), child: Icon(Icons.arrow_right),),
          onTap: widget.onTap
      ),
    ),);
  }
}
