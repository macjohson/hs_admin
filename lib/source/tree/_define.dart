part of hs_tree;

class TreeDataItem{
  final String title;
  final String value;
  final List<TreeDataItem> children;

  TreeDataItem({@required this.title, @required this.value, this.children});
}

abstract class _TreeBase{
  Widget build(BuildContext context);
}

class _SelectDefine extends _TreeBase{
  final List<TreeDataItem> options;
  final Function(List<TreeDataItem> values) onSelected;

  _SelectDefine({@required this.options, @required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return _Select(this);
  }
}