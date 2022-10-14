/**
* Name: Echiquier
* Based on the internal empty template. 
* Author: manoa
* Tags: 
*/
model Echiquier

grid Echiquier width: 8 height: 8 neighbors: 8 {
	string numero;

	init {
	//		numero <- case[index];
	//		index <- index + 1;
	}

	action initPaint {
		if (((grid_x + grid_y) mod 2) = 0) {
			color <- #saddlebrown;
		} else {
			color <- #darkkhaki;
		}

	}

	action setNumero (string case) {
		numero <- case;
	}

	action repaint {
		do initPaint;
		color <- #green;
	}

	action repaintMove {
		do initPaint;
		color <- #darkgoldenrod;
	}

	action mouvementPaint {
		color <- #lime;
	}

}

