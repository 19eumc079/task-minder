// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'dart:convert';

// class ToDoListModel {
//   String content;
//   String date;
//   bool done;
//   ToDoListModel({
//     required this.content,
//     required this.date,
//     required this.done,
//   });

//   ToDoListModel copyWith({
//     String? content,
//     String? date,
//     bool? done,
//   }) {
//     return ToDoListModel(
//       content: content ?? this.content,
//       date: date ?? this.date,
//       done: done ?? this.done,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'content': content,
//       'date': date,
//       'done': done,
//     };
//   }

//   factory ToDoListModel.fromMap(Map<String, dynamic> map) {
//     return ToDoListModel(
//       content: map['content'] as String,
//       date: map['date'] as String,
//       done: map['done'] as bool,
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory ToDoListModel.fromJson(String source) =>
//       ToDoListModel.fromMap(json.decode(source) as Map<String, dynamic>);

//   @override
//   String toString() =>
//       'ToDoListModel(content: $content, date: $date, done: $done)';

//   @override
//   bool operator ==(covariant ToDoListModel other) {
//     if (identical(this, other)) return true;

//     return other.content == content && other.date == date && other.done == done;
//   }

//   @override
//   int get hashCode => content.hashCode ^ date.hashCode ^ done.hashCode;
// }
