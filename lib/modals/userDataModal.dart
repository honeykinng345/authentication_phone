class UserDataModal {
  String firstName, lastName, email, contactMethod, contact, address, userImage;

  UserDataModal(
      {this.email,
      this.address,
      this.contact,
      this.contactMethod,
      this.firstName,
      this.lastName,
      this.userImage});

  factory UserDataModal.fromAPI(Map<String, dynamic> jsonObject) {
    return UserDataModal(
      email: jsonObject['email'],
      firstName: jsonObject['firstName'],
      lastName: jsonObject['lastName'],
      userImage: jsonObject['userImage'],
      contactMethod: jsonObject['contactMethod'],
      contact: jsonObject['contact'],
      address: jsonObject['address'],
    );
  }
}
