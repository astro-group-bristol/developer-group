# Toolbox

Please open a PR to submit a description of a tool.

<!--
Format your entry in the following way:

- **Tool name**: short description.

  Find more [here](https://url).
-->

- **cal**: A command line calendar installed on pretty much every Linux system by default:
  ```
  $ cal
       February 2025
   Mo Tu We Th Fr Sa Su
                   1  2
    3  4  5  6  7  8  9
   10 11 12 13 14 15 16
   17 18 19 20 21 22 23
   24 25 26 27 28
  ```
  Useful flags include `-y` for the whole year, and `-3` for the surrounding months.

- **screen**: A terminal multiplexer that allows opening of multiple terminal sessions which persist after disconnecting from a sever. Useful for long running tasks.\
  Some basic commands to start with:\
`screen -S name` starts a new screen session with the given name\
`screen -d` detaches from a screen while leaving started processes running\
`screen -r name` reattaches to the screen of the given name\
`screen -ls` shows all active screens and status (attached of detached)\
Type `exit` while in a screen to close and terminate the screen. Or, `screen -XS name quit` to close a specific screen
