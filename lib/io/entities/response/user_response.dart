part of 'response.dart';

@freezed
class UserResponse with _$UserResponse {
  const factory UserResponse(
    int id,
    String name,
    @JsonKey(name: "full_name") String fullName,
    String nickname,
  ) = _UserResponse;

  factory UserResponse.fromJson(Map<String, dynamic> json) => _$UserResponseFromJson(json);
}
