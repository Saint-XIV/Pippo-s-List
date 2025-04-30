# Pippo's List
A list class for Lua and Love2D

## Basics
### Making A List
You can make a list by calling the function makeList. You can provide initial values for this list as function parameters.
```lua
local list = makeList( "Hello World", "foo", "pippo" )
```
After declaration, you can interact with it as any other Lua array.
```lua
local item = list[ 4 ]
list[ 9 ] = item

for index, item in ipairs( list ) do
  print( item )
end
```
### Adding Data to the List
You can add data in several ways by calling the appropiate method on the list. Here are some examples.
```lua
list:append( "I'm going to the back of the list!" )
list:pushBack( "Me too!" )
list:pushFront( "I'm going to the front!" )
list = list + "I'm going to the back too!"
list = list + otherList -- We'll be added to the back as well!
list = list + { "I'm going to the back!", "Me too!" }
```
### Removing Data from the List
Similarly to adding data to a list, you can remove it by calling methods on the list. Here are some examples.
```lua
local poppedFromTheBack = list:popBack()
local poppedFromTheFront = list:popFront()
local poppedAtIndex = list:popAt( 3 )
list:erase( "I'll delete anything the same as me! (by reference)" )
list:clear() -- I'm empty now!
list = list - "I'll delete anything the same as me! (by reference)"
list = list - otherList -- I'll delete everything in otherList!
```
### Reading Data from the List
There are several functions that can tell you about the data in the list, or the list itself. Here are some examples.
```lua
local readFromTheBack = list:getBack()
local readFromTheFront = list:getFront()
local isEmpty = list:isEmpty()
local size = #list
local listHasItem = list:has( "I'll be true if i'm in the list! (by reference)" )
local indexOfItem = list:getIndex( "I'll return the index of where I am in the list! (by reference)" )
```
## Advanced
### Randomness
There are several methods to help keep things random. Here are some examples.
```lua
local randomValueStillInList = list:getRandom()
local randomValueErasedFromList = list:popRandom()
list:shuffle() -- My items are now in a random order!
```
### Swapback Methods
There are a few methods to erase values by swapping them with the back, which is faster on longer lists. Here are some examples.
```lua
list:swapbackErase( "I'll erase something the same as me! (by reference)" )
list:swapbackPop( 3 ) -- I'll swapback erase whatever is at this index!
```
### Testing Items
There are a couple methods you can use to test the contents of a list. They will return booleans. Here are some examples.
```lua
local isEveryItemInListIsBiggerThanThree = list:all( function( item ) return item > 3 end )
local isAnyItemInListIsEqualToHello = list:any( function( item ) return item == "hello" end )
```
### Testing Extremums
There are a couple methods you can use to get the max or min value from a list. They will return that value. This will only work on list items that are numbers, or tables that have the __lt metafunction. Here are some examples.
```lua
local list = makeList( 10, 5, 25 )
local minValue = list:min() -- I'll be 5!
local maxValue = list:max() -- I'll be 25!
```
### Advanced Constructors
There are a couple methods you can use to make a new list, based on data from an old one. Here are some examples.
```lua
local listWithItemsTwiceAsBig = list:map( function( item ) return item * 2 end )
local listWithOnlyStrings = list:filter( function( item ) return type( item ) == "string" end )
local duplicateList = list:duplicate() -- Same contents, different reference
```
### Simple Iteration
You can iteratere through lists using simplified syntax, provided you do not nest the same list's simple iteration inside itself. Here is an example.
```lua
-- All is good here
for item in list do
  print( item )
end

-- This will break!!!
for item in list do
  print( item )
  for item2 in list do
    print( item2 ) -- This will not be what you expect!!!
  end
end
```
