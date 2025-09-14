class DailyTopicModel {
  String? title;
  String? author;
  String? description;

  DailyTopicModel({this.title, this.author, this.description});

  DailyTopicModel.fromJson(Map<String, dynamic> json) {
    title = json['q'];
    author = json['a'];
    description = json['h'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['q'] = this.title;
    data['a'] = this.author;
    data['h'] = this.description;
    return data;
  }
}
