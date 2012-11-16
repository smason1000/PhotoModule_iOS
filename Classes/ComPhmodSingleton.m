#import "ComPhmodSingleton.h"


ComPhmodSingleton *mSingleton = nil;

@implementation ComPhmodSingleton

@synthesize myPhotoHubLib;
@synthesize myPHS;
@synthesize showTrace;

#pragma mark Singleton Methods

+(id)sharedSingleton 
{
    static dispatch_once_t pred;
    static ComPhmodSingleton *shared = nil;
    
    dispatch_once(&pred, ^{
        shared = [[ComPhmodSingleton alloc] init];
    });
    return shared;
}


- (id)init
{
    if (self = [super init])
    {
        myPhotoHubLib = [[PhotoHubLib alloc] init];
        [myPhotoHubLib initAll];
        
        myPHS = myPhotoHubLib.pSingleton;
        showTrace = YES;
    }
    return self;
}

- (void)dealloc
{
    // Should never be called, but just here for clarity really.
}

@end