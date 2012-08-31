// Ensure that the module development guide module is loaded		
var DevGuide = require('com.phmod');

/*
require('demos/proxyDemo');
require('demos/viewproxyDemo');
require('demos/krollPropertiesDemo');
require('demos/krollMethodsDemo');
require('demos/krollParametersDemo');
require('demos/krollCallbacksAndEventsDemo');
require('demos/assetsDemo');
require('demos/constantsDemo');
*/

//required else compile wont detect used functions
(function() { var used = [ 

	DevGuide.createLifeCycle,
	DevGuide.createDemoView,
	DevGuide.createKrollDemo,
	DevGuide.createMethodsDemo,
	DevGuide.createParametersDemo,
	DevGuide.createMethodsDemo,
	DevGuide.createMethodsDemo,
	DevGuide.createMethodsDemo,
	DevGuide.createMethodsDemo

 ]; })();

// Open the main category selection page
require('navigator').start(DevGuide);