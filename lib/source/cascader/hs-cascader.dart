library hs_cascader;

import 'package:flutter/material.dart';

part '_router.dart';

part '_animation-main.dart';

part 'data-class.dart';

part '_options-panel-container.dart';

part '_option-panel-animation.dart';

part '_pick-panel.dart';

class HsCascader<T> extends StatefulWidget {
  final List<HsCascaderOption<T>> options;
  final List<T> value;
  final Function(List<T>) onChange;

  HsCascader(
      {@required this.options, @required this.value, @required this.onChange}){
    assert(this.value != null, "value can't be null");
    assert(this.options != null, "options can't be null");
    assert(this.onChange != null, "onChange can't be null");
  }

  @override
  _HsCascaderState<T> createState() => _HsCascaderState<T>();
}

class _HsCascaderState<T> extends State<HsCascader<T>> {
  final GlobalKey _fieldKey = GlobalKey();

  final TextEditingController _textEditingController = TextEditingController();

  Map<int, ScrollPosition> _positions = {};

  _generateText(List<T> val) {
    var currentFindTarget = widget.options ?? [];
    final List<String> texts = [];
    for(int i = 0; i < val.length;i++) {
      if(currentFindTarget != null) {
        final findItem = currentFindTarget.firstWhere((element) => element.value == val[i]);
        if(findItem != null) {
          texts.add(findItem.label);
          currentFindTarget = findItem.children;
        }
      }
    }

    _textEditingController.text = texts.join('/');
  }

  @override
  void initState() {
    super.initState();

    _generateText(widget.value);
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(24),
      child: TextFormField(
        controller: _textEditingController,
        key: _fieldKey,
        readOnly: true,
        onTap: () async {
          final RenderBox renderBox =
              _fieldKey.currentContext.findRenderObject();

          final position = renderBox.localToGlobal(Offset.zero);
          final size = renderBox.size;

          final res = await Navigator.push(
              context,
              _Route(
                  builder: (_, animation) => _PickPanel(
                        positions: _positions,
                        animation: animation,
                        options: widget.options,
                        inputPosition: position,
                        inputSize: size,
                        initialValue: widget.value,
                      )));

          if (res is CascaderPickCacheResult<T>) {
            widget.onChange(res.values);
            _positions = res.positions;
            _generateText(res.values);
          }
        },
      ),
    );
  }
}
