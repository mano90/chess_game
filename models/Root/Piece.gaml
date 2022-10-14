/**
* Name: Pieces
* Based on the internal empty template. 
* Author: manoa
* Tags: 
*/
model Piece

import 'Echiquier.gaml'
species Pieces {
	list<list<int>> possibilities;
	Echiquier current_cell;
	bool side;
	int valeur;
	bool cloue <- false;
	string notation;
	list<Echiquier> mouvements {
		return nil;
	}

	action move_to (Echiquier echiquier) {
		current_cell <- echiquier;
		location <- echiquier.location;
	}

	action repaint (Echiquier cellule) {
		ask Echiquier {
			do initPaint;
		}

		ask Echiquier where (each.grid_x = cellule.grid_x and each.grid_y = cellule.grid_y) {
			do repaint;
		}

	}
	
	action repaintMove (list<Echiquier> cellule) {
		ask Echiquier {
			do initPaint;
		}

		ask Echiquier where (each.grid_x = cellule[0].grid_x and each.grid_y = cellule[0].grid_y) {
			do repaintMove;
		}
		ask Echiquier where (each.grid_x = cellule[1].grid_x and each.grid_y = cellule[1].grid_y) {
			do repaintMove;
		}

	}

	action move {
		return nil;
	}
	
	Pieces reverseSegment (list<int> data, Pieces piece){
		return nil;
	}

}

/* Insert your model definition here */

