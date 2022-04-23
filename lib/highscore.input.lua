_hs_name="aaa"
_hs_name_index=1
_hs_name_table={1,1,1}

function _hs_input_update()
  if (btnp(0)) _hs_name_index=mid(1,_hs_name_index-1,3)
  if (btnp(1)) _hs_name_index=mid(1,_hs_name_index+1,3)

  if btnp(2) then
    if _hs_name_table[_hs_name_index]==1 then
      _hs_name_table[_hs_name_index]=#_hs_chars
    else
      _hs_name_table[_hs_name_index]-=1
    end
  end

  if btnp(3) then
    if _hs_name_table[_hs_name_index]==#_hs_chars then
      _hs_name_table[_hs_name_index]=1
    else
      _hs_name_table[_hs_name_index]+=1
    end
  end

  _hs_name=""
  for i in all(_hs_name_table) do
    _hs_name=_hs_name..sub(_hs_chars,i,i)
  end

  highscore.input.name=_hs_name
  highscore.input.index=_hs_name_index
end

function _hs_input_draw(x,y)
  x=x or 58
  y=y or 60
  ? _hs_name,x,y,7
  ? "_",x+4*(_hs_name_index-1),y+2,7
end

highscore.input={
  name=_hs_name,
  index=_hs_name_index,
  update=_hs_input_update,
  draw=_hs_input_draw
}
