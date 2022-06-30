import 'package:body_detection/models/point3d.dart';
import 'package:body_detection/models/pose_landmark.dart';
import 'package:body_detection_example/MovementStrategy.dart';
import 'package:body_detection/models/pose.dart';
import 'package:body_detection/body_detection.dart';
import 'CalcAngle.dart';
import 'dart:developer';
class DetectRightHandStretch extends MovementStrategy {


  @override
  bool validate(Pose selectedBody) {

    bool isMovementValid = false;

    PoseLandmark rightShoulderJoint = selectedBody.landmarks.elementAt(12);
    PoseLandmark rightElbowJoint = selectedBody.landmarks.elementAt(14);
    PoseLandmark rightWristJoint = selectedBody.landmarks.elementAt(16);
    PoseLandmark rightHipJoint = selectedBody.landmarks.elementAt(24);

    double rightElbowAngle =  CalcAngle.getAngle(rightShoulderJoint, rightElbowJoint, rightWristJoint);
    double rightArmpitAngle =  CalcAngle.getAngle(rightWristJoint, rightShoulderJoint, rightHipJoint);

    log("rightElbowAngle, $rightElbowAngle");
    log("rightArmpitangle, $rightArmpitAngle");

    if (rightElbowAngle > 120  &&
        rightArmpitAngle > 50 && rightArmpitAngle < 110  )
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



