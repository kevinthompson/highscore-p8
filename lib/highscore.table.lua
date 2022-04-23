function _hs_printc(string,y,c)
	? string,64-((#string/2)*4),y,c or 7
end

function _hs_pad(string,length,char)
	string=tostr(string)
	char=char or "0"
  if (#string==length) return string
  return char.._hs_pad(string,length-1,char)
end

function _hs_table_draw(x,y)
  y=y or 16
	for i=1,#_hs_records do
		local y=16+i*8
		local record=_hs_records[i]
    local padded_score=_hs_pad(record.score,20,".")
    local text=record.name..padded_score
		if (x) print(text,x,y) else _hs_printc(text,y)

		if _hs_last_index>0 and _hs_last_index==i then
	    local x=x or 64-((#text/2)*4)
			? "★",x-10,y,7
		end
	end
end

highscore.table={
  draw=_hs_table_draw
}
