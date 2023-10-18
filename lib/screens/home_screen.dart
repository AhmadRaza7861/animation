import 'dart:io';
import 'dart:typed_data';

import 'package:animation/paint_contents.dart';
import 'package:animation/projects_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gif/flutter_gif.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'dart:convert';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import '../flutter_drawing_board.dart';
import '../gif_screen.dart';
import '../helpers.dart';
import '../main.dart';
import '../sketch_data_base.dart';

class DrawingBoardsScreen extends StatefulWidget {
  bool isRedraw;
  String projectName;

  DrawingBoardsScreen({this.isRedraw=false,this.projectName=""});

  @override
  _DrawingBoardsScreenState createState() => _DrawingBoardsScreenState();
}

class _DrawingBoardsScreenState extends State<DrawingBoardsScreen> {
  List<DrawingController> _controllers = [DrawingController()];
  List<Uint8List> imagesList=[];
  Uint8List? imageData;
  int currentIndex = 0;
  int pageIndex=0;
  PageController _pageController = PageController(
    viewportFraction: 0.5,
    initialPage: 0,
  );
  PageController _drawingPageController = PageController(
     initialPage: 0,
  );
  late SketchDatabase sketchDatabase;
  @override
  void initState() {
    super.initState();
    if(widget.isRedraw)
      {
         sketchDatabase=box.get(widget.projectName);
         imagesList=sketchDatabase.imagesList;
         for(int i=0;i<sketchDatabase.sketchdata.length-1;i++)
           {
             _controllers.add(DrawingController());
           }
         List data2=json.decode(sketchDatabase.sketchdata.toString());
         print("DATA ${data2}");
         for (int i=0;i<data2.length;i++) {
           data2[i].forEach((element) {
             print("ELEMENT ${element["type"]}");
             if(element["type"]=="SimpleLine")
             {
               _controllers[i].addContent(SimpleLine.fromJson(element));
             }
             else if(element["type"]=="Circle")
             {
               _controllers[i].addContent(Circle.fromJson(element));
             }
             else if(element["type"]=="Rectangle")
             {
               _controllers[i].addContent(Rectangle.fromJson(element));
             }
             else if(element["type"]=="StraightLine")
             {
               _controllers[i].addContent(StraightLine.fromJson(element));
             }
             else if(element["type"]=="Eraser")
               {
                 _controllers[i].addContent(Eraser.fromJson(element));
               }
           });
         }
      }
    // Add an initial drawing board
  //  _addNewDrawingBoard();
  }

  void _addNewDrawingBoard() {
    setState(() {
      _controllers.add(DrawingController());
      imagesList.add(Uint8List(0));
      _pageController.animateToPage(_controllers.length, duration: Duration(seconds: 1), curve:Curves.easeIn);
      _drawingPageController.animateToPage(_controllers.length, duration: Duration(seconds: 1), curve:Curves.easeIn);
      // if(index!=0)
      // {
      //   index++;
      // }
    });
  }

  void _saveDrawingData(int index) {
    // Convert drawing data to JSON and save it
    String jsonData = jsonEncode(_controllers[index].getJsonList());
    // Save jsonData to your storage or database
    print('Saved Drawing Data: $jsonData');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      //  title: Text('Drawing Boards'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: (){
              _saveGif(imagesList);
            }, child: Text("press")),
            _buildDefaultActions,
            Expanded(
              child: PageView.builder(
                controller:_drawingPageController,
                 physics: NeverScrollableScrollPhysics(),
                itemCount: _controllers.length,
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Align(
                          child: Container(height: 50,decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Colors.cyan),),
                      alignment: Alignment.topCenter,
                      ),
                      SizedBox(height: 20,),
                      SizedBox(
                        child: AspectRatio(
                          aspectRatio: 1.3,
                          child:DrawingBoardWidget(controller: _controllers[index]) ,
                        ),
                        height: 300,
                      ),
                      SizedBox(height: 20,),
                      Container(height: 50,decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Colors.cyan),),

                      // SizedBox(
                      //     height: 300,
                      //     child:
                      //     DrawingBoardWidget(controller: _controllers[index])
                      // ),
                      SizedBox(height: 20),
                    ],
                  );
                },
                onPageChanged: (index)
                {
                  print("Current index ${index}");
                  setState(() {
                    currentIndex = index; // Update the currentIndex variable
                  });
                },
              ),
            ),
    //         ElevatedButton(onPressed: ()async{
    //           List<String> jsondata=[];
    //           for(int i=0;i<_controllers.length;i++)
    //             {
    //               jsondata.add(JsonEncoder.withIndent('  ')
    //                   .convert(_controllers[i].getJsonList()).toString());
    //             }
    //           SketchDatabase sketckData=SketchDatabase(projectName: 'project1', sketchdata: jsondata,imagesList: imagesList);
    //           box.put("project2",sketckData);
    //           box.put("AllProjects", ProjectsDatabase(projectName:["project1","project2"], category: ["GIF"], image: [imagesList[0],imagesList[0]]));
    //
    //           SketchDatabase name = box.get('project1');
    //
    //           print('Name: ${name.sketchdata}');
    //         }, child: Text("Save")),
    //         ElevatedButton(onPressed: ()async{
    //           ProjectsDatabase AllProjects=box.get("AllProjects");
    //           print("DATA ${AllProjects.projectName}");
    //           SketchDatabase sketchDatabase= box.get("project1");
    //          // Uint8List imagedata= box.get("imageData",);
    //          // setState(() {
    //          //   imagesList.add(imagedata);
    //          // });
    //           //print("DATA DATA ${sketchDatabase.sketchdata[0]}");
    //           var data=sketchDatabase.sketchdata;
    //           List data2=json.decode(data.toString());
    //           print("DATA ${data2}");
    // for (int i=0;i<data2.length;i++) {
    //   data2[i].forEach((element) {
    //     print("ELEMENT ${element["type"]}");
    //     if(element["type"]=="SimpleLine")
    //       {
    //         _controllers[i].addContent(SimpleLine.fromJson(element));
    //       }
    //     else if(element["type"]=="Circle")
    //       {
    //         _controllers[i].addContent(Circle.fromJson(element));
    //       }
    //   });
    // }
    //
    //         }, child: Text("Get data")),
    //         ElevatedButton(onPressed: ()async{
    //           List<img.Image> images = [];
    //
    //           for(int i=0;i<imagesList.length;i++)
    //             {
    //               img.Image? image = img.decodeImage(imagesList[i]);
    //               images.add(image!);
    //             }
    //
    //           // Create a GIF from the list of images
    //           img.GifEncoder encoder = img.GifEncoder();
    //           for (img.Image image in images) {
    //             encoder.addFrame(image);
    //           }
    //           final document = await getApplicationDocumentsDirectory();
    //          // File(document.path).writeAsBytesSync(encoder.finish() as List<int>);
    //           print("success");
    //         }, child: Text("GIF")),
            SizedBox(
              height: 120,
              child: Row(
                children: [
                  Expanded(
                    child: PageView.builder(
                        controller: _pageController,
                        scrollDirection: Axis.horizontal,
                        itemCount:_controllers.length,
                        onPageChanged: (index)
                        {
                         setState(() {
                           pageIndex=index;
                           _drawingPageController.animateToPage(index, duration: Duration(microseconds: 100), curve: Curves.easeIn);

                         });
                        },
                        itemBuilder: (context,index)
                        {
                          return CenteredItem(index: index,Pageindex:pageIndex ,pageController: _pageController,drawingBoardPageController: _drawingPageController,imageData: imagesList,currentIndex: currentIndex,);
                            //imageData==null?Container(height: 90,width: 120,color: Colors.red,):Image.memory(imageData!);
                        }
                    ),
                  ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap:_addNewDrawingBoard,
          child: Container(width: 70,height: 100,child: Center(child: Icon(Icons.add)),decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(20)
          ),),
        ),
      )
                ],
              ),
            ),
            SizedBox(height: 20,)
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _addNewDrawingBoard,
      //   child: Icon(Icons.add),
      // ),
    );
  }

  Widget DrawingBoardWidget({required DrawingController controller})
  {
    return DrawingBoard(
      // boardPanEnabled: false,
      // boardScaleEnabled: false,
      controller: controller,
      background: Container(
        height: 300,
        width: MediaQuery.of(context).size.width,
       child:Image.asset("assets/backgrounds/bg_1.png",fit: BoxFit.fill) ,
      ),
      //Image.asset("assets/backgrounds/bg_1.png"),
       showDefaultActions: true,
       showDefaultTools: true,
      onPointerUp: (e)async
      {
        print("ON INTERATION END");
        imageData=
            (await controller.getImageData())?.buffer.asUint8List();
        print("LENGTH 1 ${imagesList.length}");
        if(currentIndex==imagesList.length)
          {
            imagesList.add(imageData!);
            print("COntroll enter");
          }
        else
          {
            imagesList[currentIndex]=imageData!;
          }

        print("LENGTH ${imagesList.length}");
        setState(() {
        });

      },
      clipBehavior: Clip.hardEdge,
      boardClipBehavior: Clip.hardEdge,
    );
  }
  Future<void> _saveGif(List<Uint8List> imageList) async {
    print("jkhjkhjk ${imagesList.length}");
    var status = await Permission.storage.request();
    if (status.isGranted) {
      var downloadsDir = await getExternalStorageDirectories();

      List<img.Image> images = [];

      for (var bytes in imageList) {
        img.Image? image = img.decodeImage(Uint8List.fromList(bytes));
        images.add(image!);
      }

// Create a GifEncoder instance
      img.GifEncoder encoder = img.GifEncoder();

      // Set the animation delay to 100 ms
     // encoder.setDelay(100);

      // // Get the encoded GIF bytes
      // Uint8List? gifBytes = encoder.finish();


// Add the images to the encoder
      for (var image in images) {
        encoder.addFrame(image);
      }


// Get the encoded GIF bytes
      Uint8List? gifBytes = encoder.finish();

      print("nj  $gifBytes");
       var file = File('${downloadsDir![0].path}/animated.gif');
      await file.writeAsBytes(gifBytes!);
      Get.to(()=>GifScreen(gifBites: gifBytes,));
      print("PATH PATH ${file.path}");
     //  await file.writeAsBytes(Uint8List.fromList(imageList.expand((i) => i).toList()));
      // // Show a toast or snackbar indicating the file path, or open a share dialog
      // // to allow the user to share the GIF file.
      // print('GIF saved: ${file.path}');
    } else {
      print('Permission denied');
    }
  }

  Widget get _buildDefaultActions {
    return Material(
      color: Colors.white,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.zero,
        child: Row(
          children: <Widget>[
            IconButton(onPressed: (){
              _controllers[1].setStyle(color:Colors.green );
              _controllers[0]=_controllers[1];
            }, icon: Icon(Icons.add)),
            SizedBox(
              height: 24,
              width: 160,
              child: ExValueBuilder<DrawConfig>(
                valueListenable: _controllers[0].drawConfig,
                shouldRebuild: (DrawConfig p, DrawConfig n) =>
                p.strokeWidth != n.strokeWidth,
                builder: (_, DrawConfig dc, ___) {
                  return Slider(
                    value: dc.strokeWidth,
                    max: 50,
                    min: 1,
                    onChanged: (double v) =>
                        _controllers[0].setStyle(strokeWidth: v),
                  );
                },
              ),
            ),
            IconButton(
                icon: const Icon(CupertinoIcons.arrow_turn_up_left),
                onPressed: () => _controllers[0].undo()),
            IconButton(
                icon: const Icon(CupertinoIcons.arrow_turn_up_right),
                onPressed: () => _controllers[0].redo()),
            IconButton(
                icon: const Icon(CupertinoIcons.rotate_right),
                onPressed: () => _controllers[0].turn()),
            IconButton(
                icon: const Icon(CupertinoIcons.trash),
                onPressed: () => _controllers[0].clear()),
          ],
        ),
      ),
    );
  }
}


class CenteredItem extends StatelessWidget {
  final int index;
  int Pageindex;
  PageController pageController;
  PageController drawingBoardPageController;
  List<Uint8List> imageData;
  int currentIndex;
  CenteredItem({required this.index,required this.Pageindex,required this.pageController,required this.drawingBoardPageController,required this.imageData,required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return
    InkWell(
      onTap: ()
      {
        pageController.animateToPage(index, duration: Duration(seconds: 1), curve:Curves.easeIn);
        drawingBoardPageController.animateToPage(index, duration: Duration(microseconds: 100), curve: Curves.easeIn);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: imageData.length>0 ?Stack(
            fit: StackFit.expand,
            children: [
              Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  child: imageData[index].length>12?Image.memory(imageData[index],fit: BoxFit.fill,):Container(color: Colors.cyan)),
              Positioned(top: 0,right: 0,child: Container(height: 20,width: 20,decoration: BoxDecoration(
                  color: Colors.green,
                borderRadius: BorderRadius.only(bottomLeft:Radius.circular(10)
                )
              ),child: Center(child:Text("${index+1}") ),)),
              //Text("INDEX $index"),
            ],
          ):Container(),
        ),
      ),
    );
  }

}