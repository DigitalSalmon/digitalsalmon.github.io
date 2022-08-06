public class CellContainsNumber : ValidationStep {
	public override void Validate(Vector2Int cell, int value, Model model) {
		if (!model.TryGetKnownValue(cell, out int cellValue)) return;
		
		if (cellValue != value) {
			model.RegisterInvalidValue(value, cell);
		}
	}
}

public class AdjacentConsecutive : ValidationStep {
	public override void Validate(Vector2Int cell, int value, Model model) {
		bool IsConsective(int a, int b) {
			if (a == b - 1 || a == b + 1) return true;
			return false;
		}

		if (model.TryGetKnownValue(cell + Solver.Up, out int testCellValue)) {
			if (IsConsective(value, testCellValue)) {
				model.RegisterInvalidValue(value, cell);
				return;
			}
		}

		if (model.TryGetKnownValue(cell + Solver.Right, out testCellValue)) {
			if (IsConsective(value, testCellValue)) {
				model.RegisterInvalidValue(value, cell);
				return;
			}
		}

		if (model.TryGetKnownValue(cell + Solver.Down, out testCellValue)) {
			if (IsConsective(value, testCellValue)) {
				model.RegisterInvalidValue(value, cell);
				return;
			}
		}

		if (model.TryGetKnownValue(cell + Solver.Left, out testCellValue)) {
			if (IsConsective(value, testCellValue)) {
				model.RegisterInvalidValue(value, cell);
			}
		}
	}
}

public class SudokuMatches : ValidationStep {
	public override void Validate(Vector2Int cell, int value, Model model) {
		int testCellValue = 0;
		for (int x = 0; x < Model.Width; x++) {
			if (model.TryGetKnownValue(new Vector2Int(x, cell.y), out testCellValue)) {
				if (testCellValue == value) {
					model.RegisterInvalidValue(value, cell);
					return;
				}
			}
		}

		for (int y = 0; y < Model.Height; y++) {
			if (model.TryGetKnownValue(new Vector2Int(cell.x, y), out testCellValue)) {
				if (testCellValue == value) {
					model.RegisterInvalidValue(value, cell);
					return;
				}
			}
		}
	}
}