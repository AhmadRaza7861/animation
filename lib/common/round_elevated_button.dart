import 'package:flutter/material.dart';
class RoundElevatedButton extends StatelessWidget {
  RoundElevatedButton({
    required this.BackGroundColor,
    required this.ButtonText,
    required this.TextColor,
    required this.ButtonPadding,
    required this.onTap,
    required this.BorderColor,
     this.isLoading=false,
    this.minimumSize=null,
    this.isBoldText=false,
    super.key,
  });
  final String ButtonText;
  final Color BackGroundColor;
  final Color TextColor;
  final VoidCallback onTap;
  EdgeInsets? ButtonPadding;
  Color? BorderColor;
  bool isLoading;
  Size? minimumSize;
  bool isBoldText;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed:onTap,
        style:ElevatedButton.styleFrom(
          elevation:BackGroundColor==Colors.transparent?0:4.0,
            backgroundColor:BackGroundColor,
            padding: ButtonPadding,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
              side: BorderSide(
                color:BorderColor??Colors.transparent,
                width: 2.0
              ),
            ),
          minimumSize: minimumSize
        ), child:isLoading? Center(child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
            child: CircularProgressIndicator(color: Colors.white),
        width: 25,
          height: 25,
        ),
        SizedBox(width: 24,),
        Text("Please Waite ...",
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w400,
        ),
        )
      ],
    ),):
    Text(ButtonText,
        style: TextStyle(
          color: TextColor,
          fontSize: 16,
          fontWeight: isBoldText?FontWeight.bold:null,
        ))
    );
  }
}