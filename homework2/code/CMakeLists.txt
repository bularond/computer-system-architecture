# set minimum cmake version
cmake_minimum_required(VERSION 3.5 FATAL_ERROR)

# project name and language
project(task2 LANGUAGES CXX)

set(BUILD_DIR "${CMAKE_BINARY_DIR}")
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${BUILD_DIR}/../../bin")

set(BINARY_DIR "${CMAKE_BINARY_DIR}")

# Source files list
set(SOURCE_FILES
        container.h
        shape.h
        rectangle.h
        triangle.h
        circle.h
        point.h

        main.cpp
        point.cpp
        container.cpp
        rectangle.cpp
        triangle.cpp
        circle.cpp
        shape.cpp
        )

add_executable(task02 ${SOURCE_FILES})
