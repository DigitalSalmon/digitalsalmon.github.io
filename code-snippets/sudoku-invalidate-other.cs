public class WouldInvalidateAnotherGroup : ValidationStep {
	public override void Validate(Vector2Int cell, int value, Model model) {
		Vector2Int groupID = Model.GroupIDFromCell(cell);
		if (model.GroupHasKnownValue(groupID, value)) {
			return;
		}

		if (model.TryGetKnownValue(cell, out int cellValue)) {
			return;
		}

		List<ValidationStep> validators = new List<ValidationStep>();
		validators.Add(new SudokuMatches());
		validators.Add(new KingsMoveMatches());
		validators.Add(new KnightsMoveMatches());
		validators.Add(new AdjacentConsecutive());
		validators.Add(new CellContainsNumber());

		Model tempModel = Model.CopyTemp(model);
		tempModel.RegisterKnownCell(cell, value);

		Solver.ActiveModel = tempModel;

		for (int j = -1; j <= 1; j++) {
			int index = value + j;
			if (index < 1 || index > 9) continue;
			Solver.ActiveIndex = index;

			// Get all the cells that need checking again.
			HashSet<Vector2Int> potentialCells = tempModel.GetPotentialCells(index);

			foreach (Vector2Int potentialCell in potentialCells) {
				Solver.ActiveCell = potentialCell;

				// Validate that the cell can still contain their potential value.
				foreach (ValidationStep validator in validators) {
					validator.Validate(potentialCell, index, tempModel);
				}
			}

			if (tempModel.HasFullyInvalidatedGroup(out Vector2Int invalidatedGroupID, out int invalidatedGroupValue)) {
				model.RegisterInvalidValue(value, cell);
				return;
			}
		}
	}
}