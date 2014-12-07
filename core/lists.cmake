#!/usr/bin/env cmake -P
cmake_minimum_required(VERSION 3.0.2)


set(list_value a;b;c;d)

list(GET list_value 1 -1 0 list_value2)
message("${list_value2}") # b;d;a
