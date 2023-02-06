// To convert Response into a non-nullable object(model)
import 'package:flutter_mvvm_project/app/extensions.dart';
import 'package:flutter_mvvm_project/data/responses/responses.dart';
import 'package:flutter_mvvm_project/domain/models/models.dart';

import '../../app/constants.dart';

extension CustomerResponseMapper on CustomerResponse? {
  CustomerModel toDomain() {
    return CustomerModel(
      this?.id?.orEmpty() ?? kEmpty,
      this?.name?.orEmpty() ?? kEmpty,
      this?.numOfNotification?.orZero() ?? kZero,
    );
  }
}

extension ContactsResponseMapper on ContactsResponse? {
  ContactResModel toDomain() {
    return ContactResModel(
      this?.email?.orEmpty() ?? kEmpty,
      this?.phone?.orEmpty() ?? kEmpty,
      this?.link?.orEmpty() ?? kEmpty,
    );
  }
}

extension AuthResponseMapper on AuthResponse? {
  AuthResModel toDomain() {
    return AuthResModel(this?.customer?.toDomain(), this?.contacts?.toDomain());
  }
}
