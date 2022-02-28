# Partial Tutorial

**Add component-based tutorials for your complicated screens**

## 🎮 Examples

### Demo


## 📒 Documentation

### Installation
Add `partial_tutorial` to your `pubspec.yaml`:

```
dependencies:
  flutter:
    sdk: flutter

  # added below
  partial_tutorial: <latest version>
```

### Adding to your app

The `PartialTutorialProvider` has to be wrapped around the whole page including  
`Scaffold`.

```dart
return PartialTutorialProvider(  
  isTutorialActive: isTutorialActive,
  controllers: MyHomePageTutorial.controllers,
  child: Scaffold( appBar: ... body: ... ),
);
```

Then, wrap every widget that you want to show a partial tutorial with `PartialTutorialItem` and give it a `PartialTutorialtemController` which holds informations about the tutorial text and etc.

```dart

PartialTutorialItemController counterLabelController =  
    PartialTutorialItemController(  
  information: "This label shows the value of the counter.",  
);

return PartialTutorialItem(  
  controller: counterLabelController ,  
  child: ElevatedButton(  
      onPressed: () {  
	      //...  
	  },  
	  child: const Text("Reset Counter"),
  ),  
);
```

Finally, give the list of `PartialTutorialItemController`  to the  `PartialTutorialProvider` with the same order that you want to show your tutorial widgets.
```dart
return PartialTutorialProvider(  
  isTutorialActive: isTutorialActive,
  controllers: [
	  counterLabelController,
	  incrementButtonController,
  ],
  child: Scaffold( appBar: ... body: ... ),
);
```
It is recommended to create a new file for every tutorial page which holds the controllers in it to increase the clearity of the code and seperate the tutorial codes from the original screen logic. You can find the implementation in the example project.

### Author
Serhat Merak