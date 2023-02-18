import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:todo_bloc_aj/blocs/bloc_exports.dart';

import '../../models/task.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends HydratedBloc<TasksEvent, TasksState> {
  TasksBloc() : super(const TasksState()) {
    on<AddTaskEvent>(_onAddTask);
    on<UpdateTaskEvent>(_onUpdateTask);
    on<DeleteTaskEvent>(_onDeleteTask);
  }

  FutureOr<void> _onAddTask(AddTaskEvent event, Emitter<TasksState> emit) {
    final state = this.state;
    emit(TasksState(
      allTasks: List.from(state.allTasks)..add(event.task),
    ));
  }

  FutureOr<void> _onUpdateTask(
      UpdateTaskEvent event, Emitter<TasksState> emit) {
    final state = this.state;
    final task = event.task;
    final int index = state.allTasks.indexOf(task);
    print(
        '_onUpdateTask event ${event.task.id} state ${state.allTasks[index].id}');
    List<Task> newAllTasks = List.from(state.allTasks)..remove(task);
    task.isDone == false
        ? newAllTasks.insert(index, task.copyWith(isDone: true))
        : newAllTasks.insert(index, task.copyWith(isDone: false));

    print(
        '_onUpdateTask emitted event ${event.task.id} newAllTasks ${newAllTasks[index].id}');
    emit(TasksState(allTasks: newAllTasks));
  }

  FutureOr<void> _onDeleteTask(
      DeleteTaskEvent event, Emitter<TasksState> emit) {
    final state = this.state;
    final task = event.task;
    List<Task> newAllTask = List.from(state.allTasks)..remove(task);

    emit(TasksState(allTasks: newAllTask));
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
