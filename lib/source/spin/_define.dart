part of hs_spin;

enum HsSpinSize{
  small,
  middle,
  large
}

extension _HsSpinSize on HsSpinSize {
  Size get size{
    final Map<HsSpinSize, Size> sizeMap = {
      HsSpinSize.small: Size(20, 20),
      HsSpinSize.middle: Size(30, 30),
      HsSpinSize.large: Size(45, 45)
    };

    return sizeMap[this];
  }
}