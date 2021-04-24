library hs_empty;

import 'package:flutter/material.dart';

part '_define.dart';

class HsEmpty extends StatelessWidget {
  final EmptyStyles style;
  final String description;
  
  HsEmpty({this.style = EmptyStyles.normal, this.description});
  
  Size get _imageSize{
    return style == EmptyStyles.normal ? Size(184, 100) : Size(64, 42);
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image(image: AssetImage(style.assetKey, package: "hs_admin_components"), width: _imageSize.width, height: _imageSize.height,),
          description != null ? Padding(padding: EdgeInsets.only(top: 12), child: Text(description, style: TextStyle(fontSize: 14, color: style.fontColor),),) : null
        ]..removeWhere((element) => element == null),
      ),
    );
  }
}
