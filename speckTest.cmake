# set default value if needed
if( NOT DEFINED SPECK_PATH )
    set( SPECK_PATH speck )
endif( NOT DEFINED SPECK_PATH )

set( SPECK_EXECUTABLE speck )
# set speck folder
set( SPECK ${SPECK_PATH}/${SPECK_EXECUTABLE} )

# find all suites
file( GLOB SUITES ../spec/*.c )

# add speck includes
include_directories( ${SPECK_PATH} )

# create for every suite its own library
foreach( SUITE ${SUITES} )
    get_filename_component( SUITE_NAME ${SUITE} NAME )
    string( REPLACE ".c" "" SUITE_LIB ${SUITE_NAME} )
    add_library( ${SUITE_LIB} SHARED ${SUITE} )
    set_target_properties( ${SUITE_LIB} PROPERTIES PREFIX "" )
    set_target_properties( ${SUITE_LIB} PROPERTIES LIBRARY_OUTPUT_DIRECTORY ../spec )
endforeach( SUITE )

# create the speck executeable
add_executable( ${SPECK_EXECUTABLE} ${SPECK_PATH}/speck.c )
target_link_libraries( ${SPECK_EXECUTABLE} ${CMAKE_DL_LIBS} )
set_target_properties( ${SPECK_EXECUTABLE} PROPERTIES RUNTIME_OUTPUT_DIRECTORY ${SPECK_PATH} )
