#!/usr/bin/env cmake -P
cmake_minimum_required(VERSION 3.0)


message([[
## Boolean constants

The boolean constants are case-insenstive.

### Truthy values

* Non 0 numbers
* TRUE
* ON
* YES
* TRUE
* Y
]])

if(true)
  message([[=> A "true" is truthy value]])
endif()

message([[

### Falsy values

* 0
* OFF
* NO
* FALSE
* N
* IGNORE
* NOTFOUND
* XXX-NOTFOUND
]])

if(NOT false)
  message([[=> A "false" is falsy value]])
endif()

if(NOT package_notfound)
  message([[=> A "package_notfound" is falsy value]])
endif()
