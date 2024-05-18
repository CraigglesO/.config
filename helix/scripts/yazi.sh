#!/bin/zsh
# Declare and set a local variable
local tmpfile=/tmp/yazi-choice.txt

# Remove the temporary file if it exists
rm -f $tmpfile

# Call yazi with the chooser file option
yazi --chooser-file=$tmpfile

# Zellij actions
zellij action toggle-floating-panes
zellij action write 27 # send escape-key
zellij action write-chars ":open $(cat /tmp/yazi-choice.txt)"
zellij action write 13 # send enter-key
zellij action toggle-floating-panes
zellij action close-pane
