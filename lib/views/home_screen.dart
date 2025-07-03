import 'package:flutter/material.dart';
import 'package:test_app/widgets/bottom_overlay_bar.dart';
import 'package:test_app/widgets/custom_bottom_sheet.dart';
import 'package:test_app/widgets/custom_button.dart';
import 'package:test_app/widgets/webview_with_loader.dart';


class HomeScreen extends StatefulWidget{
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool showBottomPart = false;

  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.sizeOf(context).height;
    
    return Scaffold(
      appBar: null,
      backgroundColor: Colors.greenAccent[100],
      body: Stack(
        children: [ 
          Center(
          child: CustomButton(text: "Open Modal", onPressed: showCustomBottomSheetHomeScreen),
          ),
          showBottomPart ? 
          BottomOverlayBar(height: height*0.1, 
          onOpen: showCustomBottomSheetHomeScreen, 
          onClose: () => {
            setState(() {
                showBottomPart = false;
              })
          }) : Container()
        ]
      ),
    );
  }

  void showCustomBottomSheetHomeScreen() {
    showCustomBottomSheet(
      context: context,
      child: Stack( children: [
      Positioned(
        top: 0,
        left: 0,
        right: 0,
        bottom: 0,
       child: WebViewWithLoader(url: 'https://flutter.dev',),)]),

        onClose: (isVisible) => setState(() {
          showBottomPart = isVisible;
        }),
    );
  }
  
  }
