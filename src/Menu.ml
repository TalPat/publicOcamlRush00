
let get_player_names () = 
    let rec loop new_name =
      if (String.trim new_name) = "" then
      loop (read_line ())
      else new_name in
    print_string ("|-----Enter Player One's Name-----|\n            ");
    let pl_one_name = loop (read_line ()) in
  
    print_string ("|-----Enter Player Two's Name-----|\n            ");
    let rec pl_two_name new_name pl1_name = 
      if new_name  = pl1_name then
        pl_two_name (loop (read_line ())) pl1_name
      else
        new_name
    in
  
    (pl_one_name, pl_two_name (read_line ()) pl_one_name)

let new_menu () =
  print_string "|-----------Main Menu------------|\n Select an option:\n  1)  Player vs Player (PP)\n  2)  Player vs IA     (IA)\n  2)  IA vs IA         (IAAI)\n           " ;
  let rec loop input =
    if (input = "PP" ) then
      get_player_names ()
    else if (input = "IA") then
      ("IA", "Player")
    else if (input = "IAAI") then
      ("IA1", "IA2")
    else
      begin
      print_string ("Please type either (PP) or (IA) or (IAAI)\n            ");
      loop (read_line())
      end in
  loop (read_line())

  let yesNo () =
    print_string "|----------Play Another-----------|\n Select an option:\n  1)  Yes (Y)\n  1)  No (N)\n            " ;
    let rec loop input =
      if (input = "Y" || input = "N" ) then
        input
      else
        begin
        print_string ("Please type either (Y) or (N)\n            ");
        loop (read_line())
        end in
    loop (read_line())