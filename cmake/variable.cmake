
# if(NOT EXISTS ${CMAKE_INSTALL_PREFIX})
#     file(MAKE_DIRECTORY ${CMAKE_INSTALL_PREFIX})
# endif()
message(STATUS "CMAKE_INSTALL_PREFIX: ${CMAKE_INSTALL_PREFIX}")

include_directories(
    ${PROJECT_SOURCE_DIR}/3rdparty/gtest/include/
    ${PROJECT_SOURCE_DIR}/extproj/cpp-tools/
)

link_directories(
    ${PROJECT_SOURCE_DIR}/3rdparty/gtest/libs/
)
