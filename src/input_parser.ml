
let is_int s = (*Is it a int? Is it not an int? This function finds out so you dont have to*)
	try ignore (int_of_string s); true
	with _ -> false

let rec get_nth l n = (*Gets nth element from list*)
	match l with
	| [] -> "-1"
	| h::t -> if n = 0 then h else get_nth t (n-1)

let get_nth_int l n = (*Gets nth element from list and convetys to int*)
	let element = get_nth l n in
	if (is_int element) then
		int_of_string element
	else
		-1

let split_str input = (*Splits string and gets int values from elemnts*)
	let str_list = String.split_on_char ' ' input in
	let m_num = get_nth_int str_list 0 in
	let p_num = get_nth_int str_list 1 in
	(m_num, p_num)

let get_input = (*Returns a tuple of 2 integers of the input*)
	let input = read_line() in
	let rec loop (m_num, p_num)=
		if (m_num < 0 || m_num > 9 || p_num < 0 || p_num > 9) then
			begin
				print_string ("Input is incorrect: Please enter 2 integers\n");
				loop (split_str (read_line()))
			end
		else
			(m_num, p_num) in
	loop (split_str input)