import 'package:body_detection/models/pose.dart';
abstract class MovementStrategy
{
  bool validate(Pose selectedBody);
}