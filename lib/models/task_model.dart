class TaskModel {

  String? id;
  String? title;
  String? describe;
  String? important;
  String? color;
  String? day;
  String? month;
  String? year;
  String? time;



  TaskModel({
    this.id,
    this.title,
    this.describe,
    this.important,
    this.color,
    this.day,
    this.month,
    this.year,
    this.time,
  });
  TaskModel.fromJson(Map<String, dynamic> json)
  {
    id = json['id'];
    title = json['title'];
    describe = json['describe'];
    important = json['important'];
    color = json['color'];
    day = json['day'];
    month = json['month'];
    year = json['year'];
    time = json['time'];

  }

  Map<String, dynamic> toMap()
  {
    return {
      'id' :id,
      'title' :title,
      'describe' :describe,
      'important' :important,
      'color' :color,
      'day' :day,
      'month' :month,
      'year' :year,
      'time' :time,
    };
  }

}