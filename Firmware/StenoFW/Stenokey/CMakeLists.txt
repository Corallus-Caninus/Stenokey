cmake_minimum_required(VERSION 3.13)

include(pico_sdk_import.cmake)

project(test_project C CXX ASM)
set(CMAKE_C_STANDARD 11)
set(CMAKE_CXX_STANDARD 17)
pico_sdk_init()

add_executable(Stenokey
    Stenokey.c
)

pico_enable_stdio_usb(Stenokey 1)
pico_enable_stdio_uart(Stenokey 1)

pico_add_extra_outputs(Stenokey)
target_link_libraries(Stenokey pico_stdlib)
target_link_libraries(Stenokey hardware_pio)
target_link_libraries(Stenokey hardware_dma)

# add_executable(pio_Stenokey)
# include(pico_sdk_import.cmake)
# target_sources(pio_Stenokey PRIVATE Stenokey.c)

# target_link_libraries(pio_Stenokey PRIVATE pico_stdlib hardware_pio hardware_dma)
# pico_add_extra_outputs(pio_Stenokey)

# # add url via pico_set_program_url
# example_auto_set_url(pio_Stenokey)