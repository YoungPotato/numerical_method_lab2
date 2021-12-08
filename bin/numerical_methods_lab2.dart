import 'package:numerical_methods_lab2/numerical_methods_lab2.dart';

void main(List<String> arguments) {
  print('Обоснование выбора отрезка: f(start_position)*f(end_position) < 0');
  print(Functions.pure(Constants.intervalStart) * Functions.pure(Constants.intervalEnd));

  print('\nОбоснование выбора x0: f(x0)*f\'\'(x0) > 0');
  print(Functions.pure(Constants.x0) * Functions.secondDerivative(Constants.x0));

  print('\nМетод половинного деления');
  print('Результат - ${Solver.binarySearch()}\n');

  print('Метод Ньютона');
  print('Результат - ${Solver.newtonMethod()}\n');

  print('Модифицированный метод Ньютона');
  print('Результат - ${Solver.modifiedNewtonMethod()}\n');

  print('Метод хорд');
  print('Результат - ${Solver.hordMethod()}\n');

  print('Метод подвиждных хорд');
  print('Результат - ${Solver.movableHordMethod()}\n');

  print('Метод простой итерации');
  print('Результат - ${Solver.simpleIteration()}\n');
}
