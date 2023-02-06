class SliderObject {
  SliderObject(
    this.title,
    this.subTitle,
    this.image,
  );
  String title;
  String subTitle;
  String image;
}

class CustomerModel {
  String id;
  String name;
  int numOfNotification;

  CustomerModel(this.id, this.name, this.numOfNotification);
}

class ContactResModel {
  String email;
  String phone;
  String link;

  ContactResModel(this.email, this.phone, this.link);
}

class AuthResModel {
  CustomerModel? customer;
  ContactResModel? contacts;

  AuthResModel(this.customer, this.contacts);
}

class DeviceInfo {
  String name;
  String identifier;
  String version;

  DeviceInfo(this.name, this.identifier, this.version);
}
