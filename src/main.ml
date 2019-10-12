(* let () =
	let new_map = [E; E; E; E; E; E; E; E; E] in
	let different_map = [E; X; E; E; O; E; E; E; E] in
	let board = [new_map; new_map; new_map; new_map; different_map; new_map; new_map; new_map; new_map] in
	print_board board; *)

(* let () =
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
]) with | _ -> () *)

open InputParser
open TalonStuff
(* open XenoStuff *)
open TicTac

let place_map token pos map =
		match token with
		| X -> List.mapi (fun i x -> if i = (pos-1) then X else x) map
		| O -> List.mapi (fun i x -> if i = (pos-1) then O else x) map

let place_board board token (x, y) =
	List.mapi (fun i a -> if i = (x - 1) then place_map token y a else a) board

let rec main board pl =
	print_board board;
	let input = get_input () in

	let new_board = place_board board pl input in
	let new_board1 = checkBoard new_board in
	main new_board1 pl

let () =
	let new_map = [E; E; E; E; E; E; E; E; E] in
	let different_map = [E; X; E; E; O; E; E; E; E] in
	let board = [new_map; new_map; new_map; new_map; different_map; new_map; new_map; new_map; new_map; new_map] in

	main board X;
	()
