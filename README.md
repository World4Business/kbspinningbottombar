# KB Spinning Bottom Bar

An easy to implement Spin Circle Bottom Navigation Bar for Flutter Applications.

## Current Features

* Initial Release for Spin Circle Bottom Bar
* Customizable Tab Icon and Text for both Active and Inactive State
* Customize colors for Spin Circle
* Customize Bottom Bar and Spin Circle Item Count

## Demo
![](https://github.com/retroportalstudio/spincircle_bottom_bar/blob/master/spincircle_bottom_bar.gif)

## Usage
To Use, simply add SpinCircleBottomBarHolder to your Scaffold's body, as follows:

```dart
import 'package:flutter/material.dart';
import 'package:kbspinningbottombar/kbspinningbottombar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Spin Circle Bottom Bar',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("RetroPortal Studio"),
          backgroundColor: Colors.deepOrangeAccent,
        ),
        //Adding SpinCircleBottomBarHolder to body of Scaffold
        body: SpinCircleBottomBarHolder(
          bottomNavigationBar: SCBottomBarDetails(
              circleColors: [Colors.white, Colors.orange, Colors.redAccent],
              iconTheme: IconThemeData(color: Colors.black45),
              activeIconTheme: IconThemeData(color: Colors.orange),
              backgroundColor: Colors.white,
              titleStyle: TextStyle(color: Colors.black45, fontSize: 12),
              activeTitleStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.bold),
              actionButtonDetails: SCActionButtonDetails(
                  activeWidget: Icon(Icons.expand_less_outlined, color: Colors.white),
                  closeWidget: Icon(Icons.close, color: Colors.white),
                  actionButtonText: "Royalty"
              ),
              shadow: [],
              elevation: 2.0,
              items: [
                // Suggested count : 4
                SCBottomBarItem(
                    icon: Icons.verified_user, title: "User", onPressed: () {}),
                SCBottomBarItem(
                    icon: Icons.supervised_user_circle,
                    title: "Details",
                    onPressed: () {}),

                SCBottomBarItem(
                    icon: Icons.notifications,
                    title: "Notifications",
                    onPressed: () {}),
                SCBottomBarItem(
                    icon: Icons.details, title: "New Data", onPressed: () {}),
              ],
              circleItems: [
                //Suggested Count: 3
                SCItem(icon: Icon(Icons.add), onPressed: () {}),
                SCItem(icon: Icon(Icons.print), onPressed: () {}),
                SCItem(icon: Icon(Icons.map), onPressed: () {}),
              ],
              bnbHeight: 80 // Suggested Height 80
          ),
          child: Container(
            color: Colors.orangeAccent.withAlpha(55),
            child: Center(
              child: Text("Isn't this Awesome!"),
            ),
          ),
        ),
      ),
    );
  }
}

```

## Roadmap
Plans to add more customizations.

## License
[MIT](https://choosealicense.com/licenses/mit/)


### orginal library [spincircle_bottom_bar](https://pub.dev/packages/spincircle_bottom_bar) we just update some function.