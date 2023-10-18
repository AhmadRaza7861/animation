import 'package:animation/constants/assets.dart';
import 'package:animation/constants/colors.dart';
import 'package:flutter/material.dart';
class BackgroundScreen extends StatelessWidget {
   BackgroundScreen({Key? key}) : super(key: key);
  double screenWidth=0.0;
  double screenHeight=0.0;
  @override
  Widget build(BuildContext context) {
    screenWidth=MediaQuery.of(context).size.width;
    screenHeight=MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(title: Text("Background")),
      body: Column(
        children: [
          SizedBox(height: 5,),
          Container(
            width:screenWidth/2*1.9 ,
            decoration: BoxDecoration(color: ColorConstants.buttonBackgroundColor.withOpacity(0.3),
            borderRadius: BorderRadius.circular(20)
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 5,bottom: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BackgroundOptions(icon: Icons.color_lens),
                  SizedBox(width: 20,),
                  BackgroundOptions(icon: Icons.image),
                  SizedBox(width: 20,),
                  BackgroundOptions(icon: Icons.camera_alt)
                ],
              ),
            ),
          ),
          SizedBox(height: 10,),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Number of columns
                childAspectRatio: 1.0, // Aspect ratio of each grid item
              ),
              itemCount: 20, // Number of items in the grid
              itemBuilder: (BuildContext context, int index) {
                return GridItem(index: index); // Returns a widget at the given index
              },
            ),
          ),
        ],
      )
    );
  }

  Container BackgroundOptions({required IconData icon}) {
    return Container(height: 50,width: 50,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Icon(icon,color: ColorConstants.black54),);
  }
}
class GridItem extends StatelessWidget {
  final int index;

  GridItem({required this.index});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: Image.asset(AssetsConstants.bg_1,fit: BoxFit.fitHeight,)
    );
  }
}