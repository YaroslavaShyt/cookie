abstract interface class IBaseModel{
  IBaseModel.fromJson(Map<String, dynamic> data);
  Map<String, dynamic> toJson();
}