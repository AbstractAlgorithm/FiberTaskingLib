cmake_minimum_required(VERSION 2.8)
project(FiberTaskingLib)


set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_CURRENT_SOURCE_DIR}/cmake")

include(Config)
Config()

# Options
OPTION(FTL_BUILD_TESTS    "Build FiberTaskingLib tests" ON)


# Build FiberTaskingLib
include_directories(include third_party third_party/EASTL/include)

add_subdirectory(third_party/EASTL)
add_subdirectory(source)

if (FTL_BUILD_TESTS)
	#Build Tests
	include(CTest)
	include_directories(third_party/gtest/include)
	SET(gtest_force_shared_crt ON CACHE BOOL "Use the dll runtime" )
	add_subdirectory(third_party/gtest)

	add_subdirectory(tests)
endif()
