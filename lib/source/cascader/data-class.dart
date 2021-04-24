part of hs_cascader;

class HsCascaderOption<T> {
  final T value;
  final String label;
  final List<HsCascaderOption<T>> children;
  final GlobalKey key = GlobalKey();
  ScrollController childrenScrollController;

  HsCascaderOption({@required this.value, @required this.label, this.children}){
    if(children != null){
      childrenScrollController = ScrollController();
    }
  }
}