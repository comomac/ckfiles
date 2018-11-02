ckfiles
==========================
General file integrity checker, can check recursively. Support SFV, MD5, ZIP, CBZ, 7Z, GZ, BZ2, LHA, LZH, ARJ, CHM, XZ, RAR, CBR and media file containing CRC32 sum in filename with extension with AVI, MKV, MP4, OGM, ASF, RM, RAM, WEBM. Require 7zip and Unrar for checking archive file. Supports Linux / Mac OS X / Windows.  
  
Example filename:  Big Bunny [c001beef].avi

#### Installation: ####
Linux:
1. sudo apt-get install ruby1.9.1-full ruby1.9.1-dev p7zip-full p7zip-rar
2. sudo gem install ckfiles

Mac OS X:
1. Install [MacPorts](http://www.macports.org)
2. sudo port install ruby20 rb-rubygems p7zip
3. sudo gem install ckfiles

Windows: (NTFS Only)
1. Install Ruby v2.* from [RubyInstaller](http://rubyinstaller.org)
2. Install Development Kit for v2.0 from same site as above
2. gem install ckfiles
3. Download and install 7z from [7-Zip](http://www.7-zip.org), copy 7z.exe and 7z.dll to bin path (e.g. C:\Ruby200\bin )

All OS:
Download and install [WinRAR/unrar](http://rarlab.com), copy unrar(.exe) to bin path

#### Caveat/Notes: ####
This program uses filesystem's extended attributes, if the filesystem doesn't support the extended attribute or isn't enabled, then you can only use the read only function. This also applies to any network drive.

#### Usage: ####
ckfiles \[arguments\] \[directory\] \<directory2\> \<directory3\>

#### Arguments: ####
	--recursive  -r  Recursively check all files
	--noop       -n  Not moving corrupted files
	--read-only  -x  Read Only, do not write attribute (imply -n)
	--expiry     -e  Expiry time since last check, can be in seconds, or m/h/d/w/mo/y
	--outfile    -o  Output error to a file
	--help       -h  Display current help message
