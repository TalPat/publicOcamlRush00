type player = X | O

let new_board = [ 0;0;0;0;0;0;0;0;0; ]

let place_move player pos brd =
    match player with
    | X -> List.mapi (fun i x -> if i = (pos-1) then 1 else x) brd
    | O -> List.mapi (fun i x -> if i = (pos-1) then 2 else x) brd

let rec is_pos_open pos brd=
    match brd with
    | [] -> false
    | h::t -> if pos = 1 && h > 0 then false
              else if pos = 1 then true
              else is_pos_open (pos-1) t

let is_int s =
  try ignore (int_of_string s); true
  with _ -> false

let check_input input =
    if (is_int input) = true then
        begin
            print_string ("Your input was: " ^ input ^ "\n");
            true
        end
    else
        begin
            print_string ("Please put in an integer\n");
            false
        end


let print_square i sqr=
    match sqr with
    | 0 -> if (i mod 3) = 0 then print_string("_\n") else print_string("_ ")
    | 1 -> if (i mod 3) = 0 then print_string("O\n") else print_string("O ")
    | 2 -> if (i mod 3) = 0 then print_string("X\n") else print_string("X ")
    | _ -> invalid_arg "Value on board can't be read"

let print_board brd = 
    List.mapi (fun i x -> print_square (i+1) x) brd

let input_caller (brd) =
    let rec loop brd i =
        print_board brd;
        let input = read_line() in
        if (check_input input && (i mod 2) = 0) then
            loop (place_move O (int_of_string input) brd) (i-1)
        else if (check_input input) then
            loop (place_move X (int_of_string input) brd) (i-1)
        else
            loop (brd) (i) in
    loop brd 0

let () = input_caller(new_board)