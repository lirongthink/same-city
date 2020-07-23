import 'package:fluro/fluro.dart';

class Application{
  static Router router; //静态化Router，这样我们在使用的时候就可以直接用 Application.Router就可以了。这样在任何一个页面都可以直接调用，不用再New 去调用了。
}
