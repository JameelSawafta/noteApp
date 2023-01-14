class NoteModel{
  int? id;
  String? title;
  String? note;
  String? date;
  int? color;

  NoteModel({this.id, this.title, this.note, this.date, this.color});

  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'title': title,
      'note': note,
      'date': date.toString(),
      'color': color,
    };
  }

  NoteModel.fromMap(Map<dynamic, dynamic> map){
    id = map['id'];
    title = map['title'];
    note = map['note'];
    date = map['date'];
    color = map['color'];
  }
}