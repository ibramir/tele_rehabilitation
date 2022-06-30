import 'package:body_detection/models/point3d.dart';
import 'package:body_detection/models/pose_landmark.dart';
import 'package:body_detection/png_image.dart';
import 'dart:math';
import 'package:vector_math/vector_math.dart';

class CalcAngle {

  static double getAngle(PoseLandmark firstPoint, PoseLandmark midPoint, PoseLandmark lastPoint) {
    double result =
      degrees(
            atan2(radians(lastPoint.position.x) - radians(midPoint.position.x),
                radians(lastPoint.position.y) - radians(midPoint.position.y))
              -
            atan2(radians(firstPoint.position.x) - radians(midPoint.position.x),
                radians(firstPoint.position.y) - radians(midPoint.position.y))
      );

    // Angle should never be negative
    result = result.abs();
    if (result > 180) {
      // Always get the acute representation of the angle
      result = (360.0 - result);
    }
    return result;
  }

  double getDistance(PoseLandmark A, PoseLandmark B) {
    double distance = sqrt(
            pow((A.position.x - B.position.x), 2) +
            pow((A.position.y - B.position.y), 2) +
            pow((A.position.z - B.position.z), 2)
    );

    return distance;
  }
}