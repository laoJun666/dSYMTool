#!/bin/bash

:<<eof

You can refer this one too, I have written step by step procedure of Manual Crash Re-Symbolication.

Crash Re-Symbolication

STEP 1

Move all the above files (MyApp.app, MyApp-dSYM.dSYM and MyApp-Crash-log.crash) into a Folder with a convenient name wherever you can go using Terminal easily.

For me, Desktop is the most easily reachable place ;) So, I have moved these three files into a folder MyApp at Desktop.

STEP 2

Now its turn of Finder, Go to the path from following whichever is applicable for your XCODE version.

Xcode 8, Xcode 9 /Applications/Xcode.app/Contents/SharedFrameworks/DVTFoundation.framework/Versions/A/Resources/symbolicatecrash

Xcode 7.3 /Applications/Xcode.app/Contents/SharedFrameworks/DVTFoundation.framework/Versions/A/Resources/symbolicatecrash

XCode 7 /Applications/Xcode.app/Contents/SharedFrameworks/DTDeviceKitBase.framework/Versions/A/Resources/symbolicatecrash

Xcode 6 /Applications/Xcode.app/Contents/SharedFrameworks/DTDeviceKitBase.framework/Versions/A/Resources

Lower then Xcode 6 Contents/Developer/Platforms/iPhoneOS.platform/Developer/Library/PrivateFrameworks/DTDeviceKitBase.framework/Versions/A/Resources

Or Contents/Developer/Platforms/iPhoneOS.platform/Developer/Library/PrivateFrameworks/DTDeviceKit.framework/Versions/A/Resources

Copy symbolicatecrash file from this location, and paste it to the Desktop/MyApp (Wait… Don’t blindly follow me, I am pasting sybolicatecrash file in folder MyApp, one that you created in step one at your favorite location, having three files.)

STEP 3

Open Terminal, and CD to the MyApp Folder.

cd Desktop/MyApp — Press Enter
export DEVELOPER_DIR=$(xcode-select --print-path)
 — Press Enter

./symbolicatecrash -v MyApp-Crash-log.crash MyApp.dSYM
 — Press Enter

That’s it !! Symbolicated logs are on your terminal… now what are you waiting for? Now simply, Find out the Error and resolve it ;)

Happy Coding !!!

eof

#这里的位置 适用于 Xcode8、9 其他版本查看上面注释
symbolicatecrash_path='/Applications/Xcode.app/Contents/SharedFrameworks/DVTFoundation.framework/Versions/A/Resources/symbolicatecrash'

if [ ! -f $symbolicatecrash_path ];then
	echo "$symbolicatecrash_path "
	echo "<-file not found"
	echo "请检查 symbolicatecrash 文件目录是否正确"
	exit 1
fi

#step 1 
exceStr="cp $symbolicatecrash_path  ."
echo "执行->:"  $exceStr
$exceStr

#step 2
if [ ! -f *.crash ]; then
	#statements
	echo 'not found .crash'
	echo '请将 .crash 文件复制到当前文件夹'
	exit 1
fi

if [ ! -e *.dSYM ]; then
	#statements
	echo 'not found .dSYM'
	echo '请将 .dSYM 文件复制到当前文件夹'
	exit 1
fi

export DEVELOPER_DIR=$(xcode-select --print-path)
echo "DEVELOPER_DIR < $DEVELOPER_DIR >"


exceStr="./symbolicatecrash -v *.crash  *.dSYM >> Symbolicated.crash"
echo "执行->:"  $exceStr 
$exceStr > Symbolicated.crash

