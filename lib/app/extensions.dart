// Extension on String
import 'package:flutter_mvvm_project/app/constants.dart';

extension NonNullString on String? {
  String orEmpty() {
    if (this == null) {
      return kEmpty;
    } else {
      return this!;
    }
  }
}

// Extension on int
extension NonNullInt on int? {
  int orZero() {
    if (this == null) {
      return kZero;
    } else {
      return this!;
    }
  }
}
