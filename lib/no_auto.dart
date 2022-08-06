
import 'package:flutter/material.dart';

class NoAuto extends StatefulWidget {
  const NoAuto({Key? key}) : super(key: key);

  @override
  State<NoAuto> createState() => _NoAutoState();
}

class _NoAutoState extends State<NoAuto> {
  bool _isDragUp = true;
  bool _isFinished = true;
  double _height = 0.0;
  final double _headerHeight = 40.0;

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
                  maxHeight: 600.0,
                  minHeight: this._headerHeight,
                ),
                curve: Curves.easeOut,
                height: this._headerHeight + this._height,// 36.0 + _height < 36.0 ? 36.0 : 36.0 + _height,
                duration: Duration(milliseconds: 600),
                child: GestureDetector(
                  onVerticalDragUpdate: (DragUpdateDetails data) {

                    if (_isDragUp){
                      print("going up");
                      if (_size.height - data.globalPosition.dy < 110.0) {
                        this.setState(() {
                          this._height = _size.height - data.globalPosition.dy;
                        });
                      }
                      if (_size.height - data.globalPosition.dy > 110.0 && _isFinished) {
                        this.setState(() {
                          _isFinished = false;
                          this._height = 550.0;
                        });
                      }
                    } else {
                      print("going down");
                      if (_size.height - data.globalPosition.dy > 400.0) {
                        this.setState(() {
                          this._height = _size.height - data.globalPosition.dy;
                        });
                      }

                      if (_size.height - data.globalPosition.dy < 400.0  && _isFinished ) {
                        this.setState(() {
                          this._height = 0.0;
                          _isFinished = false;
                        });
                      }
                    }

                  },
                  onVerticalDragEnd: (DragEndDetails data){
                    print("end");
                    if (_isDragUp) {
                      this.setState(() {
                        this._isDragUp = false;
                        this._isFinished = true;
                      });
                    } else {
                      this.setState(() {
                        this._isDragUp = true;
                        this._isFinished = true;
                      });
                    }
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