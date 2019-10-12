open TalonStuff

let rec print_map_row map first last count =
	if count < first then
		match map with
		| [] -> ()
		| head::tail -> print_map_row tail first last (count + 1)
	else if first <= last then
		match map with
		| [] -> ()
		| head::tail ->
			begin
				match head with
				| X -> print_char 'X'
				| O -> print_char 'O'
				| _ -> print_char '-'
			end;
			print_char ' ';
			print_map_row tail (first + 1) last (count + 1)
	else
		()

let print_3_maps map1 map2 map3 =
	print_map_row map1 1 3 1;
	print_string "| ";
	print_map_row map2 1 3 1;
	print_string "| ";
	print_map_row map3 1 3 1;
	print_char '\n';
	print_map_row map1 4 6 1;
	print_string "| ";
	print_map_row map2 4 6 1;
	print_string "| ";
	print_map_row map3 4 6 1;
	print_char '\n';
	print_map_row map1 7 9 1;
	print_string "| ";
	print_map_row map2 7 9 1;
	print_string "| ";
	print_map_row map3 7 9 1;
	print_char '\n'

let rec print_board board =
	match board with
	| [x] -> ()
	| head::tail ->
		match tail with
		| [y] -> ()
		| _ -> match head::tail with
			| first::second::third::tail ->
				print_3_maps first second third;
				match tail with
				| [] -> ();
				| h::t ->
					match t with
					| [] -> ();
					| _ ->
						begin
							print_endline "---------------------";
							print_board tail
						end
