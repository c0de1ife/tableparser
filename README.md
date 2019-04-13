# tableparser
convert between lua table and string.

## usage
there are only three common functions in this parser.
* `parser.dump` show a table in friendly way.  
* `parser.encode` convert a lua table to string.  
* `parser.decode` convert a string to lua table.  

you can find examples in [test file](https://github.com/c0de1ife/tableparser/blob/master/tableparser_test.lua).

## attention
key of table can be `string`, `number` and `boolen`. value of table can be `string`, `number`, `boolen` and `table`. other circumstances will cause an error.

## other apis
* `parser.useStrict` if you are sure that you are not using special string type keys(like special characters, utf8 characters, string type numbers, punctuations, etc.) in your lua table, you can send a 'false' to this function for encoding keys simpler.
