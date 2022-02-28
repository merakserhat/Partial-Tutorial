import 'package:flutter/material.dart';
import 'package:partial_tutorial/partial_tutorial.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(title: 'Partial Tutorial Example'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  ///If we want to let users open whenever they pressed to some button,
  ///we should control this with a bool variable.
  ///We should set this variable to true when that button is pressed.
  ///And we should register to onTutorialFinished field of [PartialTutorialProvider]
  ///and inside of this method, we should set this variable to false;
  bool isTutorialActive = false;

  @override
  Widget build(BuildContext context) {
    /// [PartialTutorialProvider] widget should be wrapped all around the screen including scaffold
    return PartialTutorialProvider(
      isTutorialActive: isTutorialActive,

      ///Controllers are taken from the [MyHomePageTutorial] that we write for every tutorial page.
      controllers: MyHomePageTutorial.controllers,

      ///To close the tutorial.
      ///
      /// If we don't give onTutorialFinished, it will be automatically closed.
      /// However, it won't be possible to reopen it again.
      onTutorialFinished: () {
        setState(() {
          isTutorialActive = false;
        });
      },
      backgroundColor: Colors.black54.withOpacity(0.8),
      informationBackgroundColor: Colors.black54.withOpacity(0.4),
      showBorder: true,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: [
            InkWell(
              onTap: () {
                setState(() {
                  isTutorialActive = true;
                });
              },
              child: Container(
                margin: const EdgeInsets.all(16),

                ///Every widget that we want to show its tutorial should be wrapped with [PartialTutorialItem
                child: PartialTutorialItem(
                  controller: MyHomePageTutorial.infoButtonController,
                  child: const Icon(Icons.info),
                ),
              ),
            )
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'You have pushed the button this many times:',
              ),

              ///Every widget that we want to show its tutorial should be wrapped with [PartialTutorialItem]
              PartialTutorialItem(
                ///The controller is taken from the [MyHomePageTutorial]
                controller: MyHomePageTutorial.counterLabelController,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: Text(
                    '$_counter',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ),
              ),
              const SizedBox.square(dimension: 50),

              ///Every widget that we want to show its tutorial should be wrapped with [PartialTutorialItem]
              PartialTutorialItem(
                controller: MyHomePageTutorial.resetButtonController,
                child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _counter = 0;
                      });
                    },
                    child: const Text("Reset Counter")),
              )
            ],
          ),
        ),

        ///Every widget that we want to show its tutorial should be wrapped with [PartialTutorialItem]
        floatingActionButton: PartialTutorialItem(
          controller: MyHomePageTutorial.incrementButtonController,
          child: FloatingActionButton(
            onPressed: () {
              setState(() {
                _counter++;
              });
            },
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}

/// The Tutorial class that holds every [PartialTutorialItemController] with their data
///
/// It is recommended to create a tutorial class for every screen that you want to show
/// tutorial to keep code clean and separate the tutorial page codes with the page itself.
class MyHomePageTutorial {
  ///Tutorial controller for counter label
  static PartialTutorialItemController counterLabelController =
      PartialTutorialItemController(
    information: "This label shows the value of the counter.",
  );

  ///Tutorial controller for reset button
  static PartialTutorialItemController resetButtonController =
      PartialTutorialItemController(
    information: "This button decreases the value of the counter to zero.",
  );

  ///Tutorial controller for increment button
  static PartialTutorialItemController incrementButtonController =
      PartialTutorialItemController(
    information: "This button increases the counter by one.",
  );

  ///Tutorial controller for info button
  static PartialTutorialItemController infoButtonController =
      PartialTutorialItemController(
    information:
        "You can open this tutorial page by pressing the information button.",
  );

  ///List of the controller with the correct order.
  static List<PartialTutorialItemController> get controllers => [
        counterLabelController,
        resetButtonController,
        incrementButtonController,
        infoButtonController,
      ];
}

/*
 return PartialTutorialProvider(
      isTutorialActive: isTutorialActive,
      controllers: MyHomePageTutorial.controllers,
      child: Scaffold(
        appBar: ...
        body: ...
      ),
    );
  }
 */
