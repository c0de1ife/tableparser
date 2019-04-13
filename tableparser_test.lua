local parser = require "tableparser"

local sourceTable = { 1, b = { "\r\n\t", { a = 3, c = "abc" }, { true, false, true, true } }, 3, ["\r\n\t"] = 5.0, ["1"] = 5.0, [true] = 12.50 }
print("sourceTable:")
parser.dump(sourceTable)
local targetString = parser.encode(sourceTable)
print("\ntargetString:")
parser.dump(targetString)
local restoreTable = parser.decode(targetString)
print("\nrestoreTable:")
parser.dump(restoreTable)

print("\nwithout strict mode:")
parser.useStrict(false)
local sourceTable = { a = 1, b = true, c = 12.0, d = { 1, 2, true, false }, e = "\t\r\n" }
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
    [1]=1
    [2]=3
    [true]=12.5
    ["1"]=5.0
    ["b"]={
        [1]="
	"
        [2]={
            ["c"]="abc"
            ["a"]=3
        }
        [3]={
            [1]=true
            [2]=false
            [3]=true
            [4]=true
        }
    }
    ["
	"]=5.0
}

targetString:
{[1]=1,[2]=3,[true]=12.5,["1"]=5.0,["b"]={"\r\n	",{["c"]="abc",["a"]=3},{true,false,true,true}},["\r\n	"]=5.0}

restoreTable:
{
    [1]=1
    [2]=3
    [true]=12.5
    ["1"]=5.0
    ["b"]={
        [1]="
	"
        [2]={
            ["a"]=3
            ["c"]="abc"
        }
        [3]={
            [1]=true
            [2]=false
            [3]=true
            [4]=true
        }
    }
    ["
	"]=5.0
}

without strict mode:
sourceTable:
{
    ["e"]="	
"
    ["c"]=12.0
    ["d"]={
        [1]=1
        [2]=2
        [3]=true
        [4]=false
    }
    ["a"]=1
    ["b"]=true
}

targetString:
{e="	\r\n",c=12.0,d={1,2,true,false},a=1,b=true}

restoreTable:
{
    ["e"]="	
"
    ["c"]=12.0
    ["d"]={
        [1]=1
        [2]=2
        [3]=true
        [4]=false
    }
    ["a"]=1
    ["b"]=true
}
]]
