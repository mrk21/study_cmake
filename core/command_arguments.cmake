#!/usr/bin/env cmake -P
# Command Arguments
# see: http://www.cmake.org/cmake/help/v3.0/manual/cmake-language.7.html#command-arguments
# The command arguments have 3 patterns as listed below:
# - Bracket Argument
# - Quated Argument
# - Unquated Argument

cmake_minimum_required(VERSION 3.0)

set(variable 123)


# Bracket Argument
# see: http://www.cmake.org/cmake/help/v3.0/manual/cmake-language.7.html#bracket-argument
# memo: The bracket argument can be used when CMake version is greater than or equal to 3.0.

message("## Bracket Argument")

# Multiple line
# memo: Ignore a first blank line.
message([[
A first line.
A second line.
A third line.]])

# Variable reference
message([=[
A variable reference is disabled: ${variable}
]]]=])

# Escape sequence
message([==[
An escape sequence is disabled: a\tb]=
]]==])


# Quated Argument
# see: http://www.cmake.org/cmake/help/v3.0/manual/cmake-language.7.html#quoted-argument

message(\n)
message("## Quated Argument")

# Multiple line
message("
A second line.
A third line.")

# Value reference
message("A variable reference is enabled: ${variable}")

# Escape sequence
message("An escape sequence is enabled: a\tb")

# Continuation line
message("A first line. \
The same line.")


# Unquated Argument
# see: http://www.cmake.org/cmake/help/v3.0/manual/cmake-language.7.html#unquoted-argument

message(\n)
message("## Unquated Argument")

# Multiple line
message(A\ first\ line.\n
A\ second\ line.\n
A\ third\ line.)

# Value reference
message(A\ variable\ reference\ is\ enabled:\ ${variable})

# Escape sequence
message(An\ escape\ sequence\ is\ enabled:\ a\tb)

# List
foreach(v The;list;elements Not\;List\;Element [Not;List;Element])
  message(${v})
endforeach()
