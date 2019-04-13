local load = _VERSION > "Lua 5.1" and load or loadstring

local parser = {
    strict = true
}

local function quote(s)
    local r = string.gsub(s, '["\\]', '\\%1')
    r = string.gsub(r, '\r', '\\r')
    r = string.gsub(r, '\n', '\\n')
    return r
end

local function parseKey(k)
    local tp = type(k)
    if tp == "boolean" then
        return "[" .. (k and "true" or "false") .. "]"
    elseif tp == "number" then
        return "[" .. k .. "]"
    elseif tp == "string" then
        return parser.strict and '["' .. quote(k) .. '"]' or k
    else
        error("encode err: not support key type: " .. tp)
    end
end

function parser.dump(t)
    if type(t) ~= "table" then
        print(t)
        return
    end
    local s = "{\n"
    local function p(px, t)
        for k, v in pairs(t) do
            k = type(k) == "string" and '["' .. k .. '"]' or "[" .. tostring(k) .. "]"
            local tv = type(v)
            if tv ~= "table" then
                v = tv == "string" and '"' .. v .. '"' or tostring(v)
                s = s .. px .. k .. "=" .. v .. "\n"
            else
                s = s .. px .. k .. "={\n"
                p(px .. "    ", v)
                s = s .. px .. "}\n"
            end
        end
    end
    p("    ", t)
    print(s .. "}")
end

function parser.useStrict(tag)
    parser.strict = tag
end

function parser.decode(str)
    local f = load("return " .. str)
    return f and f()
end

function parser.encode(obj)
    local tp = type(obj)
    if tp == "boolean" then
        return obj and "true" or "false"
    elseif tp == "number" then
        return obj
    elseif tp == "string" then
        return '"' .. quote(obj) .. '"'
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
