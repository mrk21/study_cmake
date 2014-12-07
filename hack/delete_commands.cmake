#!/usr/bin/env cmake -P
cmake_minimum_required(VERSION 3.0.2)

# Delete commands
# The function to delete commands is implemented by storing in the `__command_<name>_deleted__` global property
# whether the `<name>` command has been deleted and cheking that property.

function(command_deleted_property_name result)
  set(${result} __command_${name}_deleted__ PARENT_SCOPE)
endfunction()

function(is_deleted_command name result)
  command_deleted_property_name(prop_name)
  if(NOT COMMAND ${name})
    set(${result} true PARENT_SCOPE)
    return()
  endif()
  get_property(prop GLOBAL PROPERTY ${prop_name})
  set(${result} "${prop}" PARENT_SCOPE)
endfunction()

function(delete_command name)
  command_deleted_property_name(prop_name)
  function(${name})
    message([[This command is deleted!]])
  endfunction()
  set_property(GLOBAL PROPERTY ${prop_name} true)
endfunction()


is_deleted_command(func is_deleted)
if(is_deleted)
  message("## 1: func() is deleted")
endif()

function(func a b c)
  message("This command is defined!")
endfunction()
func(1 2 3) # This command is defined!

is_deleted_command(func is_deleted)
if(is_deleted)
  message("## 2: func() is deleted")
endif()

delete_command(func)
func(1 2 3) # This command is deleted!

is_deleted_command(func is_deleted)
if(is_deleted)
  message("## 3: func() is deleted")
endif()
