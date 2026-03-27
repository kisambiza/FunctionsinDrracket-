fun contains (xs: int list, x: int)=
  if null xs
    then false
  else
    if hd xs = x
    then true
  else contains(tl xs, x)

fun is_older (date1: int * int * int, date2: int * int * int) =
  if #1 date1 <> #1 date2 
    then #1 date1 < #1 date2
  else if #2 date1 <> #2 date2  
    then #2 date1 < #2 date2
  else #3 date1 < #3 date2

(*****************************************************************************) 

fun number_in_month (dates: (int * int * int) list, month: int) =
  if null dates
  then 0
  else 
    if #2 (hd dates) = month
    then 1 + number_in_month(tl dates, month)
    else
      number_in_month(tl dates, month)

(*****************************************************************************)

fun number_in_months (dates: (int * int * int) list, months: int list) =
  if null dates
  then 0
  else
    let fun contains (xs: int list, x: int)=
    if null xs
      then false
    else
      if hd xs = x
      then true
    else contains(tl xs, x)
    in

    if contains(months, #2 (hd dates))
    then 1 + number_in_months(tl dates, months)
    else
      number_in_months(tl dates, months)
    end

(*****************************************************************************)

fun dates_in_month(dates: (int * int * int) list, month: int) =
  if null dates
    then []
  else 
    if #2 (hd dates) = month
    then hd dates :: dates_in_month(tl dates, month)
    else dates_in_month(tl dates, month)

(*****************************************************************************)

fun dates_in_months (dates: (int * int * int) list, months: int list) = 
  if null months
  then []
  else 
    dates_in_month(dates, (hd months)) @ dates_in_months(dates, tl months)
    
(*****************************************************************************)

fun get_nth (strings: string list, n: int) =
  if n = 1 
  then hd strings
  else 
    get_nth(tl strings, n - 1)
  
(*****************************************************************************)

fun date_to_string (date: (int * int * int)) =
  let 
    val months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    val (year, month, day) = date
  in
    get_nth(months, month) ^ " " ^ Int.toString(day)^ ", " ^ Int.toString(year)
  end

(*****************************************************************************)

fun number_before_reaching_sum (sum: int, ns: int list) =
  if null ns
  then 1
  else 
    let
      fun helper (remaing_list: int list, total: int, count: int) =
          if total + hd remaing_list >= sum
          then count
          else helper(tl remaing_list, total + hd remaing_list, count + 1)
    in
      helper(ns, 0, 0)
    end

(*****************************************************************************)

fun what_month (day: int) =
  let 
    val days_of_months = [31,28,31,30,31,30,31,31,30,31,30,31]
  in
    if day <= hd days_of_months
    then 1
    else
      number_before_reaching_sum(day - hd days_of_months, tl days_of_months) + 2
  end
val test = what_month(90)
(*****************************************************************************)

fun month_range (day1: int, day2: int) =
  if day1 > day2
  then []
  else
    what_month(day1) :: month_range(day1 + 1, day2)

(*****************************************************************************)

fun oldest (dates: (int * int * int) list) =
  if null dates
  then NONE 
  else if null (tl dates)
  then SOME (hd dates)  
  else 
    let 
      val oldest_date = if is_older(hd dates, hd (tl dates)) then hd dates else
        hd (tl dates)
    in 
      oldest(oldest_date :: tl(tl dates))
    end

(*****************************************************************************)
