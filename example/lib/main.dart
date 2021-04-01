import 'package:flutter/material.dart';
import 'package:pq_skeleton_loader/pq_skeleton_loader.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  PQSkeletonLoadController _loadController =
      PQSkeletonLoadController(onLoad: (controller) async {
    controller.state = PQSkeletonLoadStatus.loading;
    await Future.delayed(Duration(seconds: 3));
    controller.state = PQSkeletonLoadStatus.success;
  });

  void _incrementCounter() {
    _loadController.refreshData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      // body: PQSkeletonLoaderBase(
      //   builder: (BuildContext context, PQSkeletonLoadController controller) {
      //     String text = "Unknown";
      //     switch (controller.state) {
      //       case PQSkeletonLoadStatus.blank: text = ""; break;
      //       case PQSkeletonLoadStatus.loading: text = "Loading"; break;
      //       case PQSkeletonLoadStatus.success: text = "Success"; break;
      //       case PQSkeletonLoadStatus.failed: text = "Failed"; break;
      //       case PQSkeletonLoadStatus.noNetwork: text = "NoNetwork"; break;
      //       case PQSkeletonLoadStatus.emptyData: text = "EmptyData"; break;
      //       case PQSkeletonLoadStatus.custom: text = "Custom"; break;
      //     }
      //     return Center(child: Text(text));
      //   },
      //   controller: _loadController,
      // ),

      body: PQSkeletonLoader(
        loading: PQBannerGridSkeletonScreen(),
        controller: _loadController,
        onSuccess: (context, controller) => ListView.builder(
          itemBuilder: (context, idx) => SizedBox(
            height: 44,
            child: Center(child: Text("$idx")),
          ),
          itemCount: 20,
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}


/**
 * loading ?? PQListSkeletonScreen(),

    })   : loading = loading ?? PQImageSkeletonScreen.network(url: "https://www.uedbox.com/wp-content/uploads/2020/03/flutter_skeleton.png"),
    })   : loading = loading ?? PQGridSkeletonScreen(),
    })   : loading = loading ??
    PQChildSkeletonScreen(
    child: ListView.builder(
    itemBuilder: (ctx, idx) => Container(
    color: idx % 2 == 0 ? Colors.yellowAccent : Colors.redAccent,
    height: 44,
    ),
    itemCount: 30,
    )),
    })   : loading = loading ??
    PQCommonSkeletonScreen(
    reverse: false,
    direction: PQShimmerDirection.otc,
    child: ListView.builder(
    itemBuilder: (ctx, idx) => Container(
    color: idx % 2 == 0 ? Colors.yellowAccent : Colors.redAccent,
    height: 44,
    ),
    itemCount: 30,
    ),
    gradient: RadialGradient(
    colors: [
    Colors.grey[300]!.withAlpha(100),
    Colors.grey[300]!.withAlpha(100),
    Colors.grey[100]!.withAlpha(200),
    Colors.grey[300]!.withAlpha(100),
    Colors.grey[300]!.withAlpha(100)
    ],
    stops: [0.0, 0.35, 0.6, 0.75, 1.0],
    radius: 1.0,
    ),
    )
 * */