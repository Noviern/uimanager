---Serializes a value to a Lua string representation.
---Supports numbers, booleans, strings, and tables (with string/number keys).
---Errors on unsupported types.
---@param o any
---@return string result
---@nodiscard
local function serialize(o)
  if type(o) == "number" or type(o) == "boolean" then
    return tostring(o)
  elseif type(o) == "string" then
    return string.format("%q", o)
  elseif type(o) == "table" then
    local s = "{"
    for k, v in pairs(o) do
      if s ~= "{" then s = s .. "," end
      s = s .. "[" .. serialize(k) .. "]=" .. serialize(v)
    end
    return s .. "}"
  else
    error("cannot serialize type " .. type(o))
  end
end

---Serializes a table to a Lua code string.
---@param list table The table to serialize.
---@return string serialized The Lua code representation.
---@nodiscard
function table.serialize(list)
  return serialize(list)
end

---Saves a table to a file as executable Lua code (`return { ... }`).
---@param filename string The file path to write.
---@param list table The table to save.
---@return boolean success `true` if saved successfully, `false` otherwise.
---@return string|nil error Error message if failed, otherwise `nil`.
---@nodiscard
function table.save(filename, list)
  local file, error = io.open(filename, "w")
  local success = false

  if file then
    success = true

    file:write("return ", table.serialize(list))
    file:close()
  end

  return success, error
end

---Loads a table from a file created by `table.save`.
---The file must contain `return { ... }`.
---@param filename string The file path to load.
---@return table list The loaded table (empty table on error).
---@return string|nil error Error message if failed, otherwise `nil`.
---@nodiscard
function table.load(filename)
  local fn, error = loadfile(filename)
  local list = {}

  if fn then
    local success, result = pcall(fn)

    if not success then
      error = result
    elseif type(result) == "table" then
      list = result
    else
      error = "File did not return a table."
    end
  end

  return list, error
end
