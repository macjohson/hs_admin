part of hs_empty;

enum EmptyStyles{
  normal,
  simple
}

extension _EmptyImages on EmptyStyles{
  String get assetKey{
    switch(this) {
      case EmptyStyles.normal:
        return "assets/empty-style-1.png";
      case EmptyStyles.simple:
        return "assets/empty-style-2.png";
      default:
        return null;
    }
  }

  Color get fontColor{
    switch(this) {
      case EmptyStyles.normal:
        return Colors.black87;
      case EmptyStyles.simple:
        return Colors.black38;
      default:
        return null;
    }
  }
}