import 'package:body_detection_example/MovementStrategy.dart';
import 'package:body_detection/models/pose.dart';
import 'package:body_detection/models/pose_landmark.dart';
import 'CalcAngle.dart';
import 'dart:developer';

class DetectLeftElbowBend extends MovementStrategy{

  @override
  bool validate(Pose selectedBody) {

    bool isMovementValid = false;

    PoseLandmark leftShoulderJoint = selectedBody.landmarks.elementAt(11);
    PoseLandmark leftElbowJoint = selectedBody.landmarks.elementAt(13);
    PoseLandmark leftWristJoint = selectedBody.landmarks.elementAt(15);

    double leftElbowAngle = CalcAngle.getAngle(leftShoulderJoint, leftElbowJoint, leftWristJoint);

    log("left Elbow Angle, $leftElbowAngle");


    if (leftElbowAngle > 80  && leftElbowAngle < 100  )
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