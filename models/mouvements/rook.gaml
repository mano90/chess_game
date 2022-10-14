/**
* Name: rook
* Based on the internal empty template. 
* Author: manoa
* Tags: 
*/
model rook

import '../Root/Factory.gaml'
species Rook parent: Factory {
	int valeur <- 5;
	string notation <- "R";
	list<list<int>> possibilities <- [[0, -1], [0, 1], [1, 0], [-1, 0]];
		
	list<Echiquier> mouvements {
		list<Echiquier> mouvement <- [];
			list<list<int>> possibilitie <- [[0, -1], [0, 1], [1, 0], [-1, 0]];
	
		loop i over: segment(possibilitie) {
			add i to: mouvement;
		}

		return mouvement;
	}

}
/* Insert your model definition here */

