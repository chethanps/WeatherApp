import 'dart:io';

void main() {
  performTasks();
}

Future<void> performTasks() async {
  task1();
  int result = await task2();
  task3(result);
}

void task1() {
  print('Task1 Complete');
}

Future task2() async {
  int result;
  Duration duration = Duration(seconds: 3);
  await Future.delayed(duration, () {
    print('Task2 Complete');
    result =  2;
  });
  return result;
}

void task3(int result) {
  print('Task3 Complete, InputString $result');

}