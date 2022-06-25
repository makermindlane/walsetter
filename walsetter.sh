#!/usr/bin/zsh

file_path=$1

# Get filename without extension
filename=$(basename $file_path | sed 's/\(.*\)\..*/\1/')

# Get directory
#dir_loc=$(dirname $file_path)

# Check if file exists or not
if [ ! -f "$file_path" ]; then
	echo "$file_path does not exist"
	exit 1
else
	echo "$file_path found."
fi

# Call pywal to generate color schemes
wal -i $file_path

# Set wallpaper and lockscreen
~/.local/src/walsetter/ksetwallpaper.py -l -f $file_path

# Move color scheme file to .local/share/color-schemes
~/.local/src/walsetter/move-colors-kde.sh $filename

# Apply new color scheme
plasma-apply-colorscheme $filename

