import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_tasks_app/blocs/bloc_exports.dart';
import '../../models/task.dart';

part 'tasks_event.dart';

part 'tasks_state.dart';

class TasksBloc extends HydratedBloc<TasksEvent, TasksState> {
  TasksBloc() : super(const TasksState()) {
    on<AddTask>(_onAddTask);
    on<UpdateTask>(_onUpdateTask);
    on<FavoredTask>(_onFavoredTask);
    on<DeleteTask>(_onDeleteTask);
    on<RemoveTask>(_onRemoveTask);
  }

  void _onAddTask(AddTask event, Emitter<TasksState> emit) {
    final state = this.state;
    emit(TasksState(
      pendingTasks: List.from(state.pendingTasks)..add(event.task),
      completedTasks: state.completedTasks,
      favoriteTasks: state.favoriteTasks,
      removedTasks: state.removedTasks,
    ));
  }

  void _onFavoredTask(FavoredTask event, Emitter<TasksState> emit) {
    final state = this.state;
    final task = event.task;
    List<Task> pendingTasks = state.pendingTasks;
    List<Task> favoriteTasks = state.favoriteTasks;
    List<Task> completedTasks = state.completedTasks;
    task.isFavored == false
        ? {
            favoriteTasks = List.from(favoriteTasks)
              ..insert(0, task.copyWidth(isFavored: true)),
            task.isDone == false
                ? {
                    pendingTasks = List.from(pendingTasks)..remove(task),
                    pendingTasks = List.from(pendingTasks)
                      ..insert(0, task.copyWidth(isFavored: true)),
                  }
                : {
                    completedTasks = List.from(completedTasks)..remove(task),
                    completedTasks = List.from(completedTasks)
                      ..insert(0, task.copyWidth(isFavored: true)),
                  },
          }
        : {
            favoriteTasks = List.from(favoriteTasks)..remove(task),
            task.isDone == true
                ? {
                    completedTasks = List.from(completedTasks)..remove(task),
                    completedTasks = List.from(completedTasks)
                      ..insert(0, task.copyWidth(isFavored: false)),
                  }
                : {
                    pendingTasks = List.from(pendingTasks)..remove(task),
                    pendingTasks = List.from(pendingTasks)
                      ..insert(0, task.copyWidth(isFavored: false)),
                  },
          };

    emit(TasksState(
      favoriteTasks: favoriteTasks,
      pendingTasks: pendingTasks,
      completedTasks: completedTasks,
      removedTasks: state.removedTasks,
    ));
  }

  void _onUpdateTask(UpdateTask event, Emitter<TasksState> emit) {
    final state = this.state;
    final task = event.task;
    List<Task> pendingTasks = state.pendingTasks;
    List<Task> completedTasks = state.completedTasks;
    List<Task> favoriteTasks = state.favoriteTasks;
    task.isDone == false
        ? {
            pendingTasks = List.from(pendingTasks)..remove(task),
            completedTasks = List.from(completedTasks)
              ..insert(0, task.copyWidth(isDone: true)),
            task.isFavored == true
                ? {
                    favoriteTasks = List.from(favoriteTasks)..remove(task),
                    favoriteTasks = List.from(favoriteTasks)
                      ..insert(0, task.copyWidth(isDone: true)),
                  }
                : null,
          }
        : {
            completedTasks = List.from(completedTasks)..remove(task),
            pendingTasks = List.from(pendingTasks)
              ..insert(0, task.copyWidth(isDone: false)),
            task.isFavored == true
                ? {
                    favoriteTasks = List.from(favoriteTasks)..remove(task),
                    favoriteTasks = List.from(favoriteTasks)
                      ..insert(0, task.copyWidth(isDone: false)),
                  }
                : null,
          };

    emit(TasksState(
      pendingTasks: pendingTasks,
      completedTasks: completedTasks,
      removedTasks: state.removedTasks,
      favoriteTasks: favoriteTasks,
    ));
  }

  void _onDeleteTask(DeleteTask event, Emitter<TasksState> emit) {
    final state = this.state;
    emit(TasksState(
        pendingTasks: state.pendingTasks,
        completedTasks: state.completedTasks,
        favoriteTasks: state.favoriteTasks,
        removedTasks: List.from(state.removedTasks)..remove(event.task)));
  }

  void _onRemoveTask(RemoveTask event, Emitter<TasksState> emit) {
    final state = this.state;
    emit(TasksState(
      pendingTasks: List.from(state.pendingTasks)..remove(event.task),
      completedTasks: List.from(state.completedTasks)..remove(event.task),
      favoriteTasks: List.from(state.favoriteTasks)..remove(event.task),
      removedTasks: List.from(state.removedTasks)
        ..add(event.task.copyWidth(isDeleted: true)),
    ));
  }

  @override
  TasksState? fromJson(Map<String, dynamic> json) {
    return TasksState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(TasksState state) {
    return state.toMap();
  }
}
