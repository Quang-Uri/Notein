class Note {
  String? id;
  String? userid;
  String? title;
  String? content;
  DateTime? dateadded;
  String? type;

  Note({
    this.id,
    this.userid,
    this.title,
    this.content,
    this.dateadded,
    this.type,
  });

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map["id"],
      userid: map["userid"],
      title: map["title"],
      content: map["content"],
      dateadded: DateTime.tryParse(map["dateadded"]),
      type: map["type"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "userid": userid,
      "title": title,
      "content": content,
      "dateadded": dateadded!.toIso8601String(),
      "type": type,
    };
  }
}
