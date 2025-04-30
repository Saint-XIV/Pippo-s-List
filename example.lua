require "pippo's list"

-- Make a basic list
local list = makeList( "Hello World", "foo", "pippo" )

-- Print the list
print( "Initial list:\n"..tostring( list ).."\n" )

-- Add a values to the list
list:append( "bar" )
list:pushBack( "guy" )
list:pushFront( "Hi there!" )
list = list + "gal"

-- You can also add a list to another list, or a standard Lua array
local listToAdd = makeList( "dragon", "deer" )
list = list + listToAdd
list = list + { "fox", "opposum" }

-- Print to see the changes
print( "Now you've added a bunch of elements:\n"..tostring( list ).."\n" )

-- Remove values from list
list:popBack()
list:popFront()
list:popAt( 2 )
list:erase( "bar" )
list = list - listToAdd -- Undo our list concatenation
list = list - { "fox", "opposum" }

-- Print to see the changes
print( "Now you've removed a bunch of elements:\n"..tostring( list ).."\n" )

-- Let's get come values from our list.
local readFromTheBack = list:getBack()
local readFromTheFront = list:getFront()
local isEmpty = list:isEmpty()
local size = #list
local listHasItem = list:has( "pippo" )
local indexOfItem = list:getIndex( "guy" )

-- Printing to see what we got:
print( "List data:" )
print( "getBack = "..readFromTheBack )
print( "getFront = "..readFromTheFront )
print( "isEmpty = "..tostring( isEmpty ) )
print( "size = "..size )
print( "has = "..tostring( listHasItem ) )
print( "getIndex = "..indexOfItem )

-- Let's look at some randomness
print( "\nGetting a random value from list:\n"..tostring( list:getRandom() ).."\n"..tostring( list ) )
print( "\nRemoving a random value from list:\n"..tostring( list:popRandom() ).."\n"..tostring( list ) )
list:shuffle() -- Shuffling the remaning elements
print( "\nResult of shuffle:\n"..tostring( list ) )

-- Swapback erasing
list = makeList( 1, 2, 3, 4, 5 )

print("\nHere's our list after creation:\n"..tostring( list ) )
list:swapbackErase( 3 )
print( "Notice how 5 is where 3 used to be:\n"..tostring( list ) )
list:swapbackPop( 2 )
print( "And how how 4 is where 2 used to be:\n"..tostring( list ) )

-- Testing items
list = makeList( 5, 4, 9, 8 )
print( "\n"..tostring( list ) )
print( "Is every element bigger than 3?\n"..tostring( list:all( function( value ) return value > 3 end ) ) )
print( "Is any element equal to 7?\n"..tostring( list:any( function( value ) return value == 7 end ) ) )

-- Testing extremums
print("\nMax value from list: "..tostring( list:max() ) )
print( "Min value from list: "..tostring( list:min() ) )

-- Advanded constructors
local duplicateList = list:duplicate()
local listTwiceAsBig = duplicateList:map( function ( value ) return value * 2 end )
local listWithNumbersBiggerThan5 = duplicateList:filter( function ( value ) return value > 5 end )

print( "\nDuplicate List: "..tostring( duplicateList ) )
print( "List with items doubled: "..tostring( listTwiceAsBig ) )
print( "List with numbers bigger than 5: "..tostring( listWithNumbersBiggerThan5 ) )

-- Simple iteration
print( "\nUsing simple iteration to loop through list:")
for item in listTwiceAsBig do
    print( item )
end
