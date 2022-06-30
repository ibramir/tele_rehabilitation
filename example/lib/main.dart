import 'dart:async';
import 'package:body_detection/models/image_result.dart';
import 'package:body_detection/models/pose.dart';
import 'package:body_detection_example/MovementStrategies/DetectBothHandRaise.dart';
import 'package:body_detection_example/MovementStrategies/DetectLeftElbowBend.dart';
import 'package:body_detection_example/MovementStrategies/DetectLeftHandStretch.dart';
import 'package:body_detection_example/MovementStrategies/DetectRightElbowBend.dart';
import 'package:body_detection_example/MovementStrategies/DetectRightHandStretch.dart';
import 'package:body_detection_example/MovementStrategy.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:body_detection/body_detection.dart';
import 'package:permission_handler/permission_handler.dart';
import 'pose_mask_painter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Timer? timer;
  bool _isDetectingPose = false;
  bool _MovementCheck = false;
  bool _previousMovement = false;
  int count = 0;
  Pose? _detectedPose;
  ui.Image? _maskImage;
  Image? _cameraImage;
  Size _imageSize = Size.zero;
  MovementStrategy movement = DetectRightHandStretch() ;

  @override
  void initState() {
    super.initState();
    _startCameraStream();
    _startPoseDetection();
  }
  @override
  void dispose() {
    super.dispose();
    _stopCameraStream();
    _stopPoseDetection();
  }

  Future<void> _checkMovement(Pose currentPose) async{
    _MovementCheck = movement.validate(currentPose);
    if(_MovementCheck && !_previousMovement){
      count ++;
    }
    _previousMovement = _MovementCheck;
  }

  void resetCount(){
    count =0;
    _previousMovement = _MovementCheck = false;
  }

  void _setMovmentLeftHandStretch() {
    if(movement is DetectLeftHandStretch) return;
      movement =  DetectLeftHandStretch();
      resetCount();
  }

  void _setMovmentRightHandStretch(){
    if(movement is DetectRightHandStretch) return;
    movement =  DetectRightHandStretch();
    resetCount();
  }

  void _setMovmentLeftElbowBend(){
    if(movement is DetectLeftElbowBend) return;
    movement =  DetectLeftElbowBend();
    resetCount();
  }

  void _setMovmentRightElbowBend(){
    if(movement is DetectRightElbowBend) return;
    movement =  DetectRightElbowBend();
    resetCount();
  }

  void _setMovmentHandRaise(){
    if(movement is DetectBothHandRaise) return;
    movement =  DetectBothHandRaise();
    resetCount();
  }

  Future<void> _startCameraStream() async {
    final request = await Permission.camera.request();
    if (request.isGranted) {
      await BodyDetection.startCameraStream(
        onFrameAvailable: _handleCameraImage,
        onPoseAvailable: (pose) {
          if (!_isDetectingPose) return;
          _handlePose(pose);
        },
      );
    }
  }

  Future<void> _startPoseDetection() async{
    await BodyDetection.enablePoseDetection();
    timer = Timer.periodic(Duration(milliseconds: 50), (Timer t) => _checkMovement(_detectedPose!));
    setState(() {
      _isDetectingPose = !_isDetectingPose;
      _detectedPose = null;
    });
  }

  Future<void> _stopCameraStream() async {
    await BodyDetection.stopCameraStream();

    setState(() {
      _cameraImage = null;
      _imageSize = Size.zero;
    });
  }
  Future<void> _stopPoseDetection() async{
    if (_isDetectingPose) {
      await BodyDetection.disablePoseDetection();
      timer?.cancel();
      resetCount();
      setState(() {
        _isDetectingPose = !_isDetectingPose;
        _detectedPose = null;
      });
    }
  }
  void _handleCameraImage(ImageResult result) {
    // Ignore callback if navigated out of the page.
    if (!mounted) return;

    // To avoid a memory leak issue.
    // https://github.com/flutter/flutter/issues/60160
    PaintingBinding.instance?.imageCache?.clear();
    PaintingBinding.instance?.imageCache?.clearLiveImages();

    final image = Image.memory(
      result.bytes,
      gaplessPlayback: true,
      fit: BoxFit.contain,
    );

    setState(() {
      _cameraImage = image;
      _imageSize = result.size;
    });
  }

  void _handlePose(Pose? pose) {
    // Ignore if navigated out of the page.
    if (!mounted) return;

    setState(() {
      _detectedPose = pose;
    });
  }


  void updateCheckMovementLable(bool currentStatus){
    _MovementCheck = currentStatus;
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
                    mask: _maskImage,
                    imageSize: _imageSize,
                    shouldColourGreen: _MovementCheck,
                  ),
                ),
                ),

              OutlinedButton(
                onPressed: _setMovmentLeftHandStretch,
                child: movement is DetectLeftHandStretch
                ? Text('Movement is set to Left hand Stretch') :
                 Text("Set Movement to left hand "),
              ),
              OutlinedButton(
                onPressed: _setMovmentRightHandStretch,
                child: movement is DetectRightHandStretch
                  ? Text('Movement is set to Right hand Stretch') :
                Text("Set Movement to Right hand "),
              ),
              OutlinedButton(
                onPressed: _setMovmentLeftElbowBend,
                child: movement is DetectLeftElbowBend
                    ? Text('Movement is set to Left Elbow bend') :
                Text("Set Movement to left elbow bend "),
              ),
              OutlinedButton(
                onPressed: _setMovmentRightElbowBend,
                child: movement is DetectRightElbowBend
                    ? Text('Movement is set to Right Elbow bend') :
                Text("Set Movement to Right Elbow Bend "),
              ),
              OutlinedButton(
                onPressed: _setMovmentHandRaise,
                child: movement is DetectBothHandRaise
                    ? Text('Movement is set to HandRaise') :
                Text("Set Movement to Hand Raise"),
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
