import 'package:tele_rehabilitation/exercises/movement_strategy.dart';
import 'package:body_detection/models/pose_landmark.dart';
import 'package:body_detection/models/pose.dart';
import 'calc_angle.dart';

class DetectRightElbowBend extends MovementStrategy{

  @override
  bool validate(Pose selectedBody) {

    bool isMovementValid = false;
    PoseLandmark rightShoulderJoint = selectedBody.landmarks.elementAt(11);
    PoseLandmark rightElbowJoint = selectedBody.landmarks.elementAt(13);
    PoseLandmark rightWristJoint = selectedBody.landmarks.elementAt(15);

    double rightElbowAngle =  CalcAngle.getAngle(rightShoulderJoint, rightElbowJoint, rightWristJoint);

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