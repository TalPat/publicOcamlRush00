type token = X | O | E
type map = token list
type board = map list

let replace l pos a =
	List.mapi (fun i x -> if i = pos then a else x) l

let replace_all token map =
	List.map (fun x -> token ) map

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
						let b = replace b 9 (replace (List.nth b 9) i X) in
						replace b i (replace_all X (List.nth b i))
					| O ->
						print_endline ("O wins grid " ^ (string_of_int i));
						let b = replace b 9 (replace (List.nth b 9) i O) in
						replace b i (replace_all O (List.nth b i))
			end
			else aux b (i+1)
	in
	aux b 0

(* ai Stuff *)

let get_1_2 (a,_) = a
let get_2_2 (_,a) = a

let willWin l tok =
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
	let rec aux tok = function
		| [] -> (-1)
		| (a, b, c)::e ->
			if (List.nth l a = tok && List.nth l b = tok && List.nth l c = E)
			then c
			else if	(List.nth l a = tok && List.nth l b = E && List.nth l c = tok)
			then b
			else if (List.nth l a = E && List.nth l b = tok && List.nth l c = tok)
			then a
			else aux tok e
	in
	aux tok winCon

let preventWin l tok =
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
	let enemy = match tok with
		| X -> O
		| _ -> X
	in
	let rec aux tok = function
		| [] -> (-1)
		| (a, b, c)::e ->
			if (List.nth l a = enemy && List.nth l b = enemy && List.nth l c = E)
			then c
			else if	(List.nth l a = enemy && List.nth l b = E && List.nth l c = enemy)
			then b
			else if (List.nth l a = E && List.nth l b = enemy && List.nth l c = enemy)
			then a
			else aux tok e
	in
	aux tok winCon

let setupWin l tok =
	if  List.nth l 0 = E && (
		(List.nth l 2 = tok && List.nth l 6 = tok && List.nth l 1 = E && List.nth l 3 = E) ||
		(List.nth l 2 = tok && List.nth l 8 = tok && List.nth l 1 = E && List.nth l 4 = E) ||
		(List.nth l 6 = tok && List.nth l 8 = tok && List.nth l 3 = E && List.nth l 4 = E))
	then 0
	else if  List.nth l 8 = E && (
		(List.nth l 2 = tok && List.nth l 6 = tok && List.nth l 5 = E && List.nth l 7 = E) ||
		(List.nth l 2 = tok && List.nth l 0 = tok && List.nth l 5 = E && List.nth l 4 = E) ||
		(List.nth l 6 = tok && List.nth l 0 = tok && List.nth l 7 = E && List.nth l 4 = E))
	then 8
	else if  List.nth l 2 = E && (
	(List.nth l 0 = tok && List.nth l 8 = tok && List.nth l 1 = E && List.nth l 5 = E) ||
	(List.nth l 0 = tok && List.nth l 6 = tok && List.nth l 1 = E && List.nth l 4 = E) ||
	(List.nth l 8 = tok && List.nth l 6 = tok && List.nth l 5 = E && List.nth l 4 = E))
	then 2
	else if  List.nth l 6 = E && (
		(List.nth l 0 = tok && List.nth l 8 = tok && List.nth l 3 = E && List.nth l 7 = E) ||
		(List.nth l 0 = tok && List.nth l 2 = tok && List.nth l 3 = E && List.nth l 4 = E) ||
		(List.nth l 8 = tok && List.nth l 2 = tok && List.nth l 7 = E && List.nth l 4 = E))
	then 6
	else (-1)

let anyPlace l tok =
	let rec aux = function
		| n -> if (List.nth l n = E)
			then n
			else aux (n+1)
		| 9 -> 9
	in
	if List.nth l 0 = E
	then 0
	else if List.nth l 2 = E
	then 2
	else if List.nth l 6 = E
	then 6
	else if List.nth l 8 = E
	then 8
	else aux 1

let findTarget l tok =
	if (willWin l tok) >= 0
	then (willWin l tok)
	else if (preventWin l tok) >= 0
	then (preventWin l tok)
	else if (setupWin l tok) >= 0(* find position that lies in 2 winConditions each with on tok and one E *)
	then (setupWin l tok)
	else anyPlace l tok(* place in first available position *)


let placeToken ia b =
	let targetMap = findTarget (List.nth b 9) (get_1_2 ia) in
	let targetPoint = findTarget (List.nth b targetMap) (get_1_2 ia) in
	print_endline (string_of_int (targetMap+1) ^ " " ^ string_of_int (targetPoint+1));
	(targetMap+1, targetPoint+1)
