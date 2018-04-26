if (LIBDW_FOUND)
    add_definitions(-DBACKWARD_HAS_DW=1)
    set(backward_ros_forced_LIBRARIES "${backward_ros_LIBRARIES} ${LIBDW_LIBRARIES}")
elseif(LIBBFD_FOUND)
    add_definitions(-DBACKWARD_HAS_BFD=1)
    set(backward_ros_forced_LIBRARIES "${backward_ros_LIBRARIES} ${LIBBFD_LIBRARIES}")
else()
    set(backward_ros_forced_LIBRARIES "${backward_ros_LIBRARIES}")
endif()
if (ROSCPP_FOUND)
    add_definitions(-DBACKWARD_HAS_ROSCPP=1)
endif()
set(backward_ros_LIBRARIES "") #This is used by catkin, but we don't need it since we force it below
foreach(lib ${backward_ros_forced_LIBRARIES})
    if(NOT EXISTS ${lib})
        message("${lib} doesn't exist, trying to find it")
        find_file(lib_path 
            NAMES "lib${lib}.so" 
            PATHS ${backward_ros_PREFIX})
            message("XXXXXXXXXXXXXXX ${lib_path} not found")
        if(NOT ${lib_path})
            message("${lib} not found")
        else()
            message("${lib_path} not found")
        endif()

    endif()
endforeach()
SET(CMAKE_EXE_LINKER_FLAGS "-Wl,--no-as-needed ${backward_ros_forced_LIBRARIES} -Wl,--as-needed ${CMAKE_EXE_LINKER_FLAGS}")

