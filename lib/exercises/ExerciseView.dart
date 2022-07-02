import 'dart:async';
import 'package:body_detection/models/pose.dart';
import 'package:flutter/material.dart';
import 'package:tele_rehabilitation/exercises/verify_pose.dart';
import 'package:tele_rehabilitation/model/exercise.dart';

import '../widgets/default_app_bar.dart';
import 'pose_mask_painter.dart';


class ExerciseView extends StatefulWidget {
  const ExerciseView(this._exercise, {Key? key}) : super(key: key);

  final Exercise _exercise;

  @override
  State<ExerciseView> createState() => _MyAppState();
}

class _MyAppState extends State<ExerciseView> {
  Timer? timer;
  late final VerifyPose poseVerifier = VerifyPose(widget._exercise);

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
      _detectedPose = poseVerifier.pose;
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
              const SizedBox(height: 70),
              Text(
                count.toString()+ '/'+ widget._exercise.count.toString(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontWeight: FontWeight. bold,
                    fontSize: 40,
                    fontFamily: 'proxima_ssv'),
                )
              ,
            ],
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text(
                 widget._exercise.type,
                 style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'proxima_ssv',
                  fontSize: 25,
                ),
              ),
        ),
        body: _cameraDetectionView,

      ),
    );
  }
}
