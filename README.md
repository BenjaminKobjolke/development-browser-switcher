# Development Browser Switcher

This AutoHotkey script streamlines web development workflows by allowing you to quickly switch between your Integrated Development Environment (IDE) and your web browser using a single keyboard shortcut.

## How it Works

-   **Save & Refresh (IDE -> Browser):** Press `Ctrl + S` while your IDE window is active. The script will:
    1.  Send the `Ctrl + S` command to your IDE to save the current file.
    2.  (Optional) If Notepad++ integration is enabled, it waits for the built-in FTP plugin to finish uploading the saved file.
    3.  Switch focus to your configured web browser window.
    4.  Send the `F5` key to refresh the active browser tab.
-   **Switch Back (Browser -> IDE):** Press `Ctrl + S` while your browser window is active. The script will switch focus back to your IDE window.

## Features

-   Single shortcut (`Ctrl + S`) for saving, (optional) uploading, switching, and refreshing.
-   Supports various popular IDEs and browsers.
-   Customizable to work with other IDEs/browsers via window titles.
-   Optional integration with Notepad++'s FTP upload status.
-   Configuration GUI and Tray Menu for easy setup.

## Configuration

The script reads its settings from the `settings.ini` file. You can configure these settings using the Tray Menu or the Setup window accessible from the Tray Menu (`Right-click Tray Icon -> Setup`).

Available settings read from `settings.ini`:

-   **`browser`**: Choose the target browser to activate and refresh.
    -   Supported Values: `Chrome`, `Brave`, `Firefox`, `Opera`, `Safari`
    -   `CUSTOM`: Uses the window title specified in the `custom` setting.
-   **`custom`**: The window title to use when `browser` is set to `CUSTOM`.
-   **`ide`**: Choose the IDE to switch from/to.
    -   Supported Values: `Notepad++`, `Eclipse`, `Visual Studio`
    -   `CUSTOM`: Uses the window title specified in the `customide` setting.
-   **`customide`**: The window title to use when `ide` is set to `CUSTOM`.
-   **`upload`**: Enable/Disable Notepad++ FTP upload waiting.
    -   `1`: Enabled. The script waits for Notepad++'s FTP plugin to report "Upload succeeded" before switching to the browser. This prevents refreshing before the changes are live.
    -   `0`: Disabled. The script switches immediately after saving.
-   **`macro`**: Enable/Disable a custom method for switching windows.
    -   `1`: Enabled. Executes the code within `macro.ahk`. You can place custom AutoHotkey code in `macro.ahk` if you need to customize the window switching process beyond the standard behavior (e.g., for specific window handling, running additional commands, etc.).
    -   `0`: Disabled. Uses the standard AutoHotkey `WinActivate` command for switching windows.

## Requirements

-   [AutoHotkey](https://www.autohotkey.com/) v1.x installed.
-   (Optional) Notepad++ with the FTP plugin if using the `upload = 1` integration feature.

## Usage

1.  Ensure AutoHotkey v1.x is installed.
2.  Run `browserswitcher.ahk`.
3.  Right-click the tray icon and select `Setup` or choose your browser directly from the menu to configure your settings. The settings are saved in `settings.ini`.
4.  Use `Ctrl + S` in your configured IDE or browser to switch between them.

## License

See the [LICENSE](LICENSE) file for details.
