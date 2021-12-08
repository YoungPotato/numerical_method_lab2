import 'dart:math';

class Functions {
  static double pure(double x) => x - 1.2 * cos(x) * cos(x);

  static double derivative(double x) => 1 + 2.4 * cos(x) * sin(x);

  static double secondDerivative(double x) => 2.4 * (cos(x) * cos(x) - sin(x) * sin(x));

  static double f(double x) => acos(sqrt(5 * x / 6));
}

class Constants {
  static const double precision = 0.5 * 1 / 1000000;

  static const intervalStart = 0.5;
  static const intervalEnd = 0.9;

  static const x0 = 0.75;
}

class Solver {
  static double binarySearch() {
    var left = Constants.intervalStart;
    var right = Constants.intervalEnd;
    var middle = 0.0;
    var leftValue = 0.0;
    var middleValue = 0.0;
    var rightValue = 0.0;

    final countIteration = LogOperations.log2((right - left) / Constants.precision).round();
    print('Количество итераций: $countIteration');

    var i = 0;

    while (i < countIteration) {
      i++;
      middle = (left + right) / 2.0;
      leftValue = Functions.pure(left);
      middleValue = Functions.pure(middle);
      rightValue = Functions.pure(right);

      if (leftValue * middleValue < 0) {
        right = middle;
      } else if (rightValue * middleValue < 0) {
        left = middle;
      } else if (middleValue == 0 || rightValue == 0 || leftValue == 0) {
        return 0;
      }
    }
    return (left + right) / 2.0;
  }

  static double newtonMethod() {
    var x = Constants.x0;
    var i = 0;

    while (true) {
      i++;
      var x1 = x - Functions.pure(x) / Functions.derivative(x);

      if ((x1 - x).abs() <= Constants.precision) {
        print('Количество итераций: $i');
        return x1;
      }
      x = x1;
    }
  }

  static double modifiedNewtonMethod() {
    var x = Constants.x0;
    var i = 0;

    while (true) {
      i++;
      var x1 = x - Functions.pure(x) / Functions.derivative(Constants.x0);

      if ((x1 - x).abs() <= Constants.precision) {
        print('Количество итераций: $i');
        return x1;
      }
      x = x1;
    }
  }

  static double hordMethod() {
    var x = Constants.intervalStart;
    var i = 0;

    while (true) {
      i++;
      var x1 = x - (Functions.pure(x) * (x - Constants.x0)) / (Functions.pure(x) - Functions.pure(Constants.x0));

      if ((x1 - x).abs() <= Constants.precision) {
        print('Количество итераций: $i');
        return x1;
      }
      x = x1;
    }
  }

  static double movableHordMethod() {
    var x0 = Constants.x0;
    var x = Constants.intervalStart;
    var i = 0;

    while (true) {
      i++;
      var x1 = x - (Functions.pure(x) * (x - x0)) / (Functions.pure(x) - Functions.pure(x0));

      if ((x1 - x).abs() <= Constants.precision) {
        print('Количество итераций: $i');
        return x1;
      }
      x0 = x;
      x = x1;
    }
  }

  static double simpleIteration() {
    var x = Constants.x0;
    var i = 0;
    while (true) {
      i++;
      var x1 = Functions.f(x);
      if ((x1 - x).abs() <= Constants.precision) {
        print('Количество итераций: $i');
        return x1;
      }
      x = x1;
    }
  }
}

class LogOperations {
  static double log2(num x) => log(x) / ln2;
}
