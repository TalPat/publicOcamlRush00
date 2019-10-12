let rec print_row map first last count =
	if count < first then
		match map with
		| [] -> ()
		| head::tail -> print_row tail first last (count + 1)
	else if first <= last then
		match map with
		| [] -> ()
		| head::tail ->
			if head = 0 then
				print_char '-'
				else if head = 1 then
					print_char 'X'
				else if head = 2 then
					print_char 'O';
			print_row tail (first + 1) last (count + 1)
	else
		()

let () =
	let map = [0; 0; 0; 0; 0; 0; 0; 0; 0] in
	print_row map 0 2 0;
	print_char '\n'
