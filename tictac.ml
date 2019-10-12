let rec print_map lst width height =
	let rec print_row lst_ w =
		if w = 0 then
			begin
				print_char '\n';
				lst_
			end
		else
			match lst_ with
			| [] -> lst_
			| head::tail ->
				print_char head;
				print_row tail (w - 1)
	in
	if height > 0 then
		let new_list = print_row lst width in
		print_map new_list width (height - 1)
	else
		()

let () =
	(* let map = ['-'; '-'; '-'; '-'; '-'; '-'; '-'; '-'; '-';] in
	print_map map 3 3 *)
	let input = read_line () in
	print_endline input
