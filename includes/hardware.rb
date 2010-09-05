# ========
# Hardware
# ========

# Smooths out the serial interface, and sets up the link
require "hardware/serial_interface"

# Impliments low level servo-controller controll
require "hardware/servo_controller_commands"
require "hardware/servo_controller"

# Deals with finding an identifying the servo controllers
require "hardware/interface_manager"

# Matrix controller, used in the following two includes
require "hardware/matrix_controller"

# Combines the servo controllers into a grid, uses MatrixController
require "hardware/grid_controller"

# IO controller, seperates IO controll from servo, uses MatrixController
# TODO: Currently an empty class.
require "hardware/io_controller"

# Initialize the hardware
require "hardware/init"