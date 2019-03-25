# emacs

## Description

emacs configration file mainly for verilog(sv, uvm), c, matlab, chisel, web, etc.

Note:
- set font in .Xresources, it is faster than set in .emacs
- bin/depth  
  A Perl script to find project root directory by `root.txt`, so you should new a root.txt
- bin/ripgrep  
  use command `brew install ripgrep` to install if you are using MacOS
  [https://github.com/BurntSushi/ripgrep](https://github.com/BurntSushi/ripgrep)
- bin/emacsdiff  
  emacsdiff is a wrapper for ediff-files
- only test in latest Emacs 26.1


## Usage:

- add bin to your $PATH
- copy all files to your HOME: `~/` , please backup your own first
- merge .emacs to yours


## Update History

- 03/25/2018
  - use git submodule to manage third-party libs.
  - add buffer-move from https://github.com/lukhas/buffer-move
  - update markdown-mode to v2.4 from https://github.com/jrblevin/markdown-mode
- 12/12/2018
  - add resize/select window using the keyboard
  - add markdown-mode
- 12/03/2018
  - add Scala mode for chisel
  - enable split-window-horizontally of ediff-files as default
- 11/12/2018 Update verilog-mode from https://www.veripool.org/ftp/verilog-mode-2018-10-20-87b2f58-vpo.el.gz
- 11/12/2018 Update matlab-mode from https://git.code.sf.net/p/matlab-emacs/src matlab-emacs-src



