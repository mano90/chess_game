/**
* Name: pawn
* Based on the internal empty template. 
* Author: manoa
* Tags: 
*/
model pawn

import '../Root/Piece.gaml'
species Pawn parent: Pieces {
	int valeur <- 1;
	list<Echiquier> mouvements {
		list<Echiquier> mouvement <- [];
		if (side = false) {
			if (agents of_generic_species Pieces where (each.side = true and each.current_cell = Echiquier[current_cell.grid_x + 1, current_cell.grid_y + 1]) != []) {
				add Echiquier[current_cell.grid_x + 1, current_cell.grid_y + 1] to: mouvement;
			}

			if (agents of_generic_species Pieces where (each.side = true and each.current_cell = Echiquier[current_cell.grid_x - 1, current_cell.grid_y + 1]) != []) {
				add Echiquier[current_cell.grid_x - 1, current_cell.grid_y + 1] to: mouvement;
			}

			if (agents of_generic_species Pieces where (each.current_cell = Echiquier[current_cell.grid_x, current_cell.grid_y + 1]) = []) {
				if (current_cell.grid_y = 1) {
					if (agents of_generic_species Pieces where (each.side = true and each.current_cell = Echiquier[current_cell.grid_x, current_cell.grid_y + 2]) = []) {
						add Echiquier[current_cell.grid_x, current_cell.grid_y + 2] to: mouvement;
					}

					add Echiquier[current_cell.grid_x, current_cell.grid_y + 1] to: mouvement;
				} else {
					add Echiquier[current_cell.grid_x, current_cell.grid_y + 1] to: mouvement;
				}

			}

		} else {
			if (agents of_generic_species Pieces where (each.side = false and each.current_cell = Echiquier[current_cell.grid_x + 1, current_cell.grid_y - 1]) != []) {
				add Echiquier[current_cell.grid_x + 1, current_cell.grid_y - 1] to: mouvement;
			}

			if (agents of_generic_species Pieces where (each.side = false and each.current_cell = Echiquier[current_cell.grid_x - 1, current_cell.grid_y - 1]) != []) {
				add Echiquier[current_cell.grid_x - 1, current_cell.grid_y - 1] to: mouvement;
			}

			if (agents of_generic_species Pieces where (each.current_cell = Echiquier[current_cell.grid_x, current_cell.grid_y - 1]) = []) {
				if (current_cell.grid_y = 6) {
					if (agents of_generic_species Pieces where (each.side = false and each.current_cell = Echiquier[current_cell.grid_x, current_cell.grid_y - 2]) = []) {
						add Echiquier[current_cell.grid_x, current_cell.grid_y - 2] to: mouvement;
					}

					add Echiquier[current_cell.grid_x, current_cell.grid_y - 1] to: mouvement;
				} else {
					add Echiquier[current_cell.grid_x, current_cell.grid_y - 1] to: mouvement;
				}

			}

		}

		return mouvement;
	}

}

