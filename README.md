# BotKit
BotKit is a Cocoa Touch static library for use in iOS projects. It includes a number of helpful classes and categories that are useful during the development of an iOS application.

## Installation

The fastest way to get started with BotKit in your project is by adding it as a git submodule. 

### Clone the library into your app's directory tree.

	$ cd YourProject
	$ git submodule add git@github.com:thoughtbot/botkit.git

### Add `BotKit.xcodeproj` to your project.

### Configure your app's target to build BotKit.

* Open your project's target settings.
* Select the 'Build Phases' tab.
* Expand the 'Target Dependencies' section and click the '+' button.
* Select 'BotKit' and click 'Add'.

### Configure your app's target to link to BotKit.

* Ensure that the 'Build Phases' tab is still selected.
* Expand the 'Link Binary with Libraries' section and click the '+' button.
* Select 'libBotKit.a' and click 'Add'.  
	
### Import BotKit wherever it is needed.  

* `#import <BotKit/BotKit.h>`
	
**Note**: When cloning a project that includes BotKit as a git submodule, you must initialize and update the submodule before it can be built properly.

	$ git submodule init
	$ git submodule update
	
## Updating
To update the BotKit submodule when there are upstream changes, perform this command from within your project's directory.

	$ git submodule foreach git pull --rebase

## Credits  

![thoughtbot](http://thoughtbot.com/images/tm/logo.png)

BotKit is maintained by [thoughtbot, inc](http://thoughtbot.com/community)
The names and logos for thoughtbot are trademarks of thoughtbot, inc.

BotKit is © 2012 thoughtbot, inc. It is distributed under the [Creative Commons
Attribution License](http://creativecommons.org/licenses/by/3.0/).