model bishop

import '../Root/Factory.gaml'
species Bishop parent: Factory {
	int valeur <- 3;
	string notation <- "B";
	list<list<int>> possibilities <- [[-1, -1], [-1, 1], [1, -1], [1, 1]];
	list<Echiquier> mouvements {
		
		list<Echiquier> mouvement <- [];
		list<list<int>> possibilitie <- [[-1, -1], [-1, 1], [1, -1], [1, 1]];
	
		loop i over: segment(possibilitie) {
			add i to: mouvement;
		}

		return mouvement;
	}

}
