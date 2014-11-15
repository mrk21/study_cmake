# Command Arguments
# see: http://www.cmake.org/cmake/help/v3.0/manual/cmake-language.7.html#command-arguments
# The command arguments have 3 patterns as listed below:
# - Bracket Argument
# - Quated Argument
# - Unquated Argument

set(variable 123)

# Bracket Argument
# see: http://www.cmake.org/cmake/help/v3.0/manual/cmake-language.7.html#bracket-argument
# memo: The bracket argument can be used when CMake version is greater than or equal to 3.0.

message([[
A first line.
A second line.
A third line.
]])

message([=[
A variable reference is disabled: ${variable}
]]
]=])

message([==[
An escape sequence is disabled: \t
]=]
]==])
