library hs_tree;

import 'package:flutter/material.dart';
part '_define.dart';
part '_drop-arrow.dart';
part '_drop-item.dart';

part '_select.dart';

part '_panel-animation.dart';

part '_select-panel.dart';

class HsTree extends StatelessWidget {
  final _TreeBase tree;

  HsTree.select(
      {@required List<TreeDataItem> options,
      @required Function(List<TreeDataItem> values) onSelected})
      : tree = _SelectDefine(options: options, onSelected: onSelected);

  @override
  Widget build(BuildContext context) {
    return tree.build(context);
  }
}
