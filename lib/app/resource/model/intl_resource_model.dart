import 'package:equatable/equatable.dart';

class IntlResourceModel implements Equatable {
  IntlResourceModel({
    this.resourceId,
    this.languageId,
    this.moduleId,
    this.updatedAt,
    this.value,
  });

  final String? resourceId;
  final int? updatedAt;
  final String? moduleId;
  final String? value;
  final String? languageId;

  @override
  List<Object?> get props => [
        resourceId,
        languageId,
        moduleId,
        updatedAt,
        value,
      ];

  @override
  bool? get stringify => true;

  factory IntlResourceModel.fromMap(Map json) => IntlResourceModel(
        resourceId: json['resource_id'],
        languageId: json['language_id'],
        moduleId: json['module_id'],
        updatedAt: json['updated_at'],
        value: json['value'],
      );

  Map<String, Object?> toMap() => {
        'resource_id': resourceId,
        'language_id': languageId,
        'module_id': moduleId,
        'updated_at': updatedAt,
        'value': value,
      };

  @override
  String toString() =>
      "resourceId: $resourceId, languageId: $languageId, moduleId: $moduleId, value: $value";
}
