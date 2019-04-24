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
- only test in latest Emacs 26.1, 26.2


## Usage:

### clone files

``` bash
mkdir xxx
git clone https://github.com/chenfengrugao/emacs.git
git submodule init
git submodule update
```

### settings

#### Linux

- add xxx/emacs/bin to your $PATH
- make soft link `ln xxx/emacs/elisp ~/elisp`
- merge xxx/emacs/.emacs to yours local emacs init file

#### Windows

Note that, In Windows7, `~` stands for `C:/Users/xxx/AppData/Roaming`,  
so, you should copy `xxx/emacs/elisp` to `C:/Users/xxx/AppDate/Roaming/elisp`.


## Update History

- 03/25/2019
  - use git submodule to manage third-party libs. So, we can update third-paty libs use `git submodule update`.
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

