
let get_player_names () = 
    print_string ("|-----Enter Player One's Name-----|\n             ");
    let pl_one_name = read_line() in
    print_string ("|-----Enter Player Two's Name-----|\n             ");
    let pl_two_name = read_line() in
    (pl_one_name, pl_two_name)

let new_menu () =
  print_string "|-----------Main Menu------------|\n Select an option:\n  1)  Player vs Player (PP)\n  2)  Player vs IA     (IA)\n            " ;
  let rec loop input =
    if (input = "PP" ) then
      get_player_names ()
    else if (input = "IA") then
      ("IA", "Player")
    else
      begin
      print_string ("Please type either (PP) or (IA)\n            ");
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