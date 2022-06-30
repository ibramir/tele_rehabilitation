import 'package:body_detection_example/MovementStrategy.dart';
import 'package:body_detection/models/pose.dart';
import 'package:body_detection/models/pose_landmark.dart';
import 'CalcAngle.dart';
import 'dart:developer';
class DetectLeftHandStretch extends MovementStrategy{

  @override
  bool validate(Pose selectedBody) {

    bool isMovementValid = false;

    PoseLandmark leftShoulderJoint = selectedBody.landmarks.elementAt(11);
    PoseLandmark leftElbowJoint = selectedBody.landmarks.elementAt(13);
    PoseLandmark leftWristJoint = selectedBody.landmarks.elementAt(15);
    PoseLandmark leftHipJoint = selectedBody.landmarks.elementAt(23);

    double leftElbowAngle = CalcAngle.getAngle(leftShoulderJoint, leftElbowJoint, leftWristJoint);
    double leftArmpitAngle = CalcAngle.getAngle(leftWristJoint, leftShoulderJoint, leftHipJoint);

    log("left Elbow Angle, $leftElbowAngle");
    log("left Armpit Angle, $leftArmpitAngle");


    if (leftElbowAngle > 130  &&
        leftArmpitAngle > 60  &&leftArmpitAngle < 110  )
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