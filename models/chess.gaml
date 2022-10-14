/**
* Name: Chess
* Based on the internal skeleton template. 
* Author: manoa
* Tags: 
*/
model Chess

import 'apparence/black_bishop.gaml'
import 'apparence/black_king.gaml'
import 'apparence/black_knight.gaml'
import 'apparence/black_pawn.gaml'
import 'apparence/black_queen.gaml'
import 'apparence/black_rook.gaml'
import 'apparence/white_bishop.gaml'
import 'apparence/white_king.gaml'
import 'apparence/white_knight.gaml'
import 'apparence/white_pawn.gaml'
import 'apparence/white_queen.gaml'
import 'apparence/white_rook.gaml'

global {
	int index <- 0;
	bool tour <- true;
	int black_pawn_position <- 0;
	int white_pawn_position <- 0;
	int white_rook_position <- 0;
	int black_rook_position <- 0;
	int white_bishop_position <- 2;
	int black_bishop_position <- 2;
	int white_knight_position <- 1;
	int black_knight_position <- 1;
	list<Echiquier> mouvement <- [];
	list<Pieces> selected_pieces <- [];
	list historique <- [];
	list<Echiquier> histoMoves <- [Echiquier[1, 2], Echiquier[1, 2]];
	list<string>
	case <- ['a8', 'b8', 'c8', 'd8', 'e8', 'f8', 'g8', 'h8', 'a7', 'b7', 'c7', 'd7', 'e7', 'f7', 'g7', 'h7', 'a6', 'b6', 'c6', 'd6', 'e6', 'f6', 'g6', 'h6', 'a5', 'b5', 'c5', 'd5', 'e5', 'f5', 'g5', 'h5', 'a4', 'b4', 'c4', 'd4', 'e4', 'f4', 'g4', 'h4', 'a3', 'b3', 'c3', 'd3', 'e3', 'f3', 'g3', 'h3', 'a2', 'b2', 'c2', 'd2', 'e2', 'f2', 'g2', 'h2', 'a1', 'b1', 'c1', 'd1', 'e1', 'f1', 'g1', 'h1'];

	init {
		create Black_pawn number: 8 {
			do move_to(Echiquier[black_pawn_position, 1]);
			side <- false;
			black_pawn_position <- black_pawn_position + 1;
		}

		create White_pawn number: 8 {
			side <- true;
			do move_to(Echiquier[white_pawn_position, 6]);
			white_pawn_position <- white_pawn_position + 1;
		}

		create White_rook number: 2 {
			side <- true;
			do move_to(Echiquier[white_rook_position, 7]);
			white_rook_position <- white_rook_position + 7;
		}

		create Black_rook number: 2 {
			side <- false;
			do move_to(Echiquier[black_rook_position, 0]);
			black_rook_position <- black_rook_position + 7;
		}

		create White_bishop number: 2 {
			side <- true;
			do move_to(Echiquier[white_bishop_position, 7]);
			white_bishop_position <- white_bishop_position + 3;
		}

		create Black_bishop number: 2 {
			side <- false;
			do move_to(Echiquier[black_bishop_position, 0]);
			black_bishop_position <- black_bishop_position + 3;
		}

		create White_knight number: 2 {
			side <- true;
			do move_to(Echiquier[white_knight_position, 7]);
			white_knight_position <- white_knight_position + 5;
		}

		create Black_knight number: 2 {
			side <- false;
			do move_to(Echiquier[black_knight_position, 0]);
			black_knight_position <- black_knight_position + 5;
		}

		create White_king number: 1 {
			side <- true;
			do move_to(Echiquier[4, 7]);
		}

		create White_queen number: 1 {
			side <- true;
			do move_to(Echiquier[3, 7]);
		}

		create Black_king number: 1 {
			side <- false;
			do move_to(Echiquier[4, 0]);
		}

		create Black_queen number: 1 {
			side <- false;
			do move_to(Echiquier[3, 0]);
		}

		ask Echiquier {
			do setNumero(case[index]);
			index <- index + 1;
			do initPaint;
		}

	}

	bool checked {
		Pieces queen <- one_of(agents of_generic_species Pieces where (each.side = tour and each.valeur = 0));
		return false;
	}

	Pieces selectAvalaiblePiece {
		list<Echiquier> mv <- [];
		Pieces pi <- one_of(agents of_generic_species Pieces where (each.side = tour and each.cloue = false));
		ask pi {
			mv <- mouvements();
		}

		if (mv = []) {
			do selectAvalaiblePiece();
		} else {
			return pi;
		}

	}

	reflex updateMouvement {
		Pieces toEnd <- one_of(agents of_generic_species Pieces where (each.side = tour and each.valeur = 0));
		if (toEnd = nil) {
			write "Partie terminée";
			do pause;
		}

		list<Echiquier> lastMove <- [];
		Pieces pi <- selectAvalaiblePiece();
		ask (agents of_generic_species Pieces where (each.valeur != -1)) {
			self.cloue <- false;
		}

		ask pi {
			mouvement <- mouvements();
			add current_cell to: lastMove;
			//write length(neighbors_at)
			do repaint(current_cell);
			mouvement <- mouvements();
			ask mouvement {
				do mouvementPaint;
			}

			Echiquier move <- one_of(mouvement);
			add move to: lastMove;
			if (move != []) {
				if (pi.valeur = 1) {
					ask (agents of_generic_species Hole inside (move)) {
						do deletePawn;
					}

				}

				ask (agents of_generic_species Pieces inside (move)) {
					do die;
				}

				do move_to(move);
				if (pi.valeur = 1) {
					if (pi.side = true and pi.current_cell.grid_y = 4 and lastMove[0].grid_y = 6) {
						create Hole number: 1 {
							pie <- pi;
							side <- true;
							do move_to(Echiquier[pi.current_cell.grid_x, 5]);
						}

					} else if (pi.side = false and pi.current_cell.grid_y = 3 and lastMove[0].grid_y = 1) {
						create Hole number: 1 {
							pie <- pi;
							side <- false;
							do move_to(Echiquier[pi.current_cell.grid_x, 2]);
						}

					}

					int randomKey <- rnd(0, 3);
					if (pi.side = true and pi.current_cell.grid_y = 0) {
						switch (randomKey) {
							match 0 {
								create White_queen number: 1 {
									side <- true;
									do move_to(Echiquier[pi.current_cell.grid_x, 0]);
								}

							}

							match 1 {
								create White_rook number: 1 {
									side <- true;
									do move_to(Echiquier[pi.current_cell.grid_x, 0]);
								}

							}

							match 2 {
								create White_bishop number: 1 {
									side <- true;
									do move_to(Echiquier[pi.current_cell.grid_x, 0]);
								}

							}

							match 3 {
								create White_knight number: 1 {
									side <- true;
									do move_to(Echiquier[pi.current_cell.grid_x, 0]);
								}

							}

							default {
								write ("Default");
							}

						}

						mouvement <- [];
						do repaintMove(lastMove);
						tour <- !tour;
						selected_pieces <- [];
						do die;
					} else {
						if (pi.side = false and pi.current_cell.grid_y = 7) {
							switch (randomKey) {
								match 0 {
									create Black_queen number: 1 {
										side <- false;
										do move_to(Echiquier[pi.current_cell.grid_x, 7]);
									}

								}

								match 1 {
									create Black_rook number: 1 {
										side <- false;
										do move_to(Echiquier[pi.current_cell.grid_x, 7]);
									}

								}

								match 2 {
									create Black_bishop number: 1 {
										side <- false;
										do move_to(Echiquier[pi.current_cell.grid_x, 7]);
									}

								}

								match 3 {
									create Black_knight number: 1 {
										side <- false;
										do move_to(Echiquier[pi.current_cell.grid_x, 7]);
									}

								}

								default {
									write ("Default");
								}

							}

							mouvement <- [];
							do repaintMove(lastMove);
							tour <- !tour;
							selected_pieces <- [];
							do die;
						} else {
							mouvement <- [];
							do repaintMove(lastMove);
							tour <- !tour;
							selected_pieces <- [];
						}

					}

				} else {
					mouvement <- [];
					do repaintMove(lastMove);
					tour <- !tour;
					selected_pieces <- [];
				}

			}

		}

	}

	action handle_mouse_event {
		list<Echiquier> tes <- agents of_generic_species Echiquier where (each overlaps #user_location);
		if (tes != []) {
			write tes[0].numero;
		}

		if (selected_pieces = agents of_generic_species Pieces where (each.current_cell overlaps #user_location) and !empty(agents of_generic_species Pieces where (each.current_cell
		overlaps #user_location))) {
			selected_pieces <- [];
			mouvement <- [];
			ask Echiquier {
				do initPaint;
			}

		} else {
			if (!empty(agents of_generic_species Pieces where (each.current_cell overlaps #user_location and tour = each.side))) {
				selected_pieces <- agents of_generic_species Pieces where (each.current_cell overlaps #user_location);
				mouvement <- [];
			}

			if (!empty(selected_pieces) and tour = selected_pieces[0].side) {
				if (empty(mouvement)) {
					ask selected_pieces {
						do repaint(current_cell);
						mouvement <- mouvements();
						put current_cell in: histoMoves at: 0;
						ask mouvement {
							do mouvementPaint;
						}

					}

				} else {
					ask selected_pieces {
						Pieces pi <- selected_pieces[0];
						list<Echiquier> move <- mouvement where (each overlaps #user_location);
						if (move != []) {
							if (pi.valeur = 1) {
								ask (agents of_generic_species Hole inside (move[0])) {
									do deletePawn;
								}

							}

							ask (agents of_generic_species Pieces inside (move[0])) {
								do die;
							}

							//							add selected_pieces to: historique;
							//							write historique;
							do move_to(move[0]);
							put move[0] in: histoMoves at: 1;
							if (pi.valeur = 1) {
								if (pi.side = true and pi.current_cell.grid_y = 4 and histoMoves[0].grid_y = 6) {
									create Hole number: 1 {
										pie <- pi;
										side <- true;
										do move_to(Echiquier[pi.current_cell.grid_x, 5]);
									}

								} else if (pi.side = false and pi.current_cell.grid_y = 3 and histoMoves[0].grid_y = 1) {
									create Hole number: 1 {
										pie <- pi;
										side <- false;
										do move_to(Echiquier[pi.current_cell.grid_x, 2]);
									}

								}

								int randomKey <- rnd(0, 3);
								if (pi.side = true and pi.current_cell.grid_y = 0) {
									switch (randomKey) {
										match 0 {
											create White_queen number: 1 {
												side <- true;
												do move_to(Echiquier[pi.current_cell.grid_x, 0]);
											}

										}

										match 1 {
											create White_rook number: 1 {
												side <- true;
												do move_to(Echiquier[pi.current_cell.grid_x, 0]);
											}

										}

										match 2 {
											create White_bishop number: 1 {
												side <- true;
												do move_to(Echiquier[pi.current_cell.grid_x, 0]);
											}

										}

										match 3 {
											create White_knight number: 1 {
												side <- true;
												do move_to(Echiquier[pi.current_cell.grid_x, 0]);
											}

										}

										default {
											write ("Default");
										}

									}

									mouvement <- [];
									do repaintMove(histoMoves);
									tour <- !tour;
									selected_pieces <- [];
									do die;
								} else {
									if (pi.side = false and pi.current_cell.grid_y = 7) {
										switch (randomKey) {
											match 0 {
												create Black_queen number: 1 {
													side <- false;
													do move_to(Echiquier[pi.current_cell.grid_x, 7]);
												}

											}

											match 1 {
												create Black_rook number: 1 {
													side <- false;
													do move_to(Echiquier[pi.current_cell.grid_x, 7]);
												}

											}

											match 2 {
												create Black_bishop number: 1 {
													side <- false;
													do move_to(Echiquier[pi.current_cell.grid_x, 7]);
												}

											}

											match 3 {
												create Black_knight number: 1 {
													side <- false;
													do move_to(Echiquier[pi.current_cell.grid_x, 7]);
												}

											}

											default {
												write ("Default");
											}

										}

										mouvement <- [];
										do repaintMove(histoMoves);
										tour <- !tour;
										selected_pieces <- [];
										do die;
									} else {
										mouvement <- [];
										do repaintMove(histoMoves);
										tour <- !tour;
										selected_pieces <- [];
									}

								}

							} else {
								mouvement <- [];
								//								do repaintMove(histoMoves);
								tour <- !tour;
								selected_pieces <- [];
							}

						}

					}

				}

			}

		}

	}

	species Hole parent: Pieces {
		Pieces pie;
		int count <- 0;
		int valeur <- -1;

		aspect default {
			draw circle(2) color: #blue border: #yellow;
		}

		action deletePawn {
			ask agents of_generic_species Pawn where (each = self.pie) {
				do die;
			}

		}

		reflex deleteHole {
			count <- count + 1;
			if (count = 3) {
				do die;
			}

		}

	}

}

experiment Chess type: gui {
	output {
		display ma_grille {
			grid Echiquier lines: #black;
			species Black_pawn aspect: default;
			species White_pawn aspect: default;
			species White_rook aspect: default;
			species Black_rook aspect: default;
			species White_bishop aspect: default;
			species Black_bishop aspect: default;
			species White_knight aspect: default;
			species Black_knight aspect: default;
			species White_queen aspect: default;
			species White_king aspect: default;
			species Black_queen aspect: default;
			species Black_king aspect: default;
			species Hole aspect: default;
			event mouse_down action: handle_mouse_event;
		}

	}

}
