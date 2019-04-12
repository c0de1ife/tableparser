local load = _VERSION > "Lua 5.1" and load or loadstring

local parser = {}
function parser.dump(t)
    if type(t) ~= "table" then
        print(t)
        return
    end
    local s = "{\n"
    local function p(px, t)
        for k, v in pairs(t) do
            k = tostring(k)
            if type(v) ~= "table" then
                s = s .. px .. k .. "=" .. tostring(v) .. "\n"
            else
                s = s .. px .. k .. "={\n"
                p(px .. "  ", v)
                s = s .. px .. "}\n"
            end
        end
    end
    p("  ", t)
    print(s .. "}")
end

function parser.decode(str)
    local f = load("return " .. str)
    return f and f()
end

local function parseKey(k)
    local tp = type(k)
    if tp == "boolean" then
        return "[" .. (k and "true" or "false") .. "]"
    elseif tp == "number" then
        return "[" .. k .. "]"
    elseif tp == "string" then
        return k
    else
        error("encode err: not support key type: " .. tp)
    end
end

function parser.encode(obj)
    local tp = type(obj)
    if tp == "boolean" then
        return obj and "true" or "false"
    elseif tp == "number" then
        return obj
    elseif tp == "string" then
        return '"' .. obj .. '"'
    elseif tp == "table" then
        local vTable = {}
        local kvTable = {}
        local length = 0
        for k, v in pairs(obj) do
            length = length + 1
            local vStr = parser.encode(v)
            vTable[#vTable + 1] = vStr
            kvTable[#kvTable + 1] = parseKey(k) .. "=" .. vStr
        end
        if length == #obj then
            return "{" .. table.concat(vTable, ",") .. "}"
        else
            return "{" .. table.concat(kvTable, ",") .. "}"
        end
    else
        error("decode err: not support value type: " .. tp)
    end
end

return parser
