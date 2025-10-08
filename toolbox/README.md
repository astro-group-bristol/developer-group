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

- **WebSpec**: Lets you run a limited version of the `fakeit` XSPEC command
  directly in the browsers.

   Try it out [here](https://heasarc.gsfc.nasa.gov/webspec/webspec.html)
   
- **Crontab**: A tool for code Scheduling in Unix Systems.
  Find more [here](crontab.md)


- **screen**: A terminal multiplexer that allows opening of multiple terminal sessions which persist after disconnecting from a sever. Useful for long running tasks.\
  Some basic commands to start with:\
`screen -S name` starts a new screen session with the given name\
`screen -d` detaches from a screen while leaving started processes running\
`screen -r name` reattaches to the screen of the given name\
`screen -ls` shows all active screens and status (attached of detached)\
Type `exit` while in a screen to close and terminate the screen. Or, `screen -XS name quit` to close a specific screen

  
- **Obsidian**: Talked about at length by [Joe](https://github.com/HallJoseph), but it's a neat note taking and organsing piece of software. Link: https://obsidian.md/. Free to use, but has a premium plan allowing cloud back ups. My get around for that is to keep Obsidian in the OneDrive section on my Mac which uses the 2 TB of university provided cloud storage.

I have a nice little callable script that will convert position between decimal degrees and sexagesimal or vice versa. This can easily be used within another script if needed and is a quick way to get around the annoying change of labelling.


- **nicer notebook plots**
  
  Adding ``%config InlineBackend.figure_format = 'retina'`` to your jupyter notebook will display (matplotlib) figures in higher resolution.
  
- **git difftool**: The git `difftool` command lets you see diffs between commits graphically.
By default it looks for some likely looking graphical diff tools on
your system, but you can configure exactly what it does.
Set it up by editing the `~/.gitconfig` file
(or alternatively `git config --global`):
  ```
  [diff]
          tool = xxdiff
  [difftool "xxdiff"]
          cmd = xxdiff -w $LOCAL $REMOTE
  [difftool]
          prompt = false
  [diff "image"]
          command = imgdiff.sh
  ```
  The specific `xxdiff` invocation I've got here uses the `-w` flag
  to make it ignore whitespace in diffs.

  That [imgdiff.sh](imgdiff.sh) is a hacky but neat script based on
  [ImageMagick](https://imagemagick.org/)
  that does a visual diff of images.
  You can tell git what counts as an `"image"` in this context
  by editing your `~/.gitattributes` file; mine looks like:
  ```
  *.png diff=image
  *.gif diff=image
  *.jpg diff=image
  *.jpeg diff=image
  ```
