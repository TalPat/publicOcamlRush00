type token = X | O | E
type map = token list
type mapTup
type board = map list

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
