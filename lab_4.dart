import 'dart:math';

void main(List<String> arguments) {
  final firstStep = middleRect(0, 3, 0.1);
  final secondStep = middleRect(0, 3, 0.05);
  final thirdStep = middleRect(0, 3, 0.025);

  final res38First = res38(0, 3, 0.1);
  final res38Second = res38(0, 3, 0.05);
  final res38Third = res38(0, 3, 0.025);

  print('\n');
  print('Метод средних прямоугольников');

  print(firstStep);
  print(secondStep);
  print(thirdStep);

  print('\n');
  print('Погрешности для серединных прямоугольников');

  print((secondStep - firstStep) * 2);
  print(secondStep - firstStep);
  print(thirdStep - secondStep);

  print('-' * 100);

  print(res38First);
  print(res38Second);
  print(res38Third);

  print('\n');
  print('Погрешности для 3/8');

  print((res38Second - res38First) * 16 / 15);
  print((res38Second - res38First) * 1 / 15);
  print((res38Third - res38Second) * 1 / 15);

  print('\n');

  final gauss = f(-4.18) * 0.0279603 + f(2.55) * 0.929036 + f(1.1) * 2.0431;
  print(gauss);
}

double f(double x) => cos(sqrt(1 + pow(x, 2)));

double f38(double a, double b) => (b - a) / 8 * (f(a) + 3 * f((2 * a + b) / 3) + 3 * f((a + 2 * b) / 3) + f(b));

List<double> getPoints(double a, double b, double step) {
  var x = a;
  final values = <double>[];

  while (x < b) {
    values.add(x);
    x += step;
  }
  if ((values.last - b).abs() > 0.01) {
    values.add(b);
  }

  return values;
}

double middleRect(double a, double b, double step) {
  final points = getPoints(a, b, step);
  double res = 0;

  for (int i = 0; i < points.length - 1; i++) {
    res += f((points[i + 1] + points[i]) / 2) * (points[i + 1] - points[i]);
  }

  return res;
}

double res38(double a, double b, double step) {
  final points = getPoints(a, b, step);
  double res = 0;

  for (int i = 0; i < points.length - 1; i++) {
    res += f38(points[i], points[i + 1]);
  }

  return res;
}
