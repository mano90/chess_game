/**
* Name: queen
* Based on the internal empty template. 
* Author: manoa
* Tags: 
*/
model queen

import '../Root/Factory.gaml'
species Queen parent: Factory {
	int valeur <- 10;
	string notation <- "Q";
	list<list<int>> possibilities <- [[0, -1], [0, 1], [1, 0], [-1, 0], [-1, -1], [-1, 1], [1, -1], [1, 1]];
	list<Echiquier> mouvements {
		list<list<int>> possibilitie <- [[0, -1], [0, 1], [1, 0], [-1, 0], [-1, -1], [-1, 1], [1, -1], [1, 1]];
		list<Echiquier> mouvement <- [];
		loop i over: segment(possibilitie) {
			add i to: mouvement;
		}

		return mouvement;
	}

}

/* Insert your model definition here */

