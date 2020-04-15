import 'dart:convert';
class ItemModel {
  final int id;
  final bool deleted;
  final String type;
  final String by;
  final int time;
  final String text;
  final bool dead;
  final int parent;
  final List<dynamic> kids;
  final int score;
  final String title;
  final int descendants;
  final String url;

  ItemModel.fromJson(Map<String, dynamic> json)
  : id = json["id"],
  deleted = json["deleted"]?? false,
  type = json["type"],
  by = json["by"],
  time = json["time"],
  text = json["text"]?? '',
  dead = json["dead"]?? false,
  parent = json["parent"],
  kids = json["kids"]?? [],
  score = json["score"],
  title = json["title"],
  descendants = json["descendants"],
  url = json["url"];

  ItemModel.fromDb(Map<String, dynamic> jsonMap)
      : id = jsonMap["id"],
        deleted = jsonMap["deleted"] == 1,
        type = jsonMap["type"],
        by = jsonMap["by"] ?? '',
        time = jsonMap["time"],
        text = jsonMap["text"],
        dead = jsonMap["dead"] == 1,
        parent = jsonMap["parent"],
        kids = json.decode(jsonMap["kids"]),
        score = jsonMap["score"],
        title = jsonMap["title"],
        descendants = jsonMap["descendants"] ?? 0,
        url = jsonMap["url"];

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "deleted": deleted?1:0,
      "type": type,
      "by": by,
      "time": time,
      "text": text,
      "parent": parent,
      "title": title,
      "dead": dead?1:0,
      "kids": json.encode(kids),
      "score": score,
      "url": url,
      "descendants": descendants
    };
  }

}