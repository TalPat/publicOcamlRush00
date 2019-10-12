type row = ( char * char * char)
type map = ( row * row * row )
type map_row = ( map * map * map )
type board = ( map_row * map_row * map_row )

let print_row row =
	let (a, b, c) = row in
	print_char a; print_char ' ';
	print_char b; print_char ' ';
	print_char c

let rec print_map_row map_row y =
	let (map_a, map_b, map_c) = map_row in
	if y = 3 then
		begin
		let (a, _, _) = map_a in
		let (b, _, _) = map_b in
		let (c, _, _) = map_c in
		print_row a;
		print_string " | ";
		print_row b;
		print_string " | ";
		print_row c;
		print_char '\n';
		print_map_row map_row (y - 1)
		end
	else if y = 2 then
		begin
		let (_, a, _) = map_a in
		let (_, b, _) = map_b in
		let (_, c, _) = map_c in
		print_row a;
		print_string " | ";
		print_row b;
		print_string " | ";
		print_row c;
		print_char '\n';
		print_map_row map_row (y - 1)
		end
	else if y = 1 then
		begin
		let (_, _, a) = map_a in
		let (_, _, b) = map_b in
		let (_, _, c) = map_c in
		print_row a;
		print_string " | ";
		print_row b;
		print_string " | ";
		print_row c;
		print_char '\n';
		print_map_row map_row (y - 1)
		end
	else
		()

let () =
	let new_row = ( '-', '-', '-' ) in
	let new_map = (new_row, new_row, new_row) in
	let map1 = new_map in
	let map2 = new_map in
	let map3 = new_map in
	let map4 = new_map in
	let map5 = new_map in
	let map6 = new_map in
	let map7 = new_map in
	let map8 = new_map in
	let map9 = new_map in

	let map_row_1 = (map1, map2, map3) in
	let map_row_2 = (map4, map5, map6) in
	let map_row_3 = (map7, map8, map9) in

	print_map_row map_row_1 3;
	print_endline "---------------------";
	print_map_row map_row_2 3;
	print_endline "---------------------";
	print_map_row map_row_3 3
