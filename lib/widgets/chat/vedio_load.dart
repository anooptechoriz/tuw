import 'package:flutter/material.dart';

class VideoLoadingWidget extends StatefulWidget {
  final Size size;

  const VideoLoadingWidget({Key? key, required this.size}) : super(key: key);

  @override
  State<VideoLoadingWidget> createState() => _VideoLoadingWidgetState();
}

class _VideoLoadingWidgetState extends State<VideoLoadingWidget> {
  

@override
void initState() {
   setState(() {
     
   });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.size.width * 0.6,
      height: 240,
      alignment: Alignment.center,
      child: CircularProgressIndicator(color: Colors.green,),    );
  }
}
