cmake_minimum_required(VERSION 3.10)
project(OpenGL)
 
set(CMAKE_CXX_STANDARD 14)
#这里GLAD_INCLUDE目录填你自己存放的路径
set(GLAD_INCLUDE lib/glad/include)
set(TOOL_INCLUDE tool)
set(STB_IMAGE_INCLUDE lib/stb_image)
 
find_package(glfw3 REQUIRED)

add_subdirectory(lib/glm)

add_library(STB_IMAGE "tool/stb_image.cpp")
set(LIBS ${LIBS} STB_IMAGE)

add_library(GLAD "lib/glad/src/glad.c")
set(LIBS ${LIBS} GLAD)
 
include_directories(${GLAD_INCLUDE})
include_directories(${TOOL_INCLUDE})
include_directories(${STB_IMAGE_INCLUDE})
 
add_executable(OpenGL main.cpp)
 
target_link_libraries(OpenGL glfw glm ${LIBS})