library hs_spin;
import 'dart:ui';

import 'package:flutter/material.dart';

part '_define.dart';
part '_spin-dot.dart';
part '_spin.dart';

class HsSpin extends StatelessWidget {
  final HsSpinSize size;
  final Widget child;
  final String text;
  final bool loading;

  HsSpin({this.size = HsSpinSize.middle, this.child, this.text, this.loading = true});

  @override
  Widget build(BuildContext context) {

    return Container(
      constraints: BoxConstraints(minHeight: 70),
      child: Stack(
        children: [
          Center(
            child: child,
          ),
         _Spin(size: size, text: text, loading: loading,)
        ]..removeWhere((element) => element == null),
      ),
    );
  }
}
