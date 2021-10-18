import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/src/constant/app_colors.dart';
import 'package:test/src/widgets/button.dart';
import 'package:test/src/widgets/triangle.dart';
import 'package:test/src/provider/home_provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {

  @override
  void initState() {
    final provider = Provider.of<HomeProvider>(context, listen: false);
    provider.blueController = AnimationController(vsync: this, duration: const Duration(seconds: 2));
    provider.pinkController = AnimationController(vsync: this, duration: const Duration(seconds: 2));
    provider.pinkController.addListener(() {
      provider.updateTime(context,provider.pinkController,'pink');
    });
    provider.blueController.addListener(() {
      provider.updateTime(context,provider.blueController,'blue');
    });
    provider.randomColor();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomeProvider>(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: OrientationBuilder(
        builder: (context, orientation){
          if (orientation == Orientation.portrait) {
            return Column(
              children: [
                box(size,provider,orientation),
                GestureDetector(
                  onTap: () => provider.showTutorial('กดปุ่มสีที่ตรงกัน\nค้างไว้ 2 วินาที\nเพื่อทำลาย Block'),
                  child: Container(
                    height: size.height * 0.1625,
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Button(
                          controller: provider.pinkController,
                          colorIsPink: true,
                          showText: provider.showText,
                          orientation: orientation,
                        ),
                        Button(
                          controller: provider.blueController,
                          colorIsPink: false,
                          showText: provider.showText,
                          orientation: orientation,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            );
          } else {
            return Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  width: size.width * 0.1625,
                  height: size.height,
                  color: Colors.white,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Button(
                      controller: provider.pinkController,
                      colorIsPink: true,
                      showText: provider.showText,
                      orientation: orientation,
                    ),
                  ),
                ),
                Container(
                  width: size.width * 0.675,
                  color: AppColors.grey,
                  child: box(size,provider,orientation),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  width: size.width * 0.1625,
                  height: size.height,
                  color: Colors.white,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Button(
                      controller: provider.blueController,
                      colorIsPink: false,
                      showText: provider.showText,
                      orientation: orientation,
                    ),
                  ),
                )
              ],
            );
          }
        }
      ),
    );
  }

  Widget box(Size size,HomeProvider provider,Orientation orientation) {
    return Container(
      height: orientation == Orientation.portrait ? size.height * 0.8375 : size.height,
      width: size.width,
      color: AppColors.grey,
      child: ListView.separated(
        separatorBuilder: (context, index) => const SizedBox(height: 5),
        reverse: true,
        itemCount: provider.boxs.length,
        itemBuilder: (context , i ) {
          Map<String,dynamic> data = provider.boxs[i];
          return Padding(
            padding: EdgeInsets.only(bottom: i == 9 ? orientation == Orientation.portrait ? 20 : 30 : 0),
            child: !data['status'] ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (provider.currentLevel == i)
                  const Triangle(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: i == 9 ? orientation == Orientation.portrait ? 25 : 35 : 5),
                  child: RotationTransition(
                    turns: AlwaysStoppedAnimation(data['color'] == 'purple' ? 45 / 360 : 0 / 360),
                    child: Container(
                      width: orientation == Orientation.portrait ? size.width * 0.3 : (size.width * 0.675) * 0.3,
                      height: data['color'] == 'purple' ? orientation == Orientation.portrait ? size.width * 0.3 : (size.width * 0.675) * 0.3 : orientation == Orientation.portrait ? size.height * 0.1 : size.height * 0.2,
                      decoration: BoxDecoration(
                        color: data['color'] == 'pink' ? AppColors.pink : data['color'] == 'blue' ? AppColors.blue : AppColors.purple,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black)
                      )
                    ),
                  ),
                ),
                if (provider.currentLevel == i)
                  const Triangle(left: false),
              ],
            ) : Container(),
          );
        }
      ),
    );
  }
}