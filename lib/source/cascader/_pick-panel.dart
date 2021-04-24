part of hs_cascader;

class CascaderPickCacheResult<T> {
  final List<T> values;
  final Map<int, ScrollPosition> positions;

  CascaderPickCacheResult({@required this.values, @required this.positions});
}

class _PickPanel<T> extends StatefulWidget {
  final Animation<double> animation;
  final List<HsCascaderOption<T>> options;
  final Offset inputPosition;
  final Size inputSize;
  final List<T> initialValue;
  final Map<int, ScrollPosition> positions;

  _PickPanel(
      {@required this.animation,
      @required this.options,
      @required this.inputPosition,
      @required this.inputSize,
      @required this.initialValue,
      @required this.positions});

  @override
  __PickPanelState<T> createState() => __PickPanelState<T>();
}

class __PickPanelState<T> extends State<_PickPanel> {
  List<T> _selectedValues = [];
  Map<int, ScrollController> _controllers = {};


  @override
  void initState() {
    super.initState();
    _selectedValues = widget.initialValue.map<T>((e) => e).toList();
  }

  List<List<HsCascaderOption<T>>> get _showOptions {
    final List<List<HsCascaderOption<T>>> defaultCacheList = [widget.options ?? []];
    if (_selectedValues.isEmpty) {
      return defaultCacheList;
    }

    for (var value in _selectedValues) {
      final currentOption =
          defaultCacheList.last.firstWhere((element) => element.value == value);
      if (currentOption != null && currentOption.children != null) {
        defaultCacheList.add(currentOption.children);
      }
    }

    return defaultCacheList;
  }

  @override
  void dispose() {
    for (var key in _controllers.keys) {
      _controllers[key].dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          _AnimationMain(
            animation: widget.animation,
            offset: Offset(widget.inputPosition.dx,
                widget.inputPosition.dy + widget.inputSize.height),
            child: _OptionsPanelContainer(
                List.generate(_showOptions.length, (index) {
              final item = _showOptions[index];

              return _OptionPanelAnimationWrapper(
                  child: Container(
                constraints: BoxConstraints(maxWidth: 150, maxHeight: 350),
                child: ListView.builder(
                    itemCount: item.length,
                    controller: () {
                      if (_controllers.containsKey(index)) {
                        return _controllers[index];
                      }

                      final _thisController = ScrollController(
                          initialScrollOffset: widget.positions.containsKey(index)
                              ? widget.positions[index].pixels
                              : 0);
                      _controllers[index] = _thisController;

                      return _thisController;
                    }(),
                    itemBuilder: (_, cIndex) {
                  final cItem = item[cIndex];

                  return ListTile(
                    key: cItem.key,
                    selected: _selectedValues.length > index &&
                        _selectedValues[index] == cItem.value,
                    title: Text(cItem.label),
                    onTap: () {
                      final currentTapOptionsIndex =
                          _selectedValues.length - 1;
                      if (cItem.children != null) {
                        if (currentTapOptionsIndex == null ||
                            (currentTapOptionsIndex != null &&
                                index - currentTapOptionsIndex == 1)) {
                          _selectedValues.add(cItem.value);
                          setState(() {});
                          return;
                        }

                        if (currentTapOptionsIndex == index) {
                          _selectedValues.last = cItem.value;
                          setState(() {});
                          return;
                        }

                        if (currentTapOptionsIndex > index) {
                          final newValues = () sync* {
                            for (int i = 0;
                            i <
                                _selectedValues.length -
                                    (currentTapOptionsIndex - index);
                            i++) {
                              yield _selectedValues[i];
                            }
                          }()
                              .toList();


                          newValues.last = cItem.value;
                          _selectedValues = newValues;

                          setState(() {});
                          return;
                        }
                      } else {
                        if(_selectedValues.length - 1 == index) {
                          _selectedValues.last = cItem.value;
                        }else{
                          _selectedValues.add(cItem.value);
                        }

                        final Map<int, ScrollPosition> positions = {};
                        for (var key in _controllers.keys) {
                          positions[key] = _controllers[key].position;
                        }

                        Navigator.pop(
                            context,
                            CascaderPickCacheResult<T>(
                                values: _selectedValues, positions: positions));
                      }
                    },
                  );
                })
              ));
            })),
          )
        ],
      ),
    );
  }
}
