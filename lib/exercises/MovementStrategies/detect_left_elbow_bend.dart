import 'package:tele_rehabilitation/exercises/movement_strategy.dart';
import 'package:body_detection/models/pose_landmark.dart';
import 'package:body_detection/models/pose.dart';
import 'calc_angle.dart';

class DetectLeftElbowBend extends MovementStrategy{

  @override
  bool validate(Pose selectedBody) {

    bool isMovementValid = false;

    PoseLandmark leftShoulderJoint = selectedBody.landmarks.elementAt(12);
    PoseLandmark leftElbowJoint = selectedBody.landmarks.elementAt(14);
    PoseLandmark leftWristJoint = selectedBody.landmarks.elementAt(16);

    double leftElbowAngle = CalcAngle.getAngle(leftShoulderJoint, leftElbowJoint, leftWristJoint);


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