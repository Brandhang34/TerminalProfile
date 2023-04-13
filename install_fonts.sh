#!/bin/bash

# Fail on any command.
set -eux pipefail

# Linux
font_dir="$HOME/.local/share/fonts"
mkdir -p $font_dir

# Copy all fonts to user fonts directory
echo "Copying fonts..."
cp -r Terminal_Profile/fonts/hackfonts/* $font_dir

# Reset font cache on Linux
if which fc-cache >/dev/null 2>&1 ; then
    echo "Resetting font cache, this may take a moment..."
    fc-cache -f "$font_dir"
fi

echo "Hack fonts installed to $font_dir"
