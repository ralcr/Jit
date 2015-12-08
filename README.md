# Jit
Jira and Git brought together, create and switch branches by knowing only the task id.
Jit connects to Jira to find the task title then formats it properly as a valid branch name.

![Screenshot](http://s18.postimg.org/vv7c6n8cp/jit.png)

### Commands
Only the most basic commands are implemented that deals with branch names.
Ex you have an issue with this details:
  
  task id: AA-55
  
  task title: [AA] - Blah blah blah

To create a local branch named "AA-55_Blah_blah_blah" for this task you'd do:

	jit branch aa55	

To switch branches you will type: 

	jit checkout aa55 // Case insensitive and no need to put the dash, jit will separate the chars from numbers with a dash
	or
	jit checkout blah // Switches to the first branch containing "blah"
	or
	jit co aa55 // Checkout is too long? There's even the "co" shortcut

Commiting to repo:

	jit commit <Some commit message> // As you can see, no need for "", jit knows that after commit follows the message
	jit ci <Some commit message> // The "ci" shortcut for commit
	jit magic <Some commit message> // Add files to stage, commits, then pushes to server

For a complete list of commands and details run

	jit

### Installing

Work on Mac only at this point.

 1. Download the executable from build directory then run

	sudo ./jit install

 2. Download the sources and compile yourself. To compile you need the Haxe compiler (http://haxe.org) and the hxcpp haxelib. Note that the cpp folder is added to .gitignore, please create it in the root before compiling. After you compile you still need to do step 1 if you want to call the app from anywhere
 	
	haxelib install hxcpp // Install the hxcpp dependency
	haxe compile.hxml // Compile the application
	cd build
	sudo ./jit install
	jit

### Other
Some of the commands need to connect to Jira, you need to run jit setup to configure it.

Some of the commands need a Mac because it uses AppleScript to tell osx to do stuffs

Password is stored in the Keychain app

### ToDo
1. Doesn't deal with errors very well, need to take into account errors everywhere
2. Store password differently on linux and windows
3. Disable functionality that needs AppleScript and you are on linux or windows
