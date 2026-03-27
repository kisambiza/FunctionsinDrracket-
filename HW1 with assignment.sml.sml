
(*programing assignment 1: SML programming language By Setabi Isaac a student of Kampala International University class of 2006*)

(*the contract: is_older takes two dates and evaluates to true or false *) 
fun is_older (d1 : int*int*int, d2 : int*int*int) =
    (#1 d1*365)+(#2 d1*30) + #3 d1 < (#1 d2*365)+(#2 d2*30) + #3 d2;

(*contract: number_in_month takes a list of dates and a month and returns how many dates in the list are in the month*)
fun number_in_month(dates: (int*int*int)list, month:int)=
    if null(dates) (*base case*)
    then 0
    else if #2(hd dates) = month
    then 1 + number_in_month(tl dates, month) (*Recursion*)
    else number_in_month(tl dates, month);

(*contract: number_in_months takes a list of dates and a list of months 
and returns the number of dates in the list of dates that are in any of the months in the list of months*)
fun number_in_months (date: (int*int*int)list, months: int list)=
    if null (months) (*base case*)
    then 0
    else number_in_month(date, hd months) + number_in_months(date, tl months) (*recursion*);

(*dates_in_month takes a list of dates and a month and returns a
list holding the dates from the argument list of dates that are in the month*)
fun dates_in_month (date:(int*int*int)list,month:int)=
    if null(date) (*base case*)
    then []
    else if #2(hd date)=month
    then hd date :: dates_in_month(tl date, month) (*recursion*)
    else dates_in_month(tl date, month);

(*contract: dates_in_months takes a list of dates and a list of months and returns a list holding the dates from the argument list of dates that are in any of the months in the list of months*)
fun dates_in_months (dates:(int*int*int)list, months: int list)=
    if null (months) (*base case*)
    then []
    (*recursion and using @ operator to append lists*)
    else dates_in_month(dates, hd months) @ dates_in_months(dates, tl months);

(* get_nth takes a list of strings and an int n. and returns the nth element of the list where the head of the list is 1st. condithion If the list has too few elements, your function should apply hd to the empty list*)
fun get_nth (str: string list, n: int)=
    if n =1 (*base case*)
    then hd str
    else get_nth(tl str, n-1) (*recursion*);

(*contract: date_to_string that takes a date and returns a string of the form February 2, 2008 (for example). Use the operator ^ for concatenating strings and the library function Int.toString for converting an int to a string. For producing the month part, do not use a bunch of conditionals.Instead, use a list holding 12 strings and your answer to the previous problem*)
fun date_to_string (date:(int*int*int))=
    let val months =   ["January","February","March","April","May","June","July","August","September","October","November","December"]
  (*recursion and using ^ operator for concatenating strings, Int.toString library function to convert int to strings*)
in get_nth(months, #2 date)^""^Int.toString(#3 date)^","^Int.toString(#1 date)
end;

(*contract: number_before_reaching_sum takes an int (which you can assume is non-negative) and an int list and returns an int. It returns n if sum is greater than or equal to the sum of the first n elements of the list, but not greater than or equal to the sum of the first n + 1 elements. If sum is greater than the sum of all numbers in the list, your function should apply hd to the empty*)
fun number_before_reaching_sum (sum: int, numbers:int list)=
    let fun search_list(i:int, list_sum:int, values:int list)=
        if list_sum + hd values >= sum
        then i
        else search_list(i+1, list_sum + hd values, tl values)
    in search_list(0,0, numbers)
end;

(*contract: what_month takes a day of year (i.e., a number between 1 and 365) and returns what month that day is in (1 for January, 2 for February, etc.).*)
fun what_month (day: int)=
  let val days_in_months = [31,29,31,30,31,30,31,31,30,31,30,31]
  in number_before_reaching_sum(day, days_in_months) + 1
end;

(*contract: month_range takes two days of the year day1 and day2 and returns an int list [m1,m2,...,mn] where m1 is the month of day1, m2 is the month of day1+1, ..., and mn is the month of day day2. Note the result will have length day2 - day1 + 1 or length 0 if day1>day2.*)
fun month_range (day1: int, day2:int)=
    if day1 > day2
    then []
    else (what_month(day1))::month_range(day1 + 1, day2);

(*contract: oldest takes a list of dates and evaluates to an (int*int*int) option. It evaluates to NONE if the list has no dates and SOME d if the date d is in the list and is older than all other dates in the list*)
fun oldest (date: (int*int*int)list)=
    if null (date)
    then NONE
    else let fun older_date(date:(int*int*int)list)=
        if null(tl date)
        then hd date
        else let val result=older_date(tl date)
  in if is_older(hd date, result)
    then hd date
    else result
  end;
in SOME (older_date(date))
end;  

