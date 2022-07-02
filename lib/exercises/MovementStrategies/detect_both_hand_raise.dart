import 'package:tele_rehabilitation/exercises/movement_strategy.dart';
import 'package:body_detection/models/pose_landmark.dart';
import 'package:body_detection/models/pose.dart';
import 'calc_angle.dart';

class DetectBothHandRaise extends MovementStrategy{

  @override
  bool validate(Pose selectedBody) {

    bool isMovementValid = false;

    PoseLandmark leftShoulderJoint = selectedBody.landmarks.elementAt(11);
    PoseLandmark leftWristJoint = selectedBody.landmarks.elementAt(15);
    PoseLandmark leftHipJoint = selectedBody.landmarks.elementAt(23);

    double leftArmpitAngle = CalcAngle.getAngle(leftWristJoint, leftShoulderJoint, leftHipJoint);

    PoseLandmark rightShoulderJoint = selectedBody.landmarks.elementAt(12);
    PoseLandmark rightWristJoint = selectedBody.landmarks.elementAt(16);
    PoseLandmark rightHipJoint = selectedBody.landmarks.elementAt(24);

    double rightArmpitAngle =  CalcAngle.getAngle(rightWristJoint, rightShoulderJoint, rightHipJoint);

    PoseLandmark noseJoint  = selectedBody.landmarks.elementAt(0);

    if (leftArmpitAngle > 120  && rightArmpitAngle > 120
       && noseJoint.position.y > leftWristJoint.position.y
       && noseJoint.position.y > rightWristJoint.position.y )
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