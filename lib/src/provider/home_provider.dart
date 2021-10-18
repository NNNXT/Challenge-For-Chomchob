import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomeProvider with ChangeNotifier, DiagnosticableTreeMixin {

  late List<dynamic> boxs;
  late int currentLevel;
  late Timer timer;
  late AnimationController pinkController,blueController;
  String showText = '🤔';
  int second = 0;
  bool  userTapPink = false,
        userTapBlue = false,
        userTabPinkComplete = false,
        userTapBlueComplete = false;

  randomColor() {
    boxs = [];
    currentLevel = 0;
    second = 0;
    for (int i = 0 ; i < 9 ; i++) {
      if (Random().nextBool()) {
        boxs.add({
          'color' : 'pink',
          'status' : false
        });
      } else {
        boxs.add({
          'color' : 'blue',
          'status' : false
        });
      }
    }
    boxs.add({
      'color' : 'purple',
      'status' : false
    });
  }

  tap(BuildContext context,String color) {
    if (currentLevel != 10) {
      if (boxs[currentLevel]['color'] == color) {
        boxs[currentLevel]['status'] = true;
        if(currentLevel == 0) {
          timer = Timer.periodic(const Duration(seconds: 1), (timer) {
            second++;
          });
        } else if (currentLevel == 8) {
          showTutorial('กดสองปุ่ม ค้างไว้ 2 วิ\nเพื่อทำลาย Block สุดท้าย');
        } else if (currentLevel == 9) {
          timer.cancel();
          userTapPink = false;
          userTapBlue = false;
          userTabPinkComplete = false;
          userTapBlueComplete = false;
          showDialogEndGame(context,'Total Time $second S');
        }
        currentLevel++;
        showText = '🎉';
        Future.delayed(const Duration(milliseconds: 1000), () {
          showText = '🤔';
          notifyListeners();
        });
      } else {
        showText = '😭';
        Future.delayed(const Duration(milliseconds: 1000), () {
          showText = '🤔';
          notifyListeners();
        });
      }
    }
  }

  resetGame() {
    randomColor();
    notifyListeners();
  }

  updateTime(BuildContext context,AnimationController controller,String color) {
    if (controller.status == AnimationStatus.completed) {
      controller.reset();
      if (color == 'blue') {
        userTapBlueComplete = true;
      } else {
        userTabPinkComplete = true;
      }
      if(userTabPinkComplete && userTapBlueComplete && userTapPink && userTapBlue) {
        color = 'purple';
        tap(context,color);
      } else {
        tap(context,color);
      }
    }
    notifyListeners();
  }

  onTapDown(bool colorIsPink) {
    if (colorIsPink) {
      userTapPink = true;
      pinkController.forward();
    } else {
      userTapBlue = true;
      blueController.forward();
    }
  }

  onTapUp(bool colorIsPink) {
    if (colorIsPink) {
      userTapPink = false;
      userTabPinkComplete = false;
      if (pinkController.status == AnimationStatus.forward) {
        pinkController.reverse();
      }
    } else {
      userTapBlue = false;
      userTabPinkComplete = false;
      if (blueController.status == AnimationStatus.forward) {
        blueController.reverse();
      }
    }
  }

  showTutorial(String text) {
    Fluttertoast.showToast(
      backgroundColor: Colors.black54,
      msg: text,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 2
    );
  }

  showDialogEndGame(BuildContext context,String text) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text('Total Time'),
          content: Text('$second s'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Reset')
            ),
          ],
        );
      }
    ).then((value) => {
      resetGame()}
    );
  }
}