part of hs_tree;

class _Select extends StatefulWidget {
  final _SelectDefine define;

  _Select(this.define);

  @override
  __SelectState createState() => __SelectState();
}

class __SelectState extends State<_Select> {
  final GlobalKey _key = GlobalKey();
  List<String> expandedIds = [];
  List<String> checkedIds = [];

  onCheckChange(value) {
    if(checkedIds.contains(value)){
      checkedIds.removeWhere((element) => element == value);
    }else{
      checkedIds.add(value);
    }
  }

  Future<void> _handleTextFieldTap() async {
    final RenderBox renderBox = _key.currentContext.findRenderObject();

    final position = renderBox.localToGlobal(Offset.zero);
    final Size size = renderBox.size;

    final res = await Navigator.push(
        context,
        PageRouteBuilder(
            pageBuilder: (_, animation, __) => _SelectPanel(
              options: widget.define.options,
                animation: animation,
                offset: Offset(position.dx, position.dy + size.height),expandedIds: expandedIds, checkedIds: checkedIds,),
            opaque: false,
            barrierDismissible: true,transitionDuration: Duration(milliseconds: 100), reverseTransitionDuration: Duration(milliseconds: 100)));
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: true,
      key: _key,
      onTap: _handleTextFieldTap,
    );
  }
}
