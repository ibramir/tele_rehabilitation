import 'dart:async';

// import 'package:tele_rehabilitation/exercises/modelFiles/models/image_result.dart';
import 'package:body_detection/body_detection.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:tele_rehabilitation/exercises/MovementStrategies/DetectBothHandRaise.dart';
import 'package:tele_rehabilitation/exercises/MovementStrategies/DetectLeftElbowBend.dart';
import 'package:tele_rehabilitation/exercises/MovementStrategies/DetectLeftHandStretch.dart';
import 'package:tele_rehabilitation/exercises/MovementStrategies/DetectRightElbowBend.dart';
import 'package:tele_rehabilitation/exercises/MovementStrategies/DetectRightHandStretch.dart';
import 'package:tele_rehabilitation/exercises/MovementStrategy.dart';
import 'package:flutter/material.dart';
import 'package:body_detection/models/image_result.dart';
import 'dart:ui' as ui;

// import 'package:tele_rehabilitation/exercises/modelFiles/body_detection.dart';
import 'package:body_detection/models/pose.dart';

import '../model/exercise.dart';

class VerifyPose {
  Timer? timer;
  bool _isDetectingPose = false;
  bool _movementCheck = false;
  bool _previousMovement = false;
  int count = 0;
  Pose? _detectedPose;
  ui.Image? _maskImage;
  Image? _cameraImage;
  Size _imageSize = Size.zero;
  late final MovementStrategy _movement;
  final Exercise _exercise;

  VerifyPose(this._exercise) {
    count = _exercise.done;
    switch (_exercise.type) {
      case 'Left Arm Stretch':
        {
          _movement = DetectLeftHandStretch();
        }
        break;
      case 'Right Arm Stretch':
        {
          _movement = DetectRightHandStretch();
        }
        break;
      case 'Left Elbow Bend':
        {
          _movement = DetectLeftElbowBend();
        }
        break;
      case 'Right Elbow Bend':
        {
          _movement = DetectRightElbowBend();
        }
        break;
      default:
        {
          _movement = DetectBothHandRaise();
        }
    }
  }

  void initPoseVerification() {
    _startCameraStream();
    _startPoseDetection();
  }

  void closePoseVerification() {
    _stopCameraStream();
    _stopPoseDetection();
  }

  Future<void> _checkMovement(currentPose) async {
    _movementCheck = _movement.validate(currentPose);
    if (_movementCheck && !_previousMovement) {
      count++;
      _exercise.done++;
    }
    _previousMovement = _movementCheck;
  }

  void resetCount() {
    count = 0;
    _previousMovement = _movementCheck = false;
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

  Future<void> _startPoseDetection() async {
    await BodyDetection.enablePoseDetection();
    timer = Timer.periodic(const Duration(milliseconds: 50),
        (Timer t) => _checkMovement(_detectedPose!));

    _isDetectingPose = !_isDetectingPose;
    _detectedPose = null;
  }

  Future<void> _stopCameraStream() async {
    await BodyDetection.stopCameraStream();

    _cameraImage = null;
    _imageSize = Size.zero;
  }

  Future<void> _stopPoseDetection() async {
    if (_isDetectingPose) {
      await BodyDetection.disablePoseDetection();
      timer?.cancel();
      resetCount();

      _isDetectingPose = !_isDetectingPose;
      _detectedPose = null;
    }
  }

  void _handleCameraImage(ImageResult result) {
    // To avoid a memory leak issue.
    // https://github.com/flutter/flutter/issues/60160
    PaintingBinding.instance?.imageCache?.clear();
    PaintingBinding.instance?.imageCache?.clearLiveImages();

    final image = Image.memory(
      result.bytes,
      gaplessPlayback: true,
      fit: BoxFit.contain,
    );

    _cameraImage = image;
    _imageSize = result.size;
  }

  void _handlePose(Pose? pose) {
    _detectedPose = pose;
  }

  get currentCount => count;

  get pose => _detectedPose;

  get maskImage => _maskImage;

  get size => _imageSize;

  get movementCheck => _movementCheck;

  get image => _cameraImage;
}
