type token = X | O | E
type map = token list
type board = map list
type tttIA = (token * int)

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
		| [] -> -1
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
		| [] -> -1
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

let findTarget l tok =
	if (willWin l tok) >= 0
	then (willWin l tok)
	else if (preventWin l tok) >= 0
	then (preventWin l tok)
	else if (setupWin l tok) >= 0(* find position that lies in 2 winConditions each with on tok and one E *)
	else anyPlace l tok(* place in first available position *)


let placeToken (IA : tttIA) b =
	let targetMap = findTarget (List.nth b 9) get_1_2 IA in