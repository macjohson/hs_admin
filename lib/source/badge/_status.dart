part of hs_badge;

class _Status extends _Badge {
  final HsBadgeStatus status;
  final String text;

  _Status({this.status, this.text});

  static const _size = 6.0;

  @override
  Widget get widget => Row(
    children: [
      Container(
        width: _size,
        height: _size,
        decoration: BoxDecoration(
          color: status.color,
          borderRadius: BorderRadius.circular(_size)
        ),
      ),
      text != null ? Padding(padding: EdgeInsets.only(left: 8), child: Text(text, style: TextStyle(
          fontSize: 14,
          color: Colors.black87
      ),),) : null
    ]..removeWhere((element) => element == null),
  );

}