import 'package:flutter_custom_creator/flutter_custom_creator.dart';

void main(List<String> arguments) {
  
  if (arguments.length != 2) {
    print('Usage: flutter_custom_creator <project_name> <organization>');
    return;
  }

  var projectName = arguments[0];
  var organization = arguments[1];

  createCustomProject(projectName, organization);
}