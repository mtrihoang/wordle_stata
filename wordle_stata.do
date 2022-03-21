clear all
set mem 10m
set more off
macro drop _all

cd 

global position = 0
global n = 0

forval i = 1/30 {
global letter`i' = "_"
global color`i' = "green"
}

program define how_to_play
di "Guess the valid {green:five-letter} word in {green:six} tries"
di "{red:red}" " : not in the word | " "{yellow:yellow}" " : in the word but wrong spot | " "{green:green}" " : in the word and correct spot"
end

program define word_table
forval j = 1/6 {
forval i = 1/5 {
local p`i' = `i' + 5*`j' - 5 
}
di "`j': [{${color`p1'}:${letter`p1'}}][{${color`p2'}:${letter`p2'}}][{${color`p3'}:${letter`p3'}}][{${color`p4'}:${letter`p4'}}][{${color`p5'}:${letter`p5'}}]" 
}
end

program define import_data
import delimited "https://www-cs-faculty.stanford.edu/~knuth/sgb-words.txt", clear
replace v1 = strupper(v1)
end

program define new_game
qui count
global n = runiformint(1, `r(N)')
global key_word = v1[$n]
local split_key_word = subinstr(ustrregexra("$key_word","(.)","$1,"), ",", " ", .)
forval j = 1/5 {
local l : word `j' of `split_key_word'
global l`j' = "`l'"
}
end

program define wordle_stata

if $n == 0 {
new_game
}

args my_word

if strlen("`my_word'") != 5 {
di as err "error 911: the number of characters should be equal to 5"
exit 911
}

local upper_word = strupper("`my_word'")
local split_upper_word = subinstr(ustrregexra("`upper_word'","(.)","$1,"), ",", " ", .)

forval j = 1/5 {
global position = $position + 1
global position_p = $position

while $position_p > 5 {
global position_p = $position_p - 5
}

local letter : word $position_p of `split_upper_word'
global letter$position = "`letter'"

if strpos("$key_word", "${letter$position}") > 0 {
if strpos("${l$position_p}", "${letter$position}") > 0 {
global color$position = "green"
}
else {
global color$position = "yellow"
}
}
else {
global color$position = "red"
}
}

if mod($position, 5) == 0 {
how_to_play
word_table
if strpos("$key_word", "`upper_word'") > 0 {
di "CONGRATULATIONS!"
di "{green:<run do-file again to restart game>}"
di "run the command: " "{green:do wordle_stata.do}"
clear
}
}

if $position == 30 & strpos("$key_word", "`upper_word'") == 0 {
di "{red:GAME OVER!}"
di "The key word is: " "{green:$key_word}"
di "{green:<run do-file again to restart game>}"
di "run the command: " "{green:do wordle_stata.do}"
}

end 

qui import_data
