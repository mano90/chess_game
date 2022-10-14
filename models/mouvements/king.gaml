/**
* Name: king
* Based on the internal empty template. 
* Author: manoa
* Tags: 
*/
model king

import '../Root/Factory.gaml'
species King parent: Pieces {
	bool echec <- false;
	int valeur <- 0;
	string notation <- "K";
	list<Echiquier> mouvements {
		list<Echiquier> mouvement <- [];
		list<Echiquier> occupiedPiece <- [];
		list<Echiquier> mouvementsAvalaible <- [];
		list<Echiquier> mouvementImpossible <- [];
		list<list<int>> deplacements <- [[1, 1], [1, -1], [-1, -1], [-1, 1], [1, 0], [-1, 0], [0, -1], [0, 1]];
		loop move over: deplacements {
			if (agents of_generic_species Pieces where (each.side = self.side and each.current_cell = Echiquier[current_cell.grid_x + move[0], current_cell.grid_y + move[1]]) = []) {
				if (Echiquier[current_cell.grid_x + move[0], current_cell.grid_y + move[1]] != nil) {
					add (Echiquier[current_cell.grid_x + move[0], current_cell.grid_y + move[1]]) to: mouvement;
				}

			}

		}

//		loop i over: mouvement {
//			add i to: mouvementsAvalaible;
//		}
//
//		loop i over: occupiedPiece {
//			add i to: mouvementsAvalaible;
//		}
//
//		loop i over: occupiedPiece {
//			if (mouvementsAvalaible contains i) {
//				remove i from: mouvementsAvalaible;
//			}
//
//		}

		mouvementImpossible <- movesUn(mouvement, Echiquier[current_cell.grid_x, current_cell.grid_y]);
//		write ("iMPOSSIBLE MOUVEMENT") + mouvementImpossible;
//		write ("LIST MOUVEMENT") + mouvement;
		loop i over: mouvementImpossible {
			if mouvement contains i {
				remove i from: mouvement;
			}

		}

		return mouvement;
	}

	reflex dontMove {
		if (side = true) {
			list<list<int>> data <- [[0, -1], [0, 1], [1, 0], [-1, 0], [-1, -1], [-1, 1], [1, -1], [1, 1]];
			loop i over: data {
				int a <- i[0];
				int b <- i[1];
				Pieces isEmpty;
				loop while: true {
					if (isEmpty = nil) {
						if (Echiquier[current_cell.grid_x + i[0], current_cell.grid_y + i[1]] = nil) {
							break;
						} else {
							if (agents of_generic_species Pieces where (each.valeur != -1 and each.side != self.side and
							each.current_cell = Echiquier[current_cell.grid_x + i[0], current_cell.grid_y + i[1]]) != []) {
								break;
							}

							if (agents of_generic_species Pieces where (each.valeur != -1 and each.side = self.side and
							each.current_cell = Echiquier[current_cell.grid_x + i[0], current_cell.grid_y + i[1]]) != []) {
								isEmpty <- one_of(agents of_generic_species Pieces where (each.valeur != -1 and each.side = self.side and
								each.current_cell = Echiquier[current_cell.grid_x + i[0], current_cell.grid_y + i[1]]));
							}

						}

					} else {
						if (Echiquier[current_cell.grid_x + i[0], current_cell.grid_y + i[1]] = nil) {
							break;
						} else {
							list<Factory> pieces <- agents of_generic_species Factory where (each.valeur != -1 and each.side != self.side and
							each.current_cell = Echiquier[current_cell.grid_x + i[0], current_cell.grid_y + i[1]]);
							if (pieces != []) {
								Pieces pieceMenacante <- pieces[0];
								if (pieceMenacante.possibilities contains [-a, -b]) {
									ask agents of_generic_species Factory where (each.valeur != -1 and each.side != self.side and
									each.current_cell = Echiquier[current_cell.grid_x + i[0], current_cell.grid_y + i[1]]) {
										self.cloue <- true;
									}

								}

								break;
							} else {
								break;
							}

							if (agents of_generic_species Pieces where (each.valeur != -1 and each.side = self.side and
							each.current_cell = Echiquier[current_cell.grid_x + i[0], current_cell.grid_y + i[1]]) != []) {
								break;
							}

						}

					}

					i[0] <- a + i[0];
					i[1] <- b + i[1];
				}

			}

		} else {
			list<list<int>> data <- [[0, -1], [0, 1], [1, 0], [-1, 0], [-1, -1], [-1, 1], [1, -1], [1, 1]];
			loop i over: data {
				int a <- i[0];
				int b <- i[1];
				Pieces isEmpty;
				loop while: true {
					if (isEmpty = nil) {
						if (Echiquier[current_cell.grid_x + i[0], current_cell.grid_y + i[1]] = nil) {
							break;
						} else {
							if (agents of_generic_species Pieces where (each.valeur != -1 and each.side != self.side and
							each.current_cell = Echiquier[current_cell.grid_x + i[0], current_cell.grid_y + i[1]]) != []) {
								break;
							}

							if (agents of_generic_species Pieces where (each.valeur != -1 and each.side = self.side and
							each.current_cell = Echiquier[current_cell.grid_x + i[0], current_cell.grid_y + i[1]]) != []) {
								isEmpty <- one_of(agents of_generic_species Pieces where (each.valeur != -1 and each.side = self.side and
								each.current_cell = Echiquier[current_cell.grid_x + i[0], current_cell.grid_y + i[1]]));
							}

						}

					} else {
						if (Echiquier[current_cell.grid_x + i[0], current_cell.grid_y + i[1]] = nil) {
							break;
						} else {
							list<Factory> pieces <- agents of_generic_species Factory where (each.valeur != -1 and each.side != self.side and
							each.current_cell = Echiquier[current_cell.grid_x + i[0], current_cell.grid_y + i[1]]);
							if (pieces != []) {
								Pieces pieceMenacante <- pieces[0];
								if (pieceMenacante.possibilities contains [-a, -b]) {
									ask agents of_generic_species Factory where (each.valeur != -1 and each.side != self.side and
									each.current_cell = Echiquier[current_cell.grid_x + i[0], current_cell.grid_y + i[1]]) {
										self.cloue <- true;
									}

								}

								break;
							} else {
								break;
							}

							if (agents of_generic_species Pieces where (each.valeur != -1 and each.side = self.side and
							each.current_cell = Echiquier[current_cell.grid_x + i[0], current_cell.grid_y + i[1]]) != []) {
								break;
							}

						}

					}

					i[0] <- a + i[0];
					i[1] <- b + i[1];
				}

			}

		}

	}

	list<Echiquier> movesUn (list<Echiquier> rawMoves, Echiquier current_position_piece) {
		list<Echiquier> toReturnMovesUn <- [];
		list<Echiquier> totalMoves <- [];
		loop i over: rawMoves {
			add i to: totalMoves;
		}

		add current_position_piece to: totalMoves;
		list<list<int>> data <- [[0, -1], [0, 1], [1, 0], [-1, 0], [-1, -1], [-1, 1], [1, -1], [1, 1]];
		list<list<int>> knight_moves <- [[1, 2], [1, -2], [-1, -2], [-1, 2], [-2, 1], [-2, -1], [2, 1], [2, -1]];
//		loop j over: rawMoves {
//			loop i over: data {
//				int a <- i[0];
//				int b <- i[1];
//				loop while: true {
//					if (Echiquier[j.grid_x + i[0], j.grid_y + i[1]] = nil) {
//						break;
//					} else {
//						if (agents of_generic_species Pieces where (each.side = self.side and each.current_cell = Echiquier[j.grid_x + i[0], j.grid_y + i[1]]) != []) {
//							break;
//						} else {
//							list<Factory> pieces <- agents of_generic_species Factory where (each.valeur != -1 and each.side != self.side and
//							each.current_cell = Echiquier[j.grid_x + i[0], j.grid_y + i[1]]);
//							if (pieces != []) {
//								Pieces pieceMenacante <- pieces[0];
//								//								if (pieceMenacante.possibilities contains [-a, -b]) {
//								//									ask agents of_generic_species Factory where ((each.valeur = 3 or each.valeur = 10 or each.valeur = 5) and each.side != self.side and
//								//									each.current_cell = Echiquier[j.grid_x + i[0], j.grid_y + i[1]]) {
//								//										add Echiquier[j.grid_x, j.grid_y] to: toReturnMovesUn;
//								//										write "ato";
//								//									}
//								//
//								//								}
//								//								write pieceMenacante;
//								ask pieceMenacante {
//									do repaint(self.current_cell);
//								}
//
//								break;
//							}
//
//							//						else {
//							//							break;
//							//						}
//						}
//
//					}
//
//					i[0] <- a + i[0];
//					i[1] <- b + i[1];
//				}
//
//			}
//
//		}

				loop i over: rawMoves {
					loop moveOne over: knight_moves {
						if (agents of_generic_species Pieces where (each.notation = "N" and each.side != self.side and each.current_cell = Echiquier[i.grid_x + moveOne[0], i.grid_y + moveOne[1]]) !=
						[]) {
							add Echiquier[i.grid_x, i.grid_y] to: toReturnMovesUn;
						}
		
					}
		
					if (side = false) {
						if (agents of_generic_species Pieces where (each.valeur = 1 and each.side = true and each.current_cell = Echiquier[i.grid_x + 1, i.grid_y + 1]) != []) {
							add Echiquier[i.grid_x, i.grid_y] to: toReturnMovesUn;
						}
		
						if (agents of_generic_species Pieces where (each.valeur = 1 and each.side = true and each.current_cell = Echiquier[i.grid_x - 1, i.grid_y + 1]) != []) {
							add Echiquier[i.grid_x, i.grid_y] to: toReturnMovesUn;
						}
		
					} else {
						if (agents of_generic_species Pieces where (each.valeur = 1 and each.side = false and each.current_cell = Echiquier[i.grid_x + 1, i.grid_y - 1]) != []) {
							add Echiquier[i.grid_x, i.grid_y] to: toReturnMovesUn;
						}
		
						if (agents of_generic_species Pieces where (each.valeur = 1 and each.side = false and each.current_cell = Echiquier[i.grid_x - 1, i.grid_y - 1]) != []) {
							add Echiquier[i.grid_x, i.grid_y] to: toReturnMovesUn;
						}
		
					}
		
				}
		return toReturnMovesUn;
	}

}

/* Insert your model definition here */

