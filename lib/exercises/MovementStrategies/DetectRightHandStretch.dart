import 'package:body_detection/models/pose_landmark.dart';
import 'package:body_detection/models/pose.dart';
import 'package:tele_rehabilitation/exercises/MovementStrategy.dart';
import 'CalcAngle.dart';
class DetectRightHandStretch extends MovementStrategy {


  @override
  bool validate(Pose selectedBody) {

    bool isMovementValid = false;

    PoseLandmark rightShoulderJoint = selectedBody.landmarks.elementAt(11);
    PoseLandmark rightElbowJoint = selectedBody.landmarks.elementAt(13);
    PoseLandmark rightWristJoint = selectedBody.landmarks.elementAt(15);
    PoseLandmark rightHipJoint = selectedBody.landmarks.elementAt(23);

    double rightElbowAngle =  CalcAngle.getAngle(rightShoulderJoint, rightElbowJoint, rightWristJoint);
    double rightArmpitAngle =  CalcAngle.getAngle(rightWristJoint, rightShoulderJoint, rightHipJoint);


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



