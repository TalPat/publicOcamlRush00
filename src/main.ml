open InputParser
open TalonStuff
open TicTac
open Menu

let place_map token pos map =
		match token with
		| X -> List.mapi (fun i x -> if i = (pos-1) && x = E then X else x) map
		| _ -> List.mapi (fun i x -> if i = (pos-1) && x = E then O else x) map

let place_board board token (x, y) =
	List.mapi (fun i a -> if i = (x - 1) then place_map token y a else a) board

let rec iaMain board pl =
	begin
	match pl with
	| O -> print_string "O's turn to play.\n"
	| _ -> print_string "X's turn to play.\n"
	end;
	let input =
		if pl = X
		then get_input () 
		else placeToken (pl, 0) board
	in
	let new_board = place_board board pl input in
	if (board = new_board) then
		begin	
			print_string "Invalid placement\n";
			iaMain board pl
		end
	else
		begin
			let new_board = checkBoard new_board in
			print_char '\n';
			print_board new_board;
			print_char '\n';

			if checkGameOver new_board != E
			then begin
				match checkGameOver new_board with
					| X -> print_endline "X wins";
					| O -> print_endline "O wins";
					| _ -> print_endline "Stalemate";
					if yesNo () = "Y"
					then
						newGame ()
					else
						exit 0
			end
			else

			iaMain new_board (if pl = O then X else O)
		end

and main board pl =
	begin
	match pl with
	| O -> print_string "O's turn to play.\n"
	| _ -> print_string "X's turn to play.\n"
	end;
	let input = get_input () in
	let new_board = place_board board pl input in
	if (board = new_board) then
		begin	
			print_string "Invalid placement\n";
			main board pl
		end
	else
		begin
			let new_board = checkBoard new_board in
			print_char '\n';
			print_board new_board;
			print_char '\n';

			if checkGameOver new_board != E
			then begin
				match checkGameOver new_board with
					| X -> print_endline "X wins";
					| O -> print_endline "O wins";
					| _ -> print_endline "Stalemate";
					if yesNo () = "Y"
					then
						newGame ()
					else
						exit 0
			end
			else

			main new_board (if pl = O then X else O)
		end

and newGame () =
	let new_map = [E; E; E; E; E; E; E; E; E] in
	let board = [new_map; new_map; new_map; new_map; new_map; new_map; new_map; new_map; new_map; new_map] in
	let (name1, name2) = new_menu () in
	print_board board;
	print_char '\n';
	if name1 = "IA"
	then iaMain board O
	else main board O

let () =
	newGame ()
