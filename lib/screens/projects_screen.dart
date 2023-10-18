import 'package:animation/constants/colors.dart';
import 'package:animation/main.dart';
import 'package:animation/projects_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'create_project_screen.dart';
import 'home_screen.dart';
class ProjectsScreen extends StatefulWidget {
   ProjectsScreen({Key? key}) : super(key: key);

  @override
  State<ProjectsScreen> createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen> {
  double screenHight=0.0;
  late ProjectsDatabase allprojects;
  double screenWidth=0.0;
  bool isProjects=true;
  @override
  void initState() {
    if(box.get("AllProjects")!=null)
      {
        allprojects=box.get("AllProjects");
        print("AllProjects ${allprojects}");
      }
    else
      {
        isProjects=false;
      }
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    screenHight=MediaQuery.of(context).size.height;
    screenWidth=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor:ColorConstants.backgroundColor ,
      appBar:
      AppBar(
        title: Text("Projects",style: TextStyle(fontWeight: FontWeight.w600)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            InkWell(
              onTap: (){
                Get.to(()=>CreateProjectScreen());
              },
              child: Container(
                height: screenHight/3*0.7,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20)

                ),
                child: const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.add,color:ColorConstants.greyCOlor,size: 60,weight: 120,),
                      Text("Create a project",style: TextStyle(
                        color: ColorConstants.greyCOlor,
                        fontWeight: FontWeight.w700,
                        fontSize: 20
                      ),)
                    ],
                  ),
                ),
              ),
            ),
      SizedBox(height: 30,),
            isProjects? Expanded(
        child: GridView.builder(

          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            // Number of columns in the grid
            crossAxisCount: 2,
            mainAxisSpacing: 5,
            crossAxisSpacing: 10
          ),
          itemBuilder: (BuildContext context, int index) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: InkWell(
                onTap: ()
                {
                  Get.to(()=>DrawingBoardsScreen(isRedraw: true,projectName: allprojects.projectName[index],));
                },
                child: Stack(
                  children: [
                    Image.memory(allprojects.image[index],fit: BoxFit.fill),
                   Padding(
                     padding: const EdgeInsets.only(top: 15,bottom: 5,),
                     child: Column(
                       children: [
                         Icon(Icons.add,size: 14),
                         Padding(
                           padding: const EdgeInsets.only(top: 5,left: 10),
                           child: Text(
                             '${allprojects.projectName[index]}',
                             style: TextStyle(fontSize: 16),
                           ),
                         )
                       ],
                     ),
                   )
                  ],
                ),
              ),
            );
          },
          // Specify the total number of items in the grid
          itemCount: allprojects.projectName.length,
        ),
      ):Container()
          ],
        ),
      ),
    );
  }
}
