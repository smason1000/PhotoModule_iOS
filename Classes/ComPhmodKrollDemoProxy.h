/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2011 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */

#import "ComPhmodLifeCycleProxy.h"

// NOTE: This proxy subclasses the ComPhmodLifeCycleProxy to demonstrate the
// lifecycle of a proxy. This would normally subclass TiProxy

@interface ComPhmodKrollDemoProxy : ComPhmodLifeCycleProxy <TiProxyDelegate>
{
@private
	// The JavaScript callbacks (KrollCallback objects)
	KrollCallback *successCallback;
	KrollCallback *cancelCallback;
	KrollCallback *requestDataCallback;
    //NSTimer* qTimer;
    //BOOL isQReady;
}

@end

