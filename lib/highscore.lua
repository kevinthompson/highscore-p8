-- highscore
-- by @kevinthompson

_hs_chars="abcdefghijklmnopqrstuvwxyz "
_hs_max_records=10
_hs_bytesize=5
_hs_records={}
_hs_last_index=0

function _hs_char_index(char)
  for i=1,#_hs_chars do
    if sub(_hs_chars,i,i)==char then
      return i
    end
  end

  return 1
end

function _hs_save()
  for i=0,#_hs_records-1 do
    if _hs_records[i+1] then
      local addr=_hs_memory_addr+_hs_bytesize*i
      for n=1,3 do
        poke(addr+n-1,_hs_char_index(sub(_hs_records[i+1].name,n,n)))
      end
      poke2(addr+3,_hs_records[i+1].score)
    end
  end

  _hs_update_table()
end

function _hs_reset()
  memset(_hs_memory_addr,0,_hs_max_records*_hs_bytesize)
  _hs_load()
end

function _hs_load()
  _hs_records={}

  for i=0,_hs_max_records-1 do
    local name=""
    local addr=_hs_memory_addr+_hs_bytesize*i
    for n=0,2 do
      local v=peek(addr+n) or 1
      name=name..sub(_hs_chars,v,v)
    end
    _hs_records[i+1]={name=name,score=peek2(addr+3)}
  end

  _hs_update_table()
end

function _hs_index(score)
  for i=1,#_hs_records do
    if score>tonum(_hs_records[i].score) then
      return i
    end
  end

  if #_hs_records < _hs_max_records then
    return #_hs_records+1
  end
end

function _hs_init(memory_addr)
  _hs_memory_addr=memory_addr or 0x5e00
  _hs_load()
end

function _hs_add(name, score)
  local index=_hs_index(score)

  if index then
    _hs_last_index=index

    for i=_hs_max_records,index+1,-1 do
      _hs_records[i]=_hs_records[i-1]
    end

    _hs_records[index]={name=name,score=score}
    _hs_save()
  end
end

function _hs_update_table()
  highscore.last_index=_hs_last_index
  highscore.records=_hs_records
end

highscore={
  index=_hs_index,
  init=_hs_init,
  reset=_hs_reset,
  add=_hs_add
}

_hs_update_table()
