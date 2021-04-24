part of hs_tree;

class _SelectPanel extends StatefulWidget {
  final Animation<double> animation;
  final Offset offset;
  final List<TreeDataItem> options;
  final List<String> expandedIds;
  final List<String> checkedIds;

  _SelectPanel(
      {@required this.animation, @required this.offset, @required this.options, @required this.expandedIds, @required this.checkedIds});

  @override
  __SelectPanelState createState() => __SelectPanelState();
}

class __SelectPanelState extends State<_SelectPanel> {
  List<String> expandedIds = [];
  List<String> checkedIds = [];

  TreeDataItem _findItemById(String value) {
    TreeDataItem item;

    void find(List<TreeDataItem> list) {
      for(var _item in list){
        if(_item.value == value){
          item = _item;
          break;
        }

        if(_item.children != null){
          find(_item.children);
        }
      }
    }

    find(widget.options);

    return item;
  }

  TreeDataItem _findItemParentById(String value) {
    TreeDataItem parent;

    void find(List<TreeDataItem> list) {
      for(var _item in list){
        if(_item.children != null && _item.children.any((element) => element.value == value)){
          parent = _item;
          break;
        }

        if(_item.children != null){
          find(_item.children);
        }
      }
    }

    find(widget.options);

    return parent;
  }

  List<TreeDataItem> _findAllParentById(String value) {
    final List<TreeDataItem> parents = [];

    void appendParent(String v) {
      parents.add(_findItemParentById(v));

      if(parents.last != null && !widget.options.any((element) => element.value == parents.last.value)){
        appendParent(parents.last.value);
      }
    }

    appendParent(value);

    return parents..removeWhere((element) => element == null);
  }

  List<String> _getAllChildrenIds(List<TreeDataItem> children) {
    final List<String> allChildIds = [];

    void getChildIds(List<TreeDataItem> list) {
      for(var _item in list){
        allChildIds.add(_item.value);

        if(_item.children != null){
          getChildIds(_item.children);
        }
      }
    }

    getChildIds(children);

    return allChildIds;
  }

  void _onCheck(String v) {
    final current = _findItemById(v);
    final parents = _findAllParentById(v);

    if(checkedIds.contains(v)){
      if(current.children != null){
        for(var id in _getAllChildrenIds(current.children)..add(v)){
          checkedIds.removeWhere((element) => element == id);
        }
      }else{
        checkedIds.removeWhere((element) => element == v);
      }

      for(var item in parents){
        checkedIds.removeWhere((element) => element == item.value);
      }

    }else{
      if(current.children != null) {
        for(var id in _getAllChildrenIds(current.children)){
          checkedIds.removeWhere((element) => element == id);
        }
        checkedIds.addAll(_getAllChildrenIds(current.children)..add(v));
      }else{
        checkedIds.add(v);
      }

      for(var item in parents){
        if(item.children.every((element) => checkedIds.contains(element.value))){
          checkedIds.add(item.value);
        }
      }
    }

    setState(() {

    });
  }

  void _onExpand(String v) {
    if(expandedIds.contains(v)){
      expandedIds.removeWhere((element) => element == v);
    }else{
      expandedIds.add(v);
    }

    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    final maxHeight = screenSize.height - widget.offset.dy - 20;
    return Container(
      child: _PanelAnimation(
        animation: widget.animation, offset: widget.offset, child: Container(
        padding: EdgeInsets.all(4),
        child: Material(
          color: Colors.white,
          elevation: 2,
          borderRadius: BorderRadius.circular(4),
          clipBehavior: Clip.hardEdge,
          child: Container(
            constraints: BoxConstraints(
              maxHeight: maxHeight,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(widget.options.length, (index) {
                  final item = widget.options[index];

                  return _DropItem(expandedIds: expandedIds,
                      onCheck: _onCheck,
                      title: Text(item.title),
                      onExpand: _onExpand,
                      value: item.value,
                      checkedIds: checkedIds, children: item?.children,);
                }),
              ),
            ),
          ),
        ),
      ),),
    );
  }
}


