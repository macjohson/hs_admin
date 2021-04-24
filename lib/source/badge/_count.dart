part of hs_badge;

class _CountBadge extends _Badge {
  final int count;
  final BadgeCustom custom;
  final bool showZero;
  final int overflowCount;
  final HsBadgeSize size;
  final Widget child;

  _CountBadge(this.child, {@required this.count, this.custom, this.showZero, this.overflowCount, this.size });

  double get _positionOffset{
    return -(size.size.width * .5);
  }

  double get _padding{
    return count > 9 || count > overflowCount ? 8 : 0;
  }

  String get _showCount{
    return count > overflowCount ? "$overflowCount+" : count.toString();
  }
  
  bool get _isHideCount{
    return !showZero && count == 0;
  }

  @override
  Widget get widget => Stack(
    clipBehavior: Clip.none,
    children: [
      child,
      _isHideCount ? null : Positioned(child: Transform(transform: Matrix4.translationValues(custom.offset.dx, custom.offset.dy, 0), child: Container(
        padding: EdgeInsets.symmetric(horizontal: _padding),
        constraints: BoxConstraints(
            minWidth: size.size.width
        ),
        height: size.size.height,
        decoration: BoxDecoration(
            color: custom.color,
            borderRadius: BorderRadius.circular(size.size.width)
        ),
        child: Center(child: Text(_showCount, style: TextStyle(
            color: Colors.white,
            fontSize: 12
        ),),),
      ),), top: _positionOffset, right: _positionOffset,)
    ]..removeWhere((element) => element == null),
  );

}
