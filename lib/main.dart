import 'package:flutter/material.dart';
import 'package:untitled/full_auto.dart';

void main() => runApp(Mooky());

class Mooky extends StatelessWidget {
  const Mooky({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Main());
  }
}

class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  bool _isDragUp = true;
  double _bodyHeight = 0.0;
  final double _headerHeight = 40.0;
  final double _maxHeight = 600.0;

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Center(child: Text("Custom Scrollable Bottom Sheet ")),
          Positioned(
            bottom: 0.0,
            child: AnimatedContainer(
              constraints: BoxConstraints(
                maxHeight: this._maxHeight,
                minHeight: this._headerHeight,
              ),
              curve: Curves.easeOut,
              height: this._headerHeight + this._bodyHeight,
              duration: Duration(milliseconds: 400),
              child: GestureDetector(
                onVerticalDragUpdate: (DragUpdateDetails data) {
                  double _draggedAmount = _size.height - data.globalPosition.dy;
                  if (this._isDragUp){
                    if (_draggedAmount < 100.0) this._bodyHeight = _draggedAmount;
                    if (_draggedAmount > 100.0) this._bodyHeight = this._maxHeight;
                  } else {
                    /// the _draggedAmount cannot be higher than maxHeight b/c maxHeight is _dragged Amount + header Height
                    double _downDragged = this._maxHeight - _draggedAmount;
                    if (_downDragged < 100.0) this._bodyHeight = _draggedAmount;
                    if (_downDragged > 100.0) this._bodyHeight = 0.0;
                  }
                  this.setState(() {});
                },
                onVerticalDragEnd: (DragEndDetails data){
                  if (_isDragUp) {
                    this._isDragUp = false;
                  } else {
                    this._isDragUp = true;
                  }
                  this.setState(() {});
                },
                child: Column(
                  children: <Widget>[
                    Container(
                      width: _size.width,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.lightBlue,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20.0),
                          topLeft: Radius.circular(20.0),
                        ),
                        boxShadow: <BoxShadow>[
                          BoxShadow(color: Colors.grey, spreadRadius: 2.0, blurRadius: 4.0),
                        ]
                      ),
                      height: this._headerHeight,
                      child: Text("drag me"),
                    ),
                    Expanded(
                      child: Container(
                        width: _size.width,
                        color: Colors.greenAccent,
                        alignment: Alignment.center,
                        child: Text("it worked!"),
                      ),
                    ),
                  ],
                ),
              )),
          ),
        ],
      ),
    );
  }
}

/*
// if (_isDragUp){
                  //   this._height = _size.height - data.globalPosition.dy;
                  //   print("going up");
                  //   if (_size.height - data.globalPosition.dy < 110.0) {
                  //     this.setState(() {
                  //       this._height = _size.height - data.globalPosition.dy;
                  //     });
                  //   }
                  //   if (_size.height - data.globalPosition.dy > 110.0 && _isFinished) {
                  //     this.setState(() {
                  //       _isFinished = false;
                  //       this._height = 550.0;
                  //     });
                  //   }
                  // } else {
                  //   print("going down");
                  //   if (_size.height - data.globalPosition.dy > 400.0) {
                  //     this.setState(() {
                  //       this._height = _size.height - data.globalPosition.dy;
                  //     });
                  //   }
                  //
                  //   if (_size.height - data.globalPosition.dy < 400.0  && _isFinished ) {
                  //     this.setState(() {
                  //       this._height = 0.0;
                  //       _isFinished = false;
                  //     });
                  //   }
                  // }

 */
