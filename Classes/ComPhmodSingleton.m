#import "ComPhmodSingleton.h"


ComPhmodSingleton *mSingleton = nil;

@implementation ComPhmodSingleton

@synthesize myPhotoHubLib;
@synthesize myPHS;
@synthesize showTrace;

/*
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
*/

- (id)init
{
    if (self = [super init])
    {
        showTrace = YES;
    }
    return self;
}

-(void)startup
{
    myPhotoHubLib = [[PhotoHubLib alloc] init];
    
    [myPhotoHubLib initAll];
    
    myPHS = myPhotoHubLib.pSingleton;
}
-(void)shutdown
{
    [myPhotoHubLib shutdown];
    myPhotoHubLib = nil;
    myPHS = nil;
}
- (void)dealloc
{
    // Should never be called, but just here for clarity really.
}

@end