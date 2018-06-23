# -*- coding: utf-8 -*-

import re
from xkeysnail.transform import *

# [Global modemap] Change modifier keys as in xmodmap
define_modmap({
    Key.CAPSLOCK: Key.LEFT_CTRL,
})

# mac os like
define_keymap(lambda wm_class: wm_class not in ("URxvt"), {
    K("M-a"): K("C-a"),
    K("M-z"): K("C-z"),
    K("M-x"): K("C-x"),
    K("M-c"): K("C-c"),
    K("M-v"): K("C-v"),
    K("M-w"): K("C-w"),
    K("M-t"): K("C-t"),
    K("M-r"): K("C-r"),
    K("M-p"): K("C-p"),
    K("M-f"): K("C-f"),
    K("M-Enter"): K("C-Enter"),
    K("M-Shift-Right_Brace"): K("C-Page_Down"),
    K("M-Shift-Left_Brace"): K("C-Page_Up")
}, "macos-like keys")

# vim like
define_keymap(lambda wm_class: wm_class not in (), {
    K("M-j"): K("Down"),
    K("M-k"): K("Up"),
    K("M-h"): K("Left"),
    K("M-l"): K("Right"),
}, "vim-like keys")

define_keymap(re.compile("Google-chrome"), {
    K("M-Shift-t"): K("C-Shift-t"),
}, "Chrome")

define_keymap(re.compile("URxvt"), {
    K("M-c"): K("C-M-c"),
    K("M-v"): K("C-M-v"),
}, "URxvt")

define_keymap(re.compile("slack"), {
    K("M-Up"): K("Ctrl-Up"),
}, "urxvt")
