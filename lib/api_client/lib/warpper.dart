// deal with the problem on miss match like camel case and  uppercase 


// import 'package:openapi/api.dart';

// class UserDTOWrapper {
//   final DtosGetUserResponse _userResponse;
//   final DtosUpdateUserRequest _updateRequest;

//   UserDTOWrapper(this._userResponse) : _updateRequest = DtosUpdateUserRequest();

//   String? get username => _userResponse.username;
//   set username(String? value) => _updateRequest.username = value;

//   String? get email => _userResponse.email;
//   set email(String? value) => _updateRequest.email = value;

//   String? get firstName => _userResponse.firstName;
//   set firstName(String? value) => _updateRequest.first_name = value;

//   String? get lastName => _userResponse.lastName;
//   set lastName(String? value) => _updateRequest.last_name = value;

//   String? get id => _userResponse.id;

//   // Add other fields as necessary

//   DtosUpdateUserRequest toUpdateRequest() => _updateRequest;

//   static UserDTOWrapper fromGetUserResponse(DtosGetUserResponse response) {
//     return UserDTOWrapper(response);
//   }
// }