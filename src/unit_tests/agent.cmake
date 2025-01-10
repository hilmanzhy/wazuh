# Find the verprotect shared library
find_library(VERPROTECTEXT NAMES libverprotectext.dylib HINTS "${SRC_FOLDER}")
if(VERPROTECTEXT)
  set(uname "Darwin")
else()
  set(uname "Linux")
endif()
find_library(VERPROTECTEXT NAMES libverprotectext.so HINTS "${SRC_FOLDER}")

if(NOT VERPROTECTEXT)
    message(FATAL_ERROR "libverprotectext not found! Aborting...")
endif()

# # Add compiling flags and set tests dependencies
if(${uname} STREQUAL "Darwin")
    set(TEST_DEPS ${VERPROTECTLIB} ${VERPROTECTEXT} -lpthread -ldl -fprofile-arcs -ftest-coverage)
    add_compile_options(-ggdb -O0 -g -coverage -DTEST_AGENT -I/usr/local/include -DENABLE_SYSC -DVERPROTECT_UNIT_TESTING)
else()
    add_compile_options(-ggdb -O0 -g -coverage -DTEST_AGENT -DENABLE_AUDIT -DINOTIFY_ENABLED -fsanitize=address -fsanitize=undefined)
    link_libraries(-fsanitize=address -fsanitize=undefined)
    set(TEST_DEPS ${VERPROTECTLIB} ${VERPROTECTEXT} -lpthread -lcmocka -ldl -fprofile-arcs -ftest-coverage)
endif()

if(NOT ${uname} STREQUAL "Darwin")
  add_subdirectory(client-agent)
  add_subdirectory(logcollector)
  add_subdirectory(os_execd)
endif()

add_subdirectory(verprotect_modules)
