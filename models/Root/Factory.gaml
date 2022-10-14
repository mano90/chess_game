/**
* Name: Factory
* Based on the internal empty template. 
* Author: manoa
* Tags: 
*/
model Factory

import './Piece.gaml'
species Factory parent: Pieces {
	list<Echiquier> segment (list<list<int>> data) {
		list<Echiquier> moves <- [];
		loop i over: data {
			int a <- i[0];
			int b <- i[1];
			loop while: true {
				if (Echiquier[current_cell.grid_x + i[0], current_cell.grid_y + i[1]] = nil) {
					break;
				} else {
					if (agents of_generic_species Pieces where (each.side != self.side and each.current_cell = Echiquier[current_cell.grid_x + i[0], current_cell.grid_y + i[1]]) != []) {
						add Echiquier[current_cell.grid_x + i[0], current_cell.grid_y + i[1]] to: moves;
						break;
					}

					if (agents of_generic_species Pieces where (each.side = self.side and each.current_cell = Echiquier[current_cell.grid_x + i[0], current_cell.grid_y + i[1]]) = []) {
						add Echiquier[current_cell.grid_x + i[0], current_cell.grid_y + i[1]] to: moves;
					} else {
						break;
					}

				}

				i[0] <- a + i[0];
				i[1] <- b + i[1];
			}

		}

		return moves;
	}

	Pieces reverseSegment (list<int> data, Pieces piece) {
		Pieces pieceToReturn <- [];
		int a <- data[0];
		int b <- data[1];
		loop while: true {
			if (Echiquier[piece.current_cell.grid_x + data[0], piece.current_cell.grid_y + data[1]] = nil) {
				break;
			} else {
				if ((agents of_generic_species Pieces where (each.current_cell = Echiquier[current_cell.grid_x + data[0], current_cell.grid_y + data[1]]) != [])) {
					pieceToReturn <- one_of(agents of_generic_species Pieces inside (Echiquier[current_cell.grid_x + data[0], current_cell.grid_y] + data[1]));
					break;
				}
				//				add Echiquier[piece.current_cell.grid_x + data[0], piece.current_cell.grid_y + data[1]] to: moves;
			}

			data[0] <- a + data[0];
			data[1] <- b + data[1];
		}

		return pieceToReturn;
	}

}
/* Insert your model definition here */

