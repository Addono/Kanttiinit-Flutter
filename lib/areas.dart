//import 'package:json_annotation/json_annotation.dart';
import 'package:kanttiinit_flutter/area.dart';

//part 'user.g.dart';

//@JsonSerializable()

class Areas extends Object {
  //}with _$AreasSerializerMixin {
  Areas(this.areas);

  List<Area> areas;

  //factory Areas.fromJson(Map<String, dynamic> json) => _$AreasSerializerMixin(json);
  Areas.fromJson(List<dynamic> json)
      : areas = json.map((v) => Area.fromJson(v as Map<String, dynamic>))
                .toList();
}
