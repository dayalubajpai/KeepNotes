class NoteModel {
  String? description;
  String? id;
  String? title;

  NoteModel({this.description, this.id, this.title});

  NoteModel.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    id = json['id'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['description'] = description;
    data['id'] = id;
    data['title'] = title;
    return data;
  }
}
