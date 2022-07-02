import 'package:tele_rehabilitation/exercises/movement_strategy.dart';
import 'package:body_detection/models/pose_landmark.dart';
import 'package:body_detection/models/pose.dart';
import 'calc_angle.dart';
class DetectLeftHandStretch extends MovementStrategy{

  @override
  bool validate(Pose selectedBody) {

    bool isMovementValid = false;

    PoseLandmark leftShoulderJoint = selectedBody.landmarks.elementAt(12);
    PoseLandmark leftElbowJoint = selectedBody.landmarks.elementAt(14);
    PoseLandmark leftWristJoint = selectedBody.landmarks.elementAt(16);
    PoseLandmark leftHipJoint = selectedBody.landmarks.elementAt(24);

    double leftElbowAngle = CalcAngle.getAngle(leftShoulderJoint, leftElbowJoint, leftWristJoint);
    double leftArmpitAngle = CalcAngle.getAngle(leftWristJoint, leftShoulderJoint, leftHipJoint);


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