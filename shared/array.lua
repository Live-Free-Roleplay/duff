---@class CArray
---@field private __actions table
---@field private __type string
---@field new fun(self: any[]?): self|any? Creates a new array.
---@field insert fun(self: CArray, index: integer, value: any): CArray Inserts an element at the specified index.
---@field remove fun(self: CArray, index: integer): any? Removes and returns the element at the specified index.
---@field sort fun(self: CArray, fn: function): CArray Sorts the elements of the array.
---@field concat fun(self: CArray, sep: string): string Concatenates all elements of the array with an optional separator.
---@field isarray fun(tbl: table): boolean? Checks if a table is an array.
---@field push fun(self: CArray, arg: any?, ...: any?): CArray Adds one or more elements to the end of the array.
---@field pusharray fun(self: CArray, tbl: table): CArray Adds all elements from a table to the end of the array.
---@field peek fun(self: CArray, index: integer?): any Returns the element at the specified index without removing it.
---@field peekarray fun(self: CArray, index: integer?): CArray Returns a new array containing the elements from the specified index to the end of the array.
---@field pop fun(self: CArray, index: integer?): any, CArray Removes and returns the element at the specified index.
---@field poparray fun(self: CArray, index: integer?): CArray Removes and returns a new array containing the elements from the specified index to the end of the array.
---@field contains fun(self: CArray, key: integer?, value: any?): boolean? Checks if the array contains a specific element or key or key-value pair.
---@field find fun(self: CArray, fn: function): integer? Searches for the first element that satisfies a given condition and returns its index.
---@field copy fun(self: CArray): CArray Creates a shallow copy of the array.
---@field foldleft fun(self: CArray, fn: function, arg: any?): CArray Applies a function to each element from left to right, accumulating a result.
---@field foldright fun(self: CArray, fn: function, arg: any?): CArray Applies a function to each element from right to left, accumulating a result.
---@field setenum fun(self: CArray?): table Creates a read-only array that can be used for enumeration.
---@field map fun(self: CArray, fn: function, inPlace: boolean?): CArray Applies a function to each element and returns a new array with the results.
---@field filter fun(self: CArray, fn: function, inPlace: boolean?): CArray Returns a new array containing only the elements that satisfy a given condition.
---@field foreach fun(self: CArray, fn: function) Executes a function for each element across the array.
---@field reverse fun(self: CArray, length: integer?): CArray Reverses the order of elements.
local CArray do
  local table = table
  CArray = {__actions = {__index = CArray}, __type = 'array'}
  CArray.insert = table.insert
  CArray.remove = table.remove
  CArray.sort = table.sort
  CArray.concat = table.concat
  local min = math.min
  ---@module 'shared.debug'
  local debug = require 'shared.debug'
  local check_type = debug.checktype

  ---@param tbl table
  ---@param fn function
  ---@param arg_no integer?
  ---@return boolean?, string?
  local function is_table(tbl, fn, arg_no)
    return check_type(tbl, 'table', fn, arg_no)
  end

  ---@param self table
  ---@return CArray
  local function new(self)
    self = self or {}
    if not is_table(self, new, 1) then return self end
    for k, v in pairs(CArray) do self[k] = v end
    setmetatable(self, {__index = CArray.__actions, __type = 'array'})
    return self
  end

  ---@param tbl table
  ---@return boolean?
  local function isArray(tbl)
    if not is_table(tbl, isArray, 1) then return end
    return tbl.__type == 'array'
  end

  ---@param self CArray
  ---@param arg any?
  ---@param ... any?
  ---@return CArray
  local function push(self, arg, ...)
    if not arg then return self end
    self[#self + 1] = arg
    if select('#', ...) > 0 then
      local args = {...}
      for i = 1, #args do self[#self + 1] = args[i] end
    end
    return self
  end

  ---@param self CArray
  ---@param tbl table
  ---@return CArray
  local function pushArray(self, tbl)
    for i = 1, #tbl do self[#self + 1] = tbl[i] end
    return self
  end

  ---@param self CArray
  ---@param index integer?
  ---@return any
  local function peek(self, index)
    index = index or 1
    local len = #self
    if index <= 0 or index > len then return end
    local function do_peek(n, offset)
      if n <= 0 or offset >= len then return end
      return self[len - offset], do_peek(n - 1, offset + 1)
    end
    return do_peek(index, 0)
  end

  ---@param self CArray
  ---@param index integer
  ---@return any[]
  local function peekArray(self, index)
    index = index or 1
    local res = new{}
    local len = #self
    for i = 1, min(index, len) do res[i] = self[len - i + 1] end
    return res
  end

  ---@param self CArray
  ---@param index integer
  ---@return any?, CArray?
  local function pop(self, index)
    index = index or 1
    if index <= 0 or index > #self then return end
    local value = self[index]
    value = CArray.remove(self, index)
    return value and value, value and pop(self, index - 1)
  end

  ---@param self CArray
  ---@param index integer
  ---@return any[]
  local function popArray(self, index)
    index = index or 1
    local res = new{}
    for i = 1, min(index, #self) do res[i] = CArray.remove(self, i) end
    return res
  end

  ---@param self CArray
  ---@param key integer?
  ---@param value any?
  ---@return boolean?
  local function contains(self, key, value)
    if not key and not value then return end
    if not key and value then
      for i = 1, #self do
        if self[i] == value then return true end
      end
      return false
    end
    return key and (not value and self[key] or self[key] == value)
  end

  ---@param self CArray
  ---@param fn function
  ---@return integer?
  local function find(self, fn)
    for i = 1, #self do
      if fn(self[i], i) then return i end
    end
  end

  ---@param self CArray
  ---@return any[]
  local function copy(self)
    local res = new{}
    for i = 1, #self do res[i] = self[i] end
    return res
  end

  ---@param self CArray
  ---@param fn function
  ---@param arg any?
  ---@return CArray
  local function foldLeft(self, fn, arg)
    local res = self[1]
    res = arg and fn(res, arg) or res
    for i = 2, #self do res = fn(res, self[i]) end
    return res
  end

  ---@param self CArray
  ---@param fn function
  ---@param arg any?
  ---@return CArray
  local function foldRight(self, fn, arg)
    local res = self[#self]
    res = arg and fn(res, arg) or res
    for i = #self - 1, 1, -1 do res = fn(res, self[i]) end
    return res
  end

  ---@param self CArray?
  ---@return table
  local function enum(self)
    local res = self or {}
    setmetatable(res, {__newindex = function() error('attempt to modify a read-only table') end})
    return res
  end

  ---@param self CArray
  ---@param fn function
  ---@param inPlace boolean?
  ---@return CArray
  local function map(self, fn, inPlace)
    local res = inPlace and self or new{}
    for i = 1, #self do res[i] = fn(self[i]) end
    return res
  end

  ---@param self CArray
  ---@param fn function
  ---@param inPlace boolean?
  ---@return CArray
  local function filter(self, fn, inPlace)
    if inPlace then
      local i = 1
      while i <= #self do
        if not fn(self[i], i) then CArray.remove(self, i) else i += 1 end
      end
      return self
    end
    local res = new{}
    for i = 1, #self do
      local val = self[i]
      if fn(val) then res[#res + 1] = val end
    end
    return res
  end

  ---@param self CArray
  ---@param fn function
  local function forEach(self, fn)
    for i = 1, #self do fn(self[i], i) end
  end

  ---@param self CArray
  ---@param length integer?
  ---@return CArray
  local function reverse(self, length)
    if length and length <= 1 or #self <= 1 then return self end
    local i, j = 1, length and length or #self
    while i < j do
      self[i], self[j] = self[j], self[i]
      i += 1
      j -= 1
    end
    return self
  end

  CArray.new = new
  CArray.isarray = isArray
  CArray.push = push
  CArray.pusharray = pushArray
  CArray.peek = peek
  CArray.peekarray = peekArray
  CArray.pop = pop
  CArray.poparray = popArray
  CArray.contains = contains
  CArray.find = find
  CArray.copy = copy
  CArray.foldleft = foldLeft
  CArray.foldright = foldRight
  CArray.setenum = enum
  CArray.map = map
  CArray.filter = filter
  CArray.foreach = forEach
  CArray.reverse = reverse

  return CArray
end