void main(List<String> arguments) {
  final matrix = [
    [0.8, 1.56, -0.16, 3.64],
    [0.08, -0.4, 0.96, 1.76],
    [-0.5, -0.23, -0.24, -2.21]
  ];

  final matrixB = [
    [-0.5, -0.23, -0.24, -2.21],
    [0.8, 1.56, -0.16, 3.64],
    [0.08, -0.4, 0.96, 1.76],
  ];
  print('Метод Гаусса');
  print(solveByGaussian(getClonedMatrix(matrix)));
  print('Метод Гаусса с выбором главного элемента');
  print(solveByModifiedGaussian(getClonedMatrix(matrix)));
  print('Метод Якоби');
  print(solveByJacobi(getClonedMatrix(matrixB)));
  print('Метод Метод Гаусса-Зейделя');
  print(solveByGaussianSeidel(getClonedMatrix(matrixB)));
}

List<List<double>> getClonedMatrix(List<List<double>> matrix) {
  final res = <List<double>>[];
  for (int i = 0; i < matrix.length; i++) {
    final line = [...matrix[i]];
    res.add(line);
  }

  return res;
}

List<double> solveByGaussian(List<List<double>> matrix) {
  for (int i = 0; i < matrix.length - 1; i++) {
    for (int j = i + 1; j < matrix.length; j++) {
      final line = matrix[j];

      final multiplier = line[i] / matrix[i][i];
      line[i] = 0;

      for (int z = i + 1; z < line.length; z++) {
        line[z] = line[z] - matrix[i][z] * multiplier;
      }
    }
  }

  final roots = <double>[];
  for (int i = matrix.length - 1; i > -1; i--) {
    final line = matrix[i];

    double sum = 0;
    for (int j = line.length - 2; j != i; j -= 1) {
      sum += line[j];
    }

    final root = (line[line.length - 1] - sum) / line[i];
    roots.add(root);

    if (i == 0) {
      continue;
    }

    matrix[i - 1][i] *= roots[roots.length - 1];
  }

  return roots.reversed.toList();
}

List<double> solveByModifiedGaussian(List<List<double>> matrix) {
  final fistRowElement = getMaxLineByElementPosition(0, matrix);
  final secondRowElement = getMaxLineByElementPosition(1, matrix);
  final thirdRowElement = getMaxLineByElementPosition(2, matrix);

  return solveByGaussian([fistRowElement, secondRowElement, thirdRowElement]);
}

List<double> getMaxLineByElementPosition(int position, List<List<double>> matrix) {
  final maxFirstRow = matrix[0][position].abs();
  final maxSecondRow = matrix[1][position].abs();
  final maxThirdRow = matrix[2][position].abs();

  if (maxFirstRow >= maxSecondRow && maxFirstRow >= maxThirdRow) {
    return matrix[0];
  } else if (maxSecondRow >= maxFirstRow && maxSecondRow >= maxThirdRow) {
    return matrix[1];
  }

  return matrix[2];
}

List<double> solveByJacobi(List<List<double>> matrix) {
  final solutions = <List<double>>[
    [1, 1, 1]
  ];

  var count = 0;
  while (true) {
    count++;

    var solution = <double>[];

    for (var i = 0; i < matrix.length; i++) {
      final line = matrix[i];
      var lineSum = line[line.length - 1];
      for (var j = 0; j < line.length - 1; j++) {
        if (i == j) {
          continue;
        }
        lineSum -= line[j] * solutions[solutions.length - 1][j];
      }

      solution.add(lineSum / line[i]);
    }

    if (getNorm(solution, solutions[solutions.length - 1]) <= 0.00005) {
      print('Количество итераций - $count');
      return solution;
    }

    solutions.add(solution);
  }
}

double getNorm(List<double?> solutionA, List<double?> solutionB) =>
    ((solutionA[0]! - solutionB[0]!)).abs() +
    ((solutionA[1]! - solutionB[1]!)).abs() +
    ((solutionA[2]! - solutionB[2]!)).abs();

List<double?> solveByGaussianSeidel(List<List<double>> matrix) {
  final solutions = <List<double?>>[
    [1, 1, 1]
  ];

  var count = 0;
  while (true) {
    count++;

    var solution = <double?>[null, null, null];

    for (var i = 0; i < matrix.length; i++) {
      final line = matrix[i];
      var lineSum = line[line.length - 1];
      for (var j = 0; j < line.length - 1; j++) {
        if (i == j) {
          continue;
        }
        final value = solution[j] ?? solutions[solutions.length - 1][j];
        lineSum -= line[j] * value!;
      }

      solution[i] = lineSum / line[i];
    }

    if (getNorm(solution, solutions[solutions.length - 1]) <= 0.00005) {
      print('Количество итераций - $count');
      return solution;
    }

    solutions.add(solution);
  }
}
