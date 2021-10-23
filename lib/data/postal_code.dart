import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'postal_code.freezed.dart';
part 'postal_code.g.dart';

@freezed
class PostalCode with _$PostalCode {
  const factory PostalCode({
    required String code,
    required List<PostalCodeData> data,
  }) = _PostalCode;

  factory PostalCode.fromJson(Map<String, dynamic> json) =>
      _$PostalCodeFromJson(json);
}

class PostalCodeData with _$PostalCodeData {
  const factory PostalCodeData({
    required String code,
  }) = _PostalCodeData;

  factory PostalCodeData.fromJson(Map<String, dynamic> json) =>
      _$PostalCodeDataFromJson(json);
}
