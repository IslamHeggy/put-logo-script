#!/bin/bash

#This script helps u to put a logo on pictures using imagemagick.

#Checks that imagemagick is installed.
if [[ $(composite --version) == "" ]] 
then
	echo "You don't have imagemagick installed, please install it before trying to run this script."
	exit
fi
XDVersion=$(Xdialog --version 2>&1)
if [[ $XDVersion == "" ]]
then
	echo "Xdialog isn't installed, please install it before trying to run this script."
    exit
fi
#Logo path
if [[ "$1" == "" ]]
then
    while [[ 1 ]]
    do
        flogoname=`Xdialog --title "Please choose the file for the logo" --fselect /home/$USER/ 0 0 2>&1`;
        case $? in
                0)
                    if [ -d $flogoname ]
                    then 
                        echo "Choose a file, not a directory."
                        continue;
                    fi
                    echo "$flogoname chosen as logo."
                    break;;
                1)
                    echo "Cancel pressed, please choose a logo.";;
                255)
                    echo "Box closed."
                    exit;;
        esac
    done
else
    flogoname="$1";
fi 

#Photos path
if [[ "$2" == "" ]]
then
    while [[ 1 ]]
    do
        picsPath=`Xdialog --title "Please choose the directory for the pics." --dselect /home/$USER/ 0 0 2>&1`;
        case $? in
                0)
                    picsPath=$picsPath"/"
                    echo "$picsPath chosen as directory for pics."
                    break;;
                1)
                    echo "Cancel pressed, please choose a directory.";;
                255)
                    echo "Box closed."
                    exit;;
        esac
    done
    

else
    picsPath="$2";
fi

#Logo position
if [[ "$3" == "" ]]
then
    while [[ 1 ]]
    do
        corner=$(Xdialog --title "Logo Position" \
            --radiolist "Choose the corner for the logo" 17 46 4 \
            "1" "Top Right" ON \
            "2" "Top Left" off \
            "3" "Bottom Right" off \
            "4" "Bottom Left" off 2>&1)
        
        if [[ $corner == "" ]]
        then
            exit
        else
            echo "The chosen corner is: $corner"
            break
        fi
    done
else
    corner="$3";
fi

#Logo size
if [[ "$4" == "" ]]
then
    while [[ 1 ]]
    do
        size=$(Xdialog 2>&1 --title "Logo Size" \
            --rangebox "Choose the size of the logo" 10 40 1 100 20)
        echo $size
        if [[ $size == "" ]]
        then
            exit
        else
            echo "The chosen size is: $size%"
            break
        fi
    done
else
    size=$4;
fi

#Output is where the results is going to be generated
if [ ! -d "Output" ]
then
    mkdir Output
fi

#An array containing the options for imagemagick to be able to pass them.
e=(NorthEast NorthWest SouthEast SouthWest);



for h in  "$picsPath"*.*
	do
		if [[ ! -d "$h" ]]
		then
			#differentiate between portrait and landscape photos taken by digital cameras with EXIF in it
			convert "$h" -auto-orient "$h" 
		
			#getting the each photo's width
			pwidth=$(convert "$h" -print "%w %h\\n" /dev/null);
			pwidth=$(echo "$pwidth" | cut -d ' ' -s -f2);
		
			#getting the file extinsion
			ext='.';
			ext+="echo $flogoname | rev | cut -d '.' -s -f1 |rev";
		
			#the new resulting photo's postion
			slogoname="Output/$(basename "$flogoname" "$ext").png"
	
			#make the logo's width and height a precentage of the photo's width 
			z=$((pwidth*size/100));
			float=$z;
			float+="x";
			float+=$z;
		
			#resizing the logo to fit the photo
			convert -background none "$flogoname" -resize "$float" "$slogoname" ;
			
			i=$(echo "$h" |rev| cut -d / -s -f 1|rev);
			echo " Processing " "$i"
			#putting the logo on the photo
			composite -background none -gravity "${e[(($corner-1))]}" "$slogoname" "$h" ./Output/"$i" 
		fi
	done

echo "You are done, thank you!"
