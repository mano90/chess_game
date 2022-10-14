/**
* Name: knight
* Based on the internal empty template. 
* Author: manoa
* Tags: 
*/
model knight

import '../Root/Piece.gaml'
species Knight parent: Pieces {
	int valeur <- 3;
	string notation <- "N";
	list<Echiquier> mouvements {
		list<Echiquier> mouvement <- [];
		list alalaibles_moves <- [[1, 2], [1, -2], [-1, -2], [-1, 2], [-2, 1], [-2, -1], [2, 1], [2, -1]];
		loop move over: alalaibles_moves {
			if (agents of_generic_species Pieces where (each.side = self.side and each.current_cell = Echiquier[current_cell.grid_x + move[0], current_cell.grid_y + move[1]]) = []) {
				if (Echiquier[current_cell.grid_x + move[0], current_cell.grid_y + move[1]] != nil) {
					add (Echiquier[current_cell.grid_x + move[0], current_cell.grid_y + move[1]]) to: mouvement;
				}

			}

		}

		return mouvement;
	}

}
/* Insert your model definition here */

