import 'package:flutter/material.dart';
import 'package:hs_common_components/hs_common_components.dart';

class PageHeader extends StatelessWidget {
  final Function onBack;
  final String title;
  final String subTitle;
  final bool canBack;
  final List<Widget> actions;

  PageHeader(
      {this.onBack,
      @required this.title,
      this.subTitle,
      this.canBack = true,
      this.actions});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(

        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                canBack
                    ? Padding(
                        padding: EdgeInsets.only(top: 4),
                        child: HsIconButton(
                            onTap: onBack,
                            icon: Icon(Icons.arrow_back_sharp),
                            tooltip: "返回"),
                      )
                    : null,
                SpaceRow(
                  padding: EdgeInsets.only(left: 16),
                  space: 12,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.black87),
                    ),
                    subTitle != null
                        ? Text(
                            subTitle,
                            style: TextStyle(color: Colors.black54),
                          )
                        : null
                  ]..removeWhere((element) => element == null),
                )
              ]..removeWhere((element) => element == null),
            ),
            SpaceRow(
              space: 12,
              children: actions ?? [],
            )
          ],
        ),
      ),
    );
  }
}
