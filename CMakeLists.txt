cmake_minimum_required(VERSION 3.14)
project(CICDApp)

set(CMAKE_CXX_STANDARD 17)

include_directories(include)

add_library(math_utils src/math_utils.cpp)

add_executable(app src/main.cpp)
target_link_libraries(app math_utils)

# GoogleTest
enable_testing()
find_package(GTest REQUIRED)

add_executable(unit_tests tests/test_math.cpp)
target_link_libraries(unit_tests math_utils GTest::GTest GTest::Main)

add_test(NAME RunTests COMMAND unit_tests)
