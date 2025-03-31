# Spring 2024 Final Project by Jack Gaon and Francis Tanglao

## Tic-Tac-Toe on a FPGA
### Implemented Tic-Tac-Toe on the Nexys A7-100T using Xilinx Vivado with a UART interface
### Controls: 4 buttons for up down left right, middle button for select (X or an O based on player status on two rightmost seven-segment displays).
### Serial terminal will display a grid with numbers representing the states on the FSM also shown on the 4th seven-segment display from the left.
### Once a player selects a square it cannot be overwritten until the CPU reset button is pressed.
### The player can only select squares that still have a number in them.
### RGB LEDs: Red for player 1, blue for player 2, green for the win state, and yellow for the tie state.

## Modules and Constraint File
### The top module can be found [*here*](https://github.com/gaonjc/TicTacToe-FPGA-/blob/main/src/tictactoe_main.v)
### The constraint file can be found [*here*](https://github.com/gaonjc/TicTacToe-FPGA-/blob/main/src/Nexys-A7-100T-Master.xdc)
### The FSM module responsible for sending ASCII to the terminal can be found [*here*](https://github.com/gaonjc/TicTacToe-FPGA-/blob/main/src/tictactoe_uart.v)
### Note: The baud rate was set to 9600 in the UART module provided by Dr. Eddin which can be found [*here*](https://github.com/aseddin/3300L_lab_guides/tree/main/lab12/starter%20code)

## Physical FPGA Demo 
### ![demo](https://github.com/gaonjc/TicTacToe-FPGA-/blob/main/TicTacToeDemo.gif)

## Serial Terminal Demo 
### ![demo](https://github.com/gaonjc/TicTacToe-FPGA-/blob/main/TeraTermSerial.gif)

