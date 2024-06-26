cmake_minimum_required(VERSION 3.20)
project(llvm-tutor-hello-world)

#===============================================================================
# 1. LOAD LLVM CONFIGURATION
#===============================================================================

# Set this to a valid LLVM installation dir
set(LLVM_INSTALL_DIR "/home/cpsughrue/llvm-project/build")

# Add the location of LLVMConfig.cmake to CMake search paths (so that find_package can locate it)
list(APPEND CMAKE_PREFIX_PATH "${LLVM_INSTALL_DIR}/lib/cmake/llvm/")

find_package(LLVM CONFIG)

if(LLVM_FOUND)
  if("${LLVM_VERSION_MAJOR}" VERSION_LESS 18)
    message(FATAL_ERROR "Found LLVM ${LLVM_MAJOR_VERSION}, but need LLVM 18 or above")
  else()
    message("Found LLVM ${LLVM_PACKAGE_VERSION}")
  endif()
else()
  message(FATAL_ERROR "LLVM not found at ${LLVM_INSTALL_DIR}")
endif()

# HelloWorld includes headers from LLVM - update the include paths accordingly
include_directories(SYSTEM ${LLVM_INCLUDE_DIRS})

#===============================================================================
# 2. LLVM-TUTOR BUILD CONFIGURATION
#===============================================================================
# Use the same C++ standard as LLVM does
set(CMAKE_CXX_STANDARD 17)

# LLVM is normally built without RTTI. Be consistent with that.
if(NOT LLVM_ENABLE_RTTI)
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fno-rtti")
endif()

#===============================================================================
# 3. ADD THE TARGET
#===============================================================================
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY "${PROJECT_BINARY_DIR}/lib")

add_library(HelloWorld SHARED HelloWorld.cpp)
add_library(MBAAdd SHARED MBAAdd.cpp)

# Allow undefined symbols in shared objects on Darwin (this is the default
# behaviour on Linux)
target_link_libraries(HelloWorld "$<$<PLATFORM_ID:Darwin>:-undefined dynamic_lookup>")

#===============================================================================
# 4. ADD SUB-TARGETS
#===============================================================================
add_subdirectory(test)
