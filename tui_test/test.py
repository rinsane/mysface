import curses

def create_bordered_window(win, height, width, y, x):
    """Create a bordered window."""
    border_win = curses.newwin(height, width, y, x)
    border_win.box()
    return border_win

def main(stdscr):
    curses.curs_set(1)  # Show the cursor
    stdscr.clear()
    height, width = stdscr.getmaxyx()

    input_win_height = 3
    command_win_height = 5
    result_win_height = height - input_win_height - command_win_height - 2  # 2 for borders

    input_win = create_bordered_window(stdscr, input_win_height, width, height - input_win_height, 0)
    result_win = create_bordered_window(stdscr, result_win_height, width, 0, 0)
    command_win = create_bordered_window(stdscr, command_win_height, width, height - input_win_height - command_win_height - 1, 0)

    commands = ["Print", "Create List", "Create Dict"]
    for i, cmd in enumerate(commands):
        if 2 + i < command_win_height - 1:  # Check if command fits in the window
            command_win.addstr(1 + i, 2, f"{i + 1}. {cmd}")

    command_win.refresh()

    input_win.addstr(1, 1, "Enter command: ")
    input_win.refresh()

    result_win.addstr(1, 1, "Results will be shown here...")
    result_win.refresh()

    while True:
        key = stdscr.getch()

        if key == ord('q'):
            break

        if key == curses.KEY_ENTER or key in (10, 13):
            # Execute input command
            command = input_win.instr(1, 14).decode("utf-8").strip()
            result_win.clear()
            result_win.box()
            if command.lower() == "print":
                result_win.addstr(1, 1, "Printing: Hello, World!")
            elif command.lower() == "create list":
                result_win.addstr(1, 1, "Created a list: []")
            elif command.lower() == "create dict":
                result_win.addstr(1, 1, "Created a dict: {}")
            else:
                result_win.addstr(1, 1, "Unknown command")
            result_win.refresh()
            input_win.clear()
            input_win.box()
            input_win.addstr(1, 1, "Enter command: ")
            input_win.refresh()
        
        elif key == ord('c'):
            input_win.clear()
            input_win.box()
            input_win.addstr(1, 1, "Enter command: ")
            input_win.refresh()

        elif key == curses.KEY_DOWN:
            result_win.clear()
            result_win.box()
            result_win.addstr(1, 1, "Down key pressed")
            result_win.refresh()
        
        elif key == curses.KEY_UP:
            result_win.clear()
            result_win.box()
            result_win.addstr(1, 1, "Up key pressed")
            result_win.refresh()

curses.wrapper(main)
