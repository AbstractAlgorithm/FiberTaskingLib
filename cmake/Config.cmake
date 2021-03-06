## FiberTaskingLib - A tasking library that uses fibers for efficient task switching
 #
 # This library was created as a proof of concept of the ideas presented by
 # Christian Gyrling in his 2015 GDC Talk 'Parallelizing the Naughty Dog Engine Using Fibers'
 #
 # http://gdcvault.com/play/1022186/Parallelizing-the-Naughty-Dog-Engine
 #
 # FiberTaskingLib is the legal property of Adrian Astley
 # Copyright Adrian Astley 2015 - 2016
 ##

macro(Config)
	if (UNIX)
		SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")
	elseif (MSVC)
		SET( CMAKE_CXX_FLAGS  "${CMAKE_CXX_FLAGS} /GT" )
	endif()
	
	# Determine what fiber implementation we should use
	if (MSVC)
		set(FTL_WIN32_FIBER_IMPL ON)
	else()
		set(FTL_BOOST_CONTEXT_FIBER_IMPL ON)
	endif()
	
	if (FTL_BOOST_CONTEXT_FIBER_IMPL)
		find_package(Boost 1.56 COMPONENTS context REQUIRED)
		find_package(Threads)
		include_directories(${Boost_INCLUDE_DIR})
		link_directories(${Boost_LIBRARY_DIRS})
	endif()

	# Determine if the compiler supports fiber-safe TLS
	if (MSVC)
		set(FTL_FIBER_IMPL_SUPPORTS_TLS ON)
	endif()	
	
	configure_file( ${CMAKE_CURRENT_SOURCE_DIR}/cmake/config.h.cmake ${CMAKE_CURRENT_SOURCE_DIR}/include/fiber_tasking_lib/config.h )
endmacro()