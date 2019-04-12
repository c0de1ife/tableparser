# tableparser
convert between lua table and string.

## usage
there are only three functions in this parser.
* parser.dump to show a table in friendly way.  
* parser.encode to convert a lua table to string.  
* parser.decode to convert a string to lua table.  

you can find examples in [test file](https://github.com/c0de1ife/tableparser/blob/master/tableparser_test.lua).

## attention
key of table can be `string`, `number` and `boolen`. value of table can be `string`, `number`, `boolen` and `table`.
