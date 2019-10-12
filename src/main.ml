open InputParser
open TalonStuff
open TicTac

let place_map token pos map =
		match token with
		| X -> List.mapi (fun i x -> if i = (pos-1) then X else x) map
		| O -> List.mapi (fun i x -> if i = (pos-1) then O else x) map

let place_board board token (x, y) =
	List.mapi (fun i a -> if i = (x - 1) then place_map token y a else a) board

let rec main board pl =
	print_board board;
	begin
	match pl with
	| O -> print_string "O's turn to play.\n"
	| X -> print_string "X's turn to play.\n"
	end;
	let input = get_input () in
	let new_board = place_board board pl input in
	main new_board (if pl = O then X else O)

let () =
	let new_map = [E; E; E; E; E; E; E; E; E] in
	let board = [new_map; new_map; new_map; new_map; new_map; new_map; new_map; new_map; new_map] in

	main board O;
	()
