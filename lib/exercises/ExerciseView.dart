import 'dart:async';
import 'package:body_detection/models/pose.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:tele_rehabilitation/exercises/verify_pose.dart';

import 'pose_mask_painter.dart';


class ExerciseView extends StatefulWidget {
  const ExerciseView({Key? key}) : super(key: key);

  @override
  State<ExerciseView> createState() => _MyAppState();
}

class _MyAppState extends State<ExerciseView> {
  Timer? timer;
  VerifyPose poseVerifier = VerifyPose();

  int count = 0;
  Pose? _detectedPose;
  Image? _cameraImage;
  Size _imageSize = Size.zero;


  @override
  void initState() {
    super.initState();
    poseVerifier.initPoseVerification();
    timer = Timer.periodic(Duration(milliseconds: 10), (Timer t) => checkState());

  }

  @override
  void dispose() {
    super.dispose();
    poseVerifier.closePoseVerification();
    timer?.cancel();
  }

  checkState(){
    setState(() {
      _cameraImage = poseVerifier.image;
      _imageSize = poseVerifier.size;
    });
    setState(() {
      _detectedPose = poseVerifier.pose;
    });
    setState(() {
      count = poseVerifier.count;
    });
  }

  Widget get _cameraDetectionView => SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              ClipRect(
                child: CustomPaint(
                  child: _cameraImage,
                  foregroundPainter: PoseMaskPainter(
                    pose: _detectedPose,
                    mask: poseVerifier.maskImage,
                    imageSize: _imageSize,
                    shouldColourGreen: poseVerifier.movementCheck,
                  ),
                ),
                ),

              Text(count.toString(), textAlign: TextAlign.left),
            ],
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Exercises Screen'),
        ),
        body: _cameraDetectionView,

      ),
    );
  }


}
