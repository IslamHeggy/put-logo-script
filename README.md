# Put-Logo-Script

This simple script is made to help the Artwork team in OSC to put OSC's logo on more than one picture after the events automatically without having to do them one by one.

# Dependancies

This script uses Imagemagick and Zenity (for the GUI only).

You can install them by running the following commands:

## Ubuntu and its Derivatives (Linux Mint, Elementary OS, etc..)
```
$ sudo apt update && sudo apt install imagemagick zenity
```

## Arch and its Derivatives (Antergos, Manjaro, etc..)
```
$ sudo pacman -Sy imagemagick zenity
```


# How to use


## From the GUI
* Execute the script
```
	$ ./PutlogoGUI.sh
```

   Or just double click on the file.

* Follow the on-screen dialogs to get your logo put on the pictures.

## From the CLI
* Execute the script
```
	$ ./Putlogo
```

Or you can pass arguments to the script

```
	$ ./Putlogo <Logo Path> <Pictures Directory> <Corner> <Size>
```

* Input the logo's Path and name
```
	$ /home/Pictures/logo.png
	or
	$ ../../Pictures/logo.png
```

* Input the photos containing folder's path
```
	$ /home/Pictures/
	or
	$ ../../Pictures/
```

### Note:
#### Do not use a folder or a file that has a path containing a space. This also applies to the GUI.

# ToDo
* [X] Fix a bug which makes the script works on landscape pictures only.
* [X] Edit the script to allow the execution of the script from any directory not the directory of pics.
* [X] resize the logo to fit every image.
* [X] Solve problem with auto rotate from photos taken by digital cameras.
* [X] Solve a problem with paths and files which folder that contains a space in their name.
* [X] Make it usable as Shell Command and to take arguments also
* [ ] Solve a Problem with selfies 
