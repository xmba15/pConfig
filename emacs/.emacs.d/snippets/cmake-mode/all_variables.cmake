# -*- mode: snippet -*-
# name: all_variables
# key: all_variables
# --

get_cmake_property(_variableNames VARIABLES)
list (SORT _variableNames)
foreach (_variableName \${_variableNames})
    message(STATUS "\${_variableName}=\${\${_variableName}}")
endforeach()