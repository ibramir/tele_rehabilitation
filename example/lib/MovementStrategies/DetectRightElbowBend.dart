import 'package:body_detection_example/MovementStrategy.dart';
import 'package:body_detection/models/pose.dart';
import 'package:body_detection/models/pose_landmark.dart';
import 'CalcAngle.dart';
import 'dart:developer';

class DetectRightElbowBend extends MovementStrategy{

  @override
  bool validate(Pose selectedBody) {

    bool isMovementValid = false;
    PoseLandmark rightShoulderJoint = selectedBody.landmarks.elementAt(12);
    PoseLandmark rightElbowJoint = selectedBody.landmarks.elementAt(14);
    PoseLandmark rightWristJoint = selectedBody.landmarks.elementAt(16);
    PoseLandmark rightHipJoint = selectedBody.landmarks.elementAt(24);

    double rightElbowAngle =  CalcAngle.getAngle(rightShoulderJoint, rightElbowJoint, rightWristJoint);

    log("left Elbow Angle, $rightElbowAngle");


    if (rightElbowAngle > 80  && rightElbowAngle < 100  )
    {
      isMovementValid = true;
    }
    else
    {
      isMovementValid = false;
    }

    return isMovementValid;

  }
}