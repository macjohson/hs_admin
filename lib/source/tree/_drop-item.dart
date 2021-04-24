part of hs_tree;

class _DropItem extends StatefulWidget {
  final Function(String value) onCheck;
  final Widget title;
  final Function(String value) onExpand;
  final List<TreeDataItem> children;
  final String value;
  final List<String> expandedIds;
  final List<String> checkedIds;

  _DropItem(
      {@required this.expandedIds,
      @required this.onCheck,
      @required this.title,
      @required this.onExpand,
      this.children,
      @required this.value,
      @required this.checkedIds});

  @override
  __DropItemState createState() => __DropItemState();
}

class __DropItemState extends State<_DropItem>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 225));

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.easeInBack));
  }

  @override
  void didUpdateWidget(covariant _DropItem oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.expandedIds.contains(widget.value)) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  List<String> get _childrenIds {
    if (widget.children == null) {
      return [];
    }

    final List<String> allChildIds = [];

    void appendId(List<TreeDataItem> list) {
      for(var item in list){
        allChildIds.add(item.value);

        if(item.children != null){
          appendId(item.children);
        }
      }
    }

    appendId(widget.children);

    return allChildIds;
  }

  bool get _showIndeterminate {
    return !widget.checkedIds.contains(widget.value) &&
        !_childrenIds.every((element) => widget.checkedIds.contains(element)) &&
        _childrenIds.any((element) => widget.checkedIds.contains(element));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 4, right: 16),
      decoration: BoxDecoration(color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Opacity(opacity: widget.children != null ? 1 : 0, child: _DropArrow(
                  expanded: widget.expandedIds.contains(widget.value),
                  onTap: (){
                    if(widget.children != null){
                      widget.onExpand(widget.value);
                    }
                  }),),
              Row(
                children: [
                  _showIndeterminate ? Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: (){
                        widget.onCheck(widget.value);
                      },
                      child: Padding(padding: EdgeInsets.all(12), child: Icon(Icons.indeterminate_check_box, color: Theme.of(context).primaryColor,),),
                    ),
                  ) : Checkbox(
                    onChanged: (bool value) {
                      widget.onCheck(widget.value);
                    },
                    value: widget.checkedIds.contains(widget.value),
                  ),
                  widget.title
                ],
              )
            ]..removeWhere((element) => element == null),
          ),
          widget.children != null
              ? SizeTransition(
                  sizeFactor: _animation,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        left: BorderSide(color: Colors.black12)
                      )
                    ),
                    // padding: EdgeInsets.only(left: 12),
                    margin: EdgeInsets.only(left: 20, top: 8, bottom: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(widget.children.length, (index) {
                        final item = widget.children[index];

                        return _DropItem(
                          expandedIds: widget.expandedIds,
                          onCheck: widget.onCheck,
                          title: Text(item.title),
                          onExpand: widget.onExpand,
                          value: item.value,
                          children: item?.children,
                          checkedIds: widget.checkedIds,
                        );
                      }),
                    ),
                  ),
                )
              : null
        ]..removeWhere((element) => element == null),
      ),
    );
  }
}
