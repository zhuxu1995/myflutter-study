// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'formconfig.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

formconfig _$formconfigFromJson(Map<String, dynamic> json) {
  return formconfig(
    json['Msg'] as String,
    (json['form_options'] as List)
        ?.map((e) =>
            e == null ? null : Form_options.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$formconfigToJson(formconfig instance) =>
    <String, dynamic>{
      'Msg': instance.Msg,
      'form_options': instance.form_options,
    };

Form_options _$Form_optionsFromJson(Map<String, dynamic> json) {
  return Form_options(
    json['type_id'] as String,
    json['store_id'] as String,
    json['partner_id'] as String,
    json['form_id'] as String,
    json['sort'] as String,
    json['type'] as String,
    json['title'] as String,
    json['title_msg'] as String,
    json['options'] as String,
    json['default_value'] as String,
    json['is_must'] as String,
    json['display'] as String,
    json['status'] as String,
  );
}

Map<String, dynamic> _$Form_optionsToJson(Form_options instance) =>
    <String, dynamic>{
      'type_id': instance.type_id,
      'store_id': instance.store_id,
      'partner_id': instance.partner_id,
      'form_id': instance.form_id,
      'sort': instance.sort,
      'type': instance.type,
      'title': instance.title,
      'title_msg': instance.title_msg,
      'options': instance.options,
      'default_value': instance.default_value,
      'is_must': instance.is_must,
      'display': instance.display,
      'status': instance.status,
    };
