import '../db/db.dart';

class DatabaseModel {
  int? id;
  String fullname;

  DatabaseModel({this.id, this.fullname = ''});

  factory DatabaseModel.fromJson(Map<String, dynamic> json) {
    return DatabaseModel(
      id: json[DatabaseLokal.id],
      fullname: json[DatabaseLokal.fullname],
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      DatabaseLokal.id: id,
      DatabaseLokal.fullname: fullname,
    };
  }
}
