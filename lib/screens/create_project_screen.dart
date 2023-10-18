import 'package:animation/common/round_elevated_button.dart';
import 'package:animation/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'background_screen.dart';
import 'home_screen.dart';
class CreateProjectScreen extends StatefulWidget {
   CreateProjectScreen({Key? key}) : super(key: key);

  @override
  State<CreateProjectScreen> createState() => _CreateProjectScreenState();
}

class _CreateProjectScreenState extends State<CreateProjectScreen> {
  TextEditingController _gifNameController = TextEditingController();
  int Pageindex=6;
  int CanvasPageindex=0;
  PageController _CanvasPageController = PageController(
    viewportFraction: 0.19,
    initialPage: 6,
  );
  PageController _pageController = PageController(
   viewportFraction: 0.19,
   initialPage: 6,
   );
  List canvasSize=["1:1","4:3","16:9"];
  double screenWidth=0.0;
  double screenHeight=0.0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    screenWidth=MediaQuery.of(context).size.width;
    screenHeight=MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: ColorConstants.backgroundColor,
      appBar: AppBar(title: Text("Create Project")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SizedBox(
            height: screenHeight-100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text("Project name",style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: ColorConstants.black54,
                    fontSize: 16,
                  ),),
                ),
                TextField(
                  controller:_gifNameController,
                  decoration: InputDecoration(
                    hintText: "Gif name",
                    hintStyle: TextStyle(
                     color: ColorConstants.black54.withOpacity(0.2)
                    )
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text("Select Bbackground",style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: ColorConstants.black54,
                    fontSize: 16,
                  ),),
                ),
                InkWell(
                  onTap: ()
                  {
                    Get.to(()=>BackgroundScreen());
                  },
                  child: Container(
                    height: 150,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)

                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text("Select frames per second",style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: ColorConstants.black54,
                    fontSize: 16,
                  ),),
                ),
                Container(
                  height: 60,
                 decoration: BoxDecoration(
                   color: ColorConstants.greyCOlor,
                   borderRadius: BorderRadius.circular(10),
                 ),
                  child:Column(
                    children: [
                      Center(
                        child: SizedBox(
                          width: 70,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 21,left: 10),
                              child: Divider(color: Colors.teal,thickness: 2),
                            )),

                      ),
                      SizedBox(
                        height: 40,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: PageView.builder(
                            controller: _pageController,
                            itemCount: 24,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                child: Text("${index} fps",
                                style: TextStyle(
                                  fontWeight:FontWeight.w900,
                                  color:Pageindex==index?Colors.black:ColorConstants.black54.withOpacity(0.5)
                                ),
                                ),

                              );
                            },
                            onPageChanged: (index)
                            {
                              setState(() {
                                Pageindex=index;
                              });
                              print("INDEX ${index}");
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text("Select frames per second",style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: ColorConstants.black54,
                    fontSize: 16,
                  ),),
                ),
                Container(
                  height: 60,
                  decoration: BoxDecoration(
                    color: ColorConstants.greyCOlor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child:Column(
                    children: [
                      Center(
                        child: SizedBox(
                            width: 70,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 21,left: 10),
                              child: Divider(color: Colors.teal,thickness: 2),
                            )),

                      ),
                      SizedBox(
                        height: 40,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: PageView.builder(
                            controller: _CanvasPageController,
                            itemCount: canvasSize.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                child: Text("${canvasSize[index]}",
                                  style: TextStyle(
                                      fontWeight:FontWeight.w900,
                                      color:CanvasPageindex==index?Colors.black:ColorConstants.black54.withOpacity(0.5)
                                  ),
                                ),

                              );
                            },
                            onPageChanged: (index)
                            {
                              setState(() {
                                CanvasPageindex=index;
                              });
                              print("INDEX ${index}");
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(child: RoundElevatedButton(BackGroundColor: ColorConstants.buttonBackgroundColor,
                        ButtonText: "Create Project", TextColor:Colors.white,
                        ButtonPadding: EdgeInsets.only(top: 15,bottom: 15),
                        onTap: (){
                      Get.to(()=>DrawingBoardsScreen());
                        },
                        BorderColor: null)),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
