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
