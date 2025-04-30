-- ===== Pippo's List =====

local pip = {}


--- @class Pip.List
--- @field private __add function
--- @field private __tostring function
--- @field private __sub function
--- @operator add : Pip.List
--- @operator sub : Pip.List
local list = {}


-- ===== Adding Data =====

--- @param value any
function list:pushFront( value )
    table.insert( self, 1, value )
end


--- @param value any
function list:pushBack( value )
    table.insert( self, value )
end


--- @param value any
function list:append( value )
    table.insert( self, value )
end


--- @return Pip.List
function list:__add( right )
    if type( right ) == "table" and #right ~= 0 then
        for _, item in ipairs( right ) do
            table.insert( self, item )
        end
    else
        table.insert( self, right )
    end

    return self
end


-- ===== Deleting Data =====

--- @param index integer
function list:swapbackPop( index )
    local backItem = self[ #self ]
    self[ index ] = backItem
    table.remove( self, #self )
end


--- @param index integer
function list:popAt( index )
    table.remove( self, index )
end


--- @return any
function list:popFront()
    return table.remove( self, 1 )
end


--- @return any
function list:popBack()
    return table.remove( self, #self )
end


--- @param value any
function list:erase( value )
    for index, item in ipairs( self ) do
        if item == value then
            table.remove( self, index )
        end
    end
end


--- @param value any
function list:swapbackErase( value )
    for index, item in ipairs( self ) do
        if item == value then
            local backItem = self[ #self ]

            self[ index ] = backItem
            table.remove( self, #self )

            return
        end
    end
end


function list:clear()
    for index = #self, 1, -1 do
        table.remove( self, index )
    end
end


--- @return any
function list:popRandom()
    local value = self:getRandom()
    self:erase( value )
    return value
end


--- @return Pip.List
function list:__sub( right )
    if type( right ) == "table" and #right ~= 0 then
        for _, item in ipairs( right ) do
            self:erase( item )
        end
    else
        self:erase( right )
    end

    return self
end


-- ===== Reading Data =====

--- @return any
function list:getFront()
    return self[ 1 ]
end


--- @return any
function list:getBack()
    return self[ #self ]
end


--- @return boolean
function list:isEmpty()
    return #self == 0
end


--- @param value any
--- @return integer?
function list:getIndex( value )
    for index, item in ipairs( self ) do
        if value == item then return index end
    end

    return nil
end


--- @param value any
--- @return boolean
function list:has( value )
    for _, item in ipairs( self ) do
        if item == value then return true end
    end

    return false
end

function list:getRandom()
    return self[ math.random( #self ) ]
end


function list:__tostring()
    local result = "["
    for _, item in ipairs( self ) do
        result = result..tostring( item )..", "
    end

    result = result:sub( 1, #result - 2 ).."]"

    return result
end


-- ===== Testing Data =====

--- @return any
function list:min()
    local min

    for _, item in ipairs( self ) do
        if not min or item < min then min = item end
    end

    return min
end


--- @return any
function list:max()
    local max

    for _, item in ipairs( self ) do
        if not max or item > max then max = item end
    end

    return max
end


--- @param func fun( value : any ) : boolean
--- @return boolean
function list:any( func )
    for _, item in ipairs( self ) do
        if func( item ) then return true end
    end

    return false
end


--- @param func fun( value : any ) : boolean
--- @return boolean
function list:all( func )
    for _, item in ipairs( self ) do
        if not( func( item ) ) then return false end
    end

    return true
end


-- ===== Constructors =====

function list:shuffle() -- Not really a constructor but idk where else to put it
    for index = #self, 2, -1 do
        local random = math.random( index )
        self[ index ], self[ random ] = self[ random ], self[ index ]
    end
end


--- @param func fun( value : any ) : any
--- @return Pip.List
function list:map( func )
    local mappedList = pip.makeList()

    for _, item in ipairs( self ) do
        local result = func( item )
        if result then mappedList:append( result ) end
    end

    return mappedList
end


--- @param func fun( value : any ) : boolean
--- @return Pip.List
function list:filter( func )
    local filteredList = pip.makeList()

    for _, item in ipairs( self ) do
        if func( item ) then filteredList:append( item ) end
    end

    return filteredList
end


--- @return Pip.List
function list:duplicate()
    return pip.makeList( unpack( self ) )
end


local function makeIterator()
    local index

    return function ( t, _, lastValueReturned )
        index = ( lastValueReturned and index + 1 ) or 1
        if index <= #t then return t[ index ] end
    end
end


local function makeMetaTable()
    return {
        __sub = list.__sub,
        __add = list.__add,
        __index = list,
        __call = makeIterator(),
        __tostring = list.__tostring
    }
end


--- @return Pip.List
function pip.makeList( ... )
    local newList = { ... }
    return setmetatable( newList, makeMetaTable() )
end


return pip
