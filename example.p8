pico-8 cartridge // http://www.pico-8.com
version 36
__lua__
-- highscore example
-- by @kevinthompson

-- includes
#include lib/highscore.lua
#include lib/highscore.input.lua
#include lib/highscore.table.lua

-- config
title="⬆️ tap it up"
version=1

-- highscore
cartdata("kt_highscore_"..version)
highscore.init()

menuitem(1, "reset scores", function()
	highscore.reset()
	for i=1,10 do
		highscore.add("cpu",10)
	end
end)

-- game
function _init()
 score=0
 timer=150
 diameter=12
 _update=update_title
 _draw=draw_title
end
-->8
-- title

function update_title()
	if btnp(❎) then
		_update=update_game
		_draw=draw_game
	end
end

function draw_title()
	cls()
	printc(title,24,7)
	line(30,34,98,34,7)
 printc("tap ⬆️ as fast as you",61,7)
 printc("can to earn points!",68,7)
	printc("press ❎ to start",96,6)
end
-->8
-- game

function update_game()
	timer-=1
	diameter=mid(12,diameter-1,16)
	
	if btnp(⬆️) then
		score+=1
		diameter+=2
	end
		
	if timer<=0 then
		if highscore.index(score) then
			_update=update_new_record
			_draw=draw_new_record
		else
			_update=update_game_over
			_draw=draw_game_over
		end
	end
end

function draw_game()
	cls()
	printc(score,58,7)
	circ(63,60,diameter,6)
	
	local record=highscore.records[1]
	if record then
		printc("high score: "..record.score,8,5)
	end
	
	printc("time: "..ceil(timer/30),112,5)
end
-->8
-- new record

function update_new_record()
	highscore.input.update()

	if btnp(❎) then
		highscore.add(highscore.input.name,score)
		_update=update_game_over
		_draw=draw_game_over
	end
end

function draw_new_record()
 cls()
	
	printc("new record!",8,7)
	line(24,18,104,18,7)
	printc("enter your name",44,6)
	printc("score: "..score,76,6)
	printc("press ❎ to submit record",112,6)

	highscore.input.draw()
end
-->8
-- game over

function update_game_over()
	if btnp(❎) then
		_init()
	end
end

function draw_game_over()
 cls()
	printc("game over",8,7)
	line(24,18,104,18,7)
	printc("press ❎ to return to title",112,6)

	highscore.table.draw()
end
-->8
-- utilities

function printc(string,y,c)
	string=tostr(string)
	? string,64-((#string/2)*4),y,c or 7
end
__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
