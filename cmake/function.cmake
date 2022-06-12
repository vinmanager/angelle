
function(add_module module)
   include(${module}/build.cmake)
endfunction()

function(dependence_library module)
    set(DEPENDENCES_FILE ${CMAKE_CURRENT_LIST_DIR}/dependences)
    message(STATUS "DEPENDENCES_FILE:${DEPENDENCES_FILE}")
    if(EXISTS ${DEPENDENCES_FILE})
        file(STRINGS ${DEPENDENCES_FILE} LIBS)
        #message(STATUS "DEPENDENCES : ${LIBS}")
        foreach(ITEM ${LIBS})
            if(NOT(${ITEM} MATCHES "#.*"))
                # message(STATUS "ITEM LIB : ${ITEM}")
                target_link_libraries(${module} ${ITEM})
            endif()
        endforeach()
    endif()
endfunction()

function(build_static_library name)
    include_directories(${CMAKE_CURRENT_LIST_DIR}/include)
    file(GLOB_RECURSE SRCS ${CMAKE_CURRENT_LIST_DIR}/*.cc)
    file(GLOB_RECURSE REMOVE_TEST_CPP ${CMAKE_CURRENT_LIST_DIR}/*_test.cc)
    list(REMOVE_ITEM ${SRCS} ${REMOVE_TEST_CPP})
    add_library(${name} STATIC ${SRCS})
    dependence_library(${module})
    install(TARGETS ${name} LIBRARY DESTINATION lib)
endfunction()

function(build_shared_library name)
    include_directories(${CMAKE_CURRENT_LIST_DIR}/include)
    file(GLOB_RECURSE SRCS ${CMAKE_CURRENT_LIST_DIR}/*.cc)
    file(GLOB_RECURSE REMOVE_TEST_CPP ${CMAKE_CURRENT_LIST_DIR}/*_test.cc)
    list(REMOVE_ITEM SRCS ${REMOVE_TEST_CPP})
    add_library(${name} SHARED ${SRCS})
    dependence_library(${module})
endfunction()

function(build_exported)
    set(INCLUDE_PATH ${CMAKE_CURRENT_LIST_DIR}/include)
    set(ROOT_PATH ${CMAKE_CURRENT_LIST_DIR})
    file(MAKE_DIRECTORY ${INCLUDE_PATH})
    file(STRINGS ${CMAKE_CURRENT_LIST_DIR}/exported exports)
    foreach(item ${exports})
        message(STATUS "ITEM LIB : ${item}")
        set(TMP_FILE ${ROOT_PATH}/${item})
        if(EXISTS ${TMP_FILE})
            file(COPY ${TMP_FILE} DESTINATION ${INCLUDE_PATH} FOLLOW_SYMLINK_CHAIN)
        else()
            message(STATUS "${TMP_FILE} file is not exist")
        endif()
    endforeach()
endfunction()

function(build_app module)
    include_directories(${CMAKE_CURRENT_LIST_DIR}/include)
    file(GLOB_RECURSE BASE_SRCS ${CMAKE_CURRENT_LIST_DIR}/*.cc)
    file(GLOB_RECURSE REMOVE_TEST_CPP ${CMAKE_CURRENT_LIST_DIR}/*_test.cc)
    list(REMOVE_ITEM BASE_SRCS ${REMOVE_TEST_CPP})
    set(BASE_SRCS ${APP_SOURCES} ${BASE_SRCS})

    set(INDEX 1)
    math(EXPR MAX "${ARGC}")
    while(INDEX LESS ${MAX})
        # message("INDEX = " ${INDEX})
        # message("ARG = " ${ARGV${INDEX}})
        list(APPEND BASE_SRCS ${CMAKE_CURRENT_LIST_DIR}/${ARGV${INDEX}})
        math(EXPR INDEX "${INDEX} + 1")
    endwhile()

    add_executable(${module} ${BASE_SRCS})
    dependence_library(${module})
    install(TARGETS ${module} RUNTIME DESTINATION bin)
endfunction()

function(build_test)
    file(GLOB_RECURSE TEST_SRCS ${CMAKE_CURRENT_LIST_DIR}/*_test.cc)
    foreach(ITEM ${TEST_SRCS})
        STRING(REGEX REPLACE ".+/(.+)\\..*" "\\1" FILE_NAME ${ITEM})
        #message(STATUS "test file:${FILE_NAME}")
        add_executable(${FILE_NAME} ${ITEM})
        dependence_library(${FILE_NAME})
        install(TARGETS ${FILE_NAME} RUNTIME DESTINATION bin)
    endforeach()
endfunction()
