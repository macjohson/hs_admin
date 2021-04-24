import 'package:flutter/material.dart';
import 'package:hs_admin_components/hs_admin_components.dart';
import 'package:hs_admin_components/source/tree/hs-tree.dart';

void main() {
  runApp(TestApp());
}

class TestApp extends StatefulWidget {
  @override
  _TestAppState createState() => _TestAppState();
}

class _TestAppState extends State<TestApp> {
  List<int> value = [];

  bool loading = false;

  @override
  void initState() {
    super.initState();
  }

  int page = 1;
  int pageSize = 10;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "test",
        home: Scaffold(
          appBar: AppBar(
            title: Text("example"),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HsTree.select(options: [
                  TreeDataItem(title: "测试选项1", value: "1", children: [
                    TreeDataItem(title: "测试选项1-1", value: "1-1", children: [
                      TreeDataItem(
                          title: "测试选项1-1-1",
                          value: "1-1-1",
                          children: [
                            TreeDataItem(
                                title: "测试选项1-1-1-1", value: "1-1-1-1"),
                            TreeDataItem(
                                title: "测试选项1-1-1-2", value: "1-1-1-2"),
                            TreeDataItem(
                                title: "测试选项1-1-1-3", value: "1-1-1-3"),
                            TreeDataItem(
                                title: "测试选项1-1-1-4", value: "1-1-1-4"),
                          ]),
                      TreeDataItem(title: "测试选项1-1-2", value: "1-1-2"),
                      TreeDataItem(title: "测试选项1-1-3", value: "1-1-3"),
                      TreeDataItem(title: "测试选项1-1-4", value: "1-1-4"),
                    ]),
                    TreeDataItem(title: "测试选项1-2", value: "1-2"),
                    TreeDataItem(title: "测试选项1-3", value: "1-3"),
                    TreeDataItem(title: "测试选项1-4", value: "1-4"),
                    TreeDataItem(title: "测试选项1-5", value: "1-5"),
                  ]),
                  TreeDataItem(title: "测试选项2", value: "2", children: [
                    TreeDataItem(title: "测试选项2-1", value: "2-1"),
                    TreeDataItem(title: "测试选项2-2", value: "2-2"),
                    TreeDataItem(title: "测试选项2-3", value: "2-3"),
                    TreeDataItem(title: "测试选项2-4", value: "2-4"),
                    TreeDataItem(title: "测试选项2-5", value: "2-5"),
                  ])
                ], onSelected: (v) {}),
                Padding(
                    padding: EdgeInsets.all(24),
                    child: HsBadge.status(
                      text: "sdfhsjdfhnsj",
                      status: HsBadgeStatus.processing,
                    )),
                Padding(
                  padding: EdgeInsets.all(24),
                  child: HsPagination(
                      current: page,
                      pageSize: pageSize,
                      total: 100,
                      onChange: (arg) {
                        setState(() {
                          page = arg.current;
                          pageSize = arg.pageSize;
                        });
                      }),
                ),
                Padding(
                  padding: EdgeInsets.all(24),
                  child: HsCascader<int>(
                    options: List.generate(
                        100,
                        (index) => HsCascaderOption(
                            value: index,
                            label: "测试$index",
                            children: List.generate(
                                20,
                                (i) => HsCascaderOption(
                                    value: int.parse("$index$i"),
                                    label: '测试$index$i', children: List.generate(
                                    20,
                                        (ii) => HsCascaderOption(
                                        value: int.parse("$index$ii"),
                                        label: '测试$index$ii')))))),
                    value: value,
                    onChange: (v) {
                      setState(() {
                        value = v;
                      });
                    },
                  ),
                )
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.link),
            onPressed: () async {
              setState(() {
                loading = true;
              });

              await Future.delayed(Duration(seconds: 10));

              setState(() {
                loading = false;
              });
            },
          ),
        ));
  }
}
