class NoteModel {
  String? date;
  String? description;
  String? id;
  String? title;

  NoteModel({this.date, this.description, this.id, this.title});

  NoteModel.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    description = json['description'];
    id = json['id'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = date;
    data['description'] = description;
    data['id'] = id;
    data['title'] = title;
    return data;
  }
}
