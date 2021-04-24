part of hs_badge;

enum HsBadgeSize { normal, small }

extension _HsBadgeSize on HsBadgeSize {
  Size get size{
    final Map<HsBadgeSize, Size> sizeMap = {
      HsBadgeSize.normal: Size(20, 20),
      HsBadgeSize.small: Size(14, 14)
    };

    return sizeMap[this];
  }
}

enum HsBadgeStatus {
  normal,
  success,
  processing,
  error,
  warning
}

extension _HsBadgeStatus on HsBadgeStatus {
  Color get color{
    final Map<HsBadgeStatus, Color> colorMap = {
      HsBadgeStatus.normal: Color(0xFFD9D9D9),
      HsBadgeStatus.success: Color(0xFF72C040),
      HsBadgeStatus.processing: Color(0xFF4091F7),
      HsBadgeStatus.error: Color(0xFFEC5B56),
      HsBadgeStatus.warning: Color(0xFFEFAF41)
    };

    return colorMap[this];
  }
}

class BadgeCustom{
  final Offset offset;
  final Color color;

  const BadgeCustom({
    this.offset = const Offset(0,0), this.color = Colors.redAccent});
}
