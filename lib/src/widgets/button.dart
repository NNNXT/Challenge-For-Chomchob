import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/src/constant/app_colors.dart';
import 'package:test/src/provider/home_provider.dart';

class Button extends StatelessWidget {
  const Button({
    Key? key,
    required this.controller,
    required this.colorIsPink,
    required this.showText,
    required this.orientation
  }) : super(key: key);

  final AnimationController controller;
  final bool colorIsPink;
  final String showText;
  final Orientation orientation;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomeProvider>(context);
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTapDown: (_) => provider.onTapDown(colorIsPink),
      onTapUp: (_) => provider.onTapUp(colorIsPink),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: colorIsPink ? AppColors.pink : AppColors.blue,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.black)
            ),
            height: orientation == Orientation.portrait ? size.height * 0.1 : size.width * 0.1,
            width: orientation == Orientation.portrait ? size.height * 0.1 : size.width * 0.1,
            child: Center(
              child: Text(
                showText,
                style: TextStyle(
                  fontSize: orientation == Orientation.portrait ? size.height * 0.04 : size.width * 0.04
                )
              )
            ),
          ),
          SizedBox(
            height: orientation == Orientation.portrait ? size.height * 0.1 : size.width * 0.1,
            width: orientation == Orientation.portrait ? size.height * 0.1 : size.width * 0.1,
            child: CircularProgressIndicator(
              value: controller.value,
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.orange),
            ),
          )
        ],
      ),
    );
  }
}