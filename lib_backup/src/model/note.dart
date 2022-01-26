import '../common/app_constant.dart';

class Note {
  Note({
    this.id,
    this.content = '', 
  });

  int? id;
  String content;

  factory Note.fromMap(Map<String, dynamic> data) {
    return Note(
      id: data[AppConstant.fId],
      content: data[AppConstant.fContent],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      AppConstant.fId: id,
      AppConstant.fContent: content,
    };
  }
}
