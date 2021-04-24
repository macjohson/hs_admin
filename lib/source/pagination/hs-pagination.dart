import 'package:flutter/material.dart';
import 'package:hs_common_components/hs_common_components.dart';

enum PaginationAlignment { start, center, end }

List<int> _lastCurrent = [0];

extension _Alignment on PaginationAlignment {
  MainAxisAlignment get alignment {
    final Map<PaginationAlignment, MainAxisAlignment> _alignmentMap = {
      PaginationAlignment.start: MainAxisAlignment.start,
      PaginationAlignment.center: MainAxisAlignment.center,
      PaginationAlignment.end: MainAxisAlignment.end
    };

    return _alignmentMap[this];
  }
}

class PaginationChangeArgument {
  final int current;
  final int pageSize;

  PaginationChangeArgument({@required this.current, @required this.pageSize});
}

class HsPagination extends StatelessWidget {
  final int current;
  final int pageSize;
  final int total;
  final List<int> pageSizeConfig;
  final PaginationAlignment alignment;
  final Function(PaginationChangeArgument argument) onChange;

  HsPagination(
      {@required this.current,
      @required this.pageSize,
      @required this.total,
      this.pageSizeConfig = const <int>[10, 20, 30, 40, 50],
      this.alignment = PaginationAlignment.end,
      @required this.onChange}) {
    assert(pageSizeConfig.contains(pageSize),
        "pageSize 必须是 pageSizeConfig 其中一项，pageSizeConfig 默认为[10, 20, 30, 40, 50]");
    assert(current > 0, "current必须大于0");
  }

  int get _totalPage {
    if (total <= 0) return 0;
    return (total % pageSize == 0 ? total / pageSize : total ~/ pageSize + 1)
        .toInt();
  }

  bool get _canPre {
    return current > 1;
  }

  bool get _canNext {
    return current < _totalPage;
  }

  bool get _canFirst {
    return _canPre;
  }

  bool get _canLast {
    return current != _totalPage && _totalPage != 1;
  }

  void _nextPage() {
    onChange(
        PaginationChangeArgument(current: current + 1, pageSize: pageSize));
  }

  void _prePage() {
    onChange(
        PaginationChangeArgument(current: current - 1, pageSize: pageSize));
  }

  void _lastPage() {
    onChange(PaginationChangeArgument(current: _totalPage, pageSize: pageSize));
  }

  void _firstPage() {
    onChange(PaginationChangeArgument(current: 1, pageSize: pageSize));
  }

  void _switchPageSize(int value) {
    onChange(PaginationChangeArgument(current: 1, pageSize: value));
  }

  Widget _buildCurrent(BuildContext context) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 225),
      transitionBuilder: (child, animation) {
        return ScaleTransition(
            scale: animation,
            child: Transform(
              transform: Matrix4.translationValues(
                  0,
                  (current > _lastCurrent.first ? 16 : -16) * animation.value,
                  0),
              child: child,
            ));
      },
      child: Text(
        current.toString(),
        style: TextStyle(fontSize: 16),
        key: ValueKey<int>(current + DateTime.now().microsecondsSinceEpoch),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_lastCurrent.length == 2) {
      _lastCurrent[0] = _lastCurrent[1];
    }

    if (_lastCurrent.length == 2) {
      _lastCurrent[1] = current;
    } else {
      _lastCurrent.add(current);
    }

    if (_totalPage == 0) return Container();

    return SizedBox(
      height: 50,
      child: Row(
        mainAxisAlignment: alignment.alignment,
        children: [
          SpaceRow(space: 12, children: [
            SpaceRow(children: [
              Text("每页行数："),
              DropdownButton<int>(
                  onChanged: _switchPageSize,
                  value: pageSize,
                  items: List.generate(
                      pageSizeConfig.length,
                      (index) => DropdownMenuItem(
                            child: Text(pageSizeConfig[index].toString()),
                            value: pageSizeConfig[index],
                          )))
            ]),
            HsIconButton(
              icon: Icon(Icons.first_page),
              onTap: _canFirst ? _firstPage : null,
              tooltip: '首页',
            ),
            HsIconButton(
              icon: Icon(
                Icons.arrow_back_ios_sharp,
                size: 18,
              ),
              onTap: _canPre ? _prePage : null,
              tooltip: '上一页',
            ),
            Row(
              children: [
                Text('共$_totalPage页 当前：'),
                SizedBox(
                  width: _totalPage.toString().length * 10.toDouble(),
                  child: _buildCurrent(context),
                )
              ],
            ),
            HsIconButton(
              icon: Icon(
                Icons.arrow_forward_ios_sharp,
                size: 18,
              ),
              onTap: _canNext ? _nextPage : null,
              tooltip: '下一页',
            ),
            HsIconButton(
              icon: Icon(Icons.last_page),
              onTap: _canLast ? _lastPage : null,
              tooltip: '尾页',
            )
          ])
        ],
      ),
    );
  }
}
