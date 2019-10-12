type row = ( char * char * char)
type map = { a : row; b : row; c : row }

let print_row row =
	let (a, b, c) = row in
	print_char a; print_char ' ';
	print_char b; print_char ' ';
	print_char c

let rec print_map map height =
	if height = 3 then
		begin
		print_row map.a;
		print_char '\n';
		print_map map (height - 1)
		end
	else if height = 2 then
		begin
		print_row map.b;
		print_char '\n';
		print_map map (height - 1)
		end
	else if height = 1 then
		begin
		print_row map.c;
		print_char '\n';
		print_map map (height - 1)
		end
	else
		()

let () =
	let new_row = ( '-', '-', '-' ) in
	let new_map = { a = new_row; b = new_row; c = new_row } in

	print_map new_map 3
