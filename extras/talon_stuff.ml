type token = X | O | E
type map = token list
type board = map list

let replace l pos a =
	List.mapi (fun i x -> if i = pos then a else x) l

let checkMap m = 
	let winCon = [
		(0, 1, 2);
		(3, 4, 5);
		(6, 7, 8);
		(0, 3, 6);
		(1, 4, 7);
		(2, 5, 8);
		(0, 4, 8);
		(2, 4, 6);
	] in
	let rec aux m = function
		| [] -> E
		| [(a, b, c)] ->
			if List.nth m a == List.nth m b && List.nth m c == List.nth m b && List.nth m a != E
			then List.nth m a
			else E
		| (a, b, c)::e ->
			if List.nth m a == List.nth m b && List.nth m c == List.nth m b && List.nth m a != E
			then List.nth m a
			else aux m e
	in
	aux m winCon

let checkBoard b =
	let rec aux b = function
		| 9 ->
			print_string "";
			b
		| _ as i ->
			if checkMap (List.nth b i) != E && List.nth (List.nth b 9) i == E
			then begin (* print "x wins grid 4!" and modify gamestate*)
				match checkMap (List.nth b i) with
					| X ->
						print_endline ("X wins grid " ^ (string_of_int i));
						replace b 9 (replace (List.nth b 9) i X)
					| O ->
						print_endline ("O wins grid " ^ (string_of_int i));
						replace b 9 (replace (List.nth b 9) i O)
			end
			else aux b (i+1)
	in
	aux b 0

let () =
	match checkBoard ([
[X;X;X; E;E;E; E;E;E];
[E;E;E; E;E;E; E;E;E];
[E;E;E; E;E;E; E;E;E];
[E;E;E; E;E;E; E;E;E];
[E;E;E; E;E;E; E;E;E];
[E;E;E; E;E;E; E;E;E];
[E;E;E; E;E;E; E;E;E];
[E;E;E; E;E;E; E;E;E];
[E;E;E; E;E;E; E;E;E];
[E;E;E; E;E;E; E;E;E];
]) with | _ -> ()
		
(* test list:
[
[E;E;E; E;E;E; E;E;E];
[E;E;E; E;E;E; E;E;E];
[E;E;E; E;E;E; E;E;E];
[E;E;E; E;E;E; E;E;E];
[E;E;E; E;E;E; E;E;E];
[E;E;E; E;E;E; E;E;E];
[E;E;E; E;E;E; E;E;E];
[E;E;E; E;E;E; E;E;E];
[E;E;E; E;E;E; E;E;E];
[E;E;E; E;E;E; E;E;E];
] 
*)