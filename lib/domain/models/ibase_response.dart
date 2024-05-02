import 'package:cookie/domain/models/ibase_model.dart';

abstract interface class IBaseResponse implements IBaseModel{
  final int? code;
  final bool? success;
  final String? error;
  final Map<String, dynamic>? data;

  IBaseResponse(
      {this.code,
        this.success,
        this.data,
        this.error});
}