# BotKit
---
BotKit is a Cocoa Touch static library for use in iOS projects. It includes a number of helpful classes and categories that are useful during the development of an iOS application.

## Installation
---
The fastest way to get started with BotKit in your project is by adding it as a git submodule. 

1. Simply clone the library into your app's directory tree.

		$ cd YourProject
		$ git submodule add git@github.com/thoughtbot/BotKit.git

2. Add `BotKit.xcodeproj` to your project.

3. Configure your app's target to build BotKit.

	* Open your project's target settings.
	* Select the 'Build Phases' tab.
	* Expand the 'Target Dependencies' section and click the '+' button.
	* Select 'BotKit' and click 'Add'.

4. Configure your app's target to link to BotKit.

	* Ensure that the 'Build Phases' tab is still selected.
	* Expand the 'Link Binary with Libraries' section and click the '+' button.
	* Select 'libBotKit.a' and click 'Add'.  
	
5. Configure your app's build settings to properly link to Objective-C files.

	* Select the 'Build Settings' tab in your project's target settings.
	* Find the 'Other Linker Flags' setting and add `-ObjC` and `-all_load`.  
	
6. Configure the app target to use the BotKit headers when building.

	* Ensure that the 'Build Settings' tab is still selected.
	* Find the 'Header Search Paths' setting and add `"$(TARGET_BUILD_DIR)/usr/local/lib/include"` and `"$(OBJROOT)/UninstalledProducts/include"`. Note the quotation marks, they are necessary.
	
7. Import BotKit wherever it is needed.

	* `#import <BotKit/BotKit.h>`
	
**Note**: When cloning a project that includes BotKit as a git submodule, you must initialize and update the submodule before it can be built properly.

	$ git submodule init
	$ git submodule update
	
## License
---
BotKit is Copyright &copy; 2012 Mark Adams and thoughtbot, inc.