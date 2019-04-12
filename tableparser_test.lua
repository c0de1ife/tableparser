local parser = require "tableparser"

local sourceTable = { 1, b = { 1.0, { a = 3, c = "abc" }, { true, false, true, true } }, 3, [true] = 12.50 }
print("sourceTable:")
parser.dump(sourceTable)
local targetString = parser.encode(sourceTable)
print("\ntargetString:")
parser.dump(targetString)
local restoreTable = parser.decode(targetString)
print("\nrestoreTable:")
parser.dump(restoreTable)

-- results:
--[[
sourceTable:
{
  1=1
  2=3
  b={
    1=1.0
    2={
      c=abc
      a=3
    }
    3={
      1=true
      2=false
      3=true
      4=true
    }
  }
  true=12.5
}

targetString:
{[1]=1,[2]=3,b={1.0,{c="abc",a=3},{true,false,true,true}},[true]=12.5}

restoreTable:
{
  b={
    1=1.0
    2={
      a=3
      c=abc
    }
    3={
      1=true
      2=false
      3=true
      4=true
    }
  }
  1=1
  2=3
  true=12.5
}
]]
