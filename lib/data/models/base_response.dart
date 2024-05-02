import 'package:cookie/domain/models/ibase_response.dart';
import 'package:cookie/data/models/keys.dart';

class BaseResponse implements IBaseResponse {
  @override
  int? code;
  @override
  final bool? success;
  @override
  final String? error;
  @override
  final Map<String, dynamic>? data;

  BaseResponse({this.code, this.success, this.data, this.error});

  @override
  factory BaseResponse.fromJson({required Map<String, dynamic> data}) {
    return BaseResponse(
      code: data[Keys.keyCode],
      data: data[Keys.keyData],
      error: data[Keys.keyError],
      success: data[Keys.keySuccess],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      Keys.keyCode: code,
      Keys.keyData: data,
      Keys.keyError: error,
      Keys.keySuccess: success
    };
  }
}
