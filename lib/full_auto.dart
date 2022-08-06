import 'package:flutter/material.dart';

class FullAuto extends StatefulWidget {
  const FullAuto({Key? key}) : super(key: key);

  @override
  State<FullAuto> createState() => _FullAutoState();
}

class _FullAutoState extends State<FullAuto> {
  bool _isDragUp = true;
  bool _inProcess = true;
  double _bodyHeight = 0.0;
  final double _headerHeight = 40.0;
  final double _maxHeight = 600.0;
  double _minHeight = 0.0;

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              print("tap");
              if (this._minHeight == 0.0) {
                this._minHeight = 30.0;
              } else {
                this._minHeight = 0.0;
              }
              this.setState(() {});
            },
            child: Center(child: Text("Custom Scrollable Bottom Sheet ")),
          ),
          Positioned(
            bottom: 0.0,
            child: AnimatedContainer(
                constraints: BoxConstraints(
                  maxHeight: this._maxHeight,
                  minHeight: this._headerHeight + this._minHeight,
                ),
                curve: Curves.easeOut,
                height: this._headerHeight + this._bodyHeight,// 36.0 + _height < 36.0 ? 36.0 : 36.0 + _height,
                duration: Duration(milliseconds: 600),
                child: GestureDetector(
                  onVerticalDragUpdate: (DragUpdateDetails data) {
                    /*
                    data.globalPosition.dy starts at bottom of the screen for us, so the more we drag up, the smaller the value gets
                    initially, _size.height - data.globalPosition.dy = 0
                     */
                    double _draggedAmount = _size.height - data.globalPosition.dy;
                    if (_isDragUp){
                      /// need this portion to let it be dragged along with your finger
                      if (_draggedAmount < 20.0) this._bodyHeight = _draggedAmount;
                      /// once it goes up a little bit, automatically goes up
                      /// but without this._inProcess, it will go up forever
                      if (_draggedAmount > 20.0) this._bodyHeight = 550.0;
                    } else {

                      double _height = this._maxHeight - this._headerHeight;
                      double _amountLeft = _size.height - data.globalPosition.dy;
                      // max height is at 600.0 - height of header = _size.height - data.globalPosition.dy
                      if (_height - _amountLeft < 20.0) this._bodyHeight = _amountLeft;
                      if (_height - _amountLeft > 20.0) this._bodyHeight = 0.0;
                    }
                    this.setState(() {});
                  },
                  onVerticalDragEnd: (DragEndDetails data){

                    if (_isDragUp) {
                      this._isDragUp = false;
                    } else {
                      if (data.primaryVelocity != null) this._bodyHeight = 0.0;// 조금만 건드려도 내려가게
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
                              topRight: Radius.circular(33.0),
                              topLeft: Radius.circular(33.0),
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