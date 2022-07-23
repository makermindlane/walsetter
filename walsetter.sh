#!/usr/bin/zsh

file_path=$1

# Light theme or dark theme option
option=$2

# Check if file exists or not
if [ ! -f "$file_path" ]; then
	echo "$file_path does not exist"
	exit 1
fi

# Get the absolute file path
abs_file_path=`realpath $file_path`

# Get filename without extension
# (I've no idea how the `sed` cmd is working :/)
filename=$(basename $file_path | sed 's/\(.*\)\..*/\1/')

# Set wallpaper and lockscreen
echo "Setting wallpaper and lockscreen..."
~/.local/src/walsetter/ksetwallpaper.py -l -f $abs_file_path

if [ "$option" = "l" ]; then
	# Call pywal to generate light color schemes
	echo "Generating light theme ..."
	wal -l -i $abs_file_path

	filename=$filename-light
else
	# Call pywal to generate dark color schemes
	echo "Generating dark theme ..."
	wal -i $abs_file_path

	filename=$filename-dark
fi
	echo "Applying $filename color scheme..."

	# Move color scheme file to .local/share/color-schemes
	~/.local/src/walsetter/move-colors-kde.sh $filename

	plasma-apply-desktoptheme default
	plasma-apply-colorscheme $filename

# Setting sddm background
#echo "Applying sddm backgroung..."
#echo "[General]
#background=$file_path
#type=image" > /usr/share/sddm/themes/breeze/theme.conf.usr
