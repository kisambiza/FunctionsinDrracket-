fun is_older((tr1: int*int*int), (tr2: int*int*int)) =
    if (#1 tr1) < (#1 tr2)
    then true
    else if (#1 tr1) > (#1 tr2)
    then false
    else if (#2 tr1) < (#2 tr2)
    then true
    else if (#2 tr1) > (#2 tr2)
    then false
    else if (#3 tr1) < (#3 tr2)
    then true
    else false

fun number_in_month ((ts:(int*int*int) list), (m: int)) = 
    if null ts
    then 0
    else (if (#2 (hd ts)) = m
    then 1
    else 0) + number_in_month((tl ts), m)

fun number_in_months((ts:(int*int*int) list), (ms: int list)) = 
    if null ts
    then 0
    else if null ms
    then 0
    else number_in_month(ts, (hd ms)) + number_in_months(ts, (tl ms))

fun dates_in_month((ts:(int*int*int) list), (m: int)) = 
    if null ts
    then []
    else if (#2 (hd ts)) = m
    then (hd ts)::dates_in_month(tl ts, m)
    else dates_in_month(tl ts, m)

fun dates_in_months((ts:(int*int*int) list), (ms: int list)) = 
    if null ts
    then []
    else if null ms
    then []
    else dates_in_month(ts, (hd ms)) @ dates_in_months(ts, (tl ms))

fun get_nth ((xs: string list), (n: int)) = 
    if null xs
    then ""
    else if  n <> 1
    then get_nth(tl xs, n - 1)
    else hd xs  

fun date_to_string (tr: (int*int*int)) = 
    let
        val ms = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
        fun get_month(ms, n) = 
            if n = 1
            then hd ms
            else get_month(tl ms, n - 1)
        val month = get_month(ms, (#2 tr))
        in
            month ^ " " ^ Int.toString (#3 tr) ^ ", " ^ Int.toString (#1 tr)
        end

fun number_before_reaching_sum (sum: int, ls: int list) = 
    let
        fun add(total, n, tail) = 
            if total + (hd tail) >= sum
            then n
            else add(total + (hd tail), n + 1, tl tail)
    in
        add(0, 0, ls)
    end

fun what_month (doy: int) = 
    let
        val days = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    in
        number_before_reaching_sum(doy, days) + 1
    end

fun month_range (day1: int, day2: int) = 
    if day2 < day1
    then []
    else what_month(day1)::month_range(day1 + 1, day2)

fun oldest (ds: (int*int*int) list) = 
    if null ds
    then NONE
    else
        let
            fun compare_dates(head, tail) = 
                if null tail
                then SOME head
                else if is_older(hd tail, head)
                then compare_dates(hd tail, tl tail)
                else compare_dates(head, tl tail)
        in
            compare_dates(hd ds, tl ds)
        end

fun check_membership(x: int, ls: int list) = 
    if null ls
    then false
    else if x = hd ls
    then true
    else check_membership(x, tl ls)

fun remove_duplicate (ls: int list) = 
    if null ls
    then []
    else
        let
            val rd = remove_duplicate(tl ls)
        in
            if check_membership(hd ls, tl ls)
            then rd
            else (hd ls)::rd
        end

fun number_in_months_challenge((ts:(int*int*int) list), (ms: int list)) = 
    let
        val unique_ms = remove_duplicate(ms)
    in
        if null ts
        then 0
        else if null unique_ms
        then 0
        else number_in_month(ts, (hd unique_ms)) + number_in_months_challenge(ts, (tl unique_ms))
    end

fun dates_in_months_challenge((ts:(int*int*int) list), (ms: int list)) = 
    let
        val unique_ms = remove_duplicate(ms)
    in
        if null ts
        then []
        else if null unique_ms
        then []
        else dates_in_month(ts, (hd unique_ms)) @ dates_in_months_challenge(ts, (tl unique_ms))
    end

fun reasonable_date (date : int * int * int) =
    let
        val year = #1 date
        val month = #2 date
        val day = #3 date
        fun is_leap (year)= 
            if year mod 400 = 0 orelse (year mod 4 = 0 andalso year mod 100 <> 0)
            then true
            else false
        val feb: int = 
            if is_leap(year) = true
            then 29
            else 28
        fun get_days (xs, n) = 
            if  n <> 1
            then get_days(tl xs, n - 1)
            else hd xs
        val reasonable_month = [31, feb, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    in
        year > 0 andalso (month > 0 andalso month < 13) andalso (day > 0 andalso day <= get_days(reasonable_month, month))
    end