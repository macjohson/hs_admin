library hs_badge;

import 'package:flutter/material.dart';

part '_badge.dart';

part '_define.dart';

part '_dot.dart';

part '_count.dart';

part '_status.dart';

class HsBadge extends StatelessWidget {
  final _Badge badge;

  HsBadge(this.badge);

  HsBadge.count(Widget child,
      {int count = 0,
      BadgeCustom custom = const BadgeCustom(),
      bool showZero = false,
      int overflowCount = 99,
      HsBadgeSize size = HsBadgeSize.normal})
      : badge = _CountBadge(child,
            count: count,
            custom: custom,
            showZero: showZero,
            overflowCount: overflowCount,
            size: size);

  HsBadge.dot(Widget child, {BadgeCustom custom = const BadgeCustom()})
      : badge = _Dot(child, custom: custom);

  HsBadge.status({HsBadgeStatus status = HsBadgeStatus.normal, String text})
      : badge = _Status(status: status, text: text);

  @override
  Widget build(BuildContext context) {
    return badge.widget;
  }
}
