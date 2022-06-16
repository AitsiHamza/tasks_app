import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Task extends Equatable {
  final String id;
  final String title;
  final String description;
  bool? isDone;
  bool? isDeleted;

  Task(
      {required this.id,
      required this.description,
      required this.title,
      this.isDone,
      this.isDeleted}) {
    isDone = isDone ?? false;
    isDeleted = isDeleted ?? false;
  }

  Task copyWidth(
      {String? id,
      String? description,
      String? title,
      bool? isDone,
      bool? isDeleted}) {
    return Task(
      id: id ?? this.id,
      description: description ?? this.description,
      title: title ?? this.title,
      isDone: isDone ?? this.isDone,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'description': description,
      'title': title,
      'isDone': isDone,
      'isDeleted': isDeleted,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'] ?? '',
      description: map['description'] ?? '',
      title: map['title'] ?? '',
      isDone: map['isDone'],
      isDeleted: map['isDeleted'],
    );
  }

  @override
  List<Object?> get props => [
        id,
        description,
        title,
        isDone,
        isDeleted,
      ];
}
