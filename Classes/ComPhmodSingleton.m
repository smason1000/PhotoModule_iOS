#import "ComPhmodSingleton.h"


ComPhmodSingleton *mSingleton = nil;

@implementation ComPhmodSingleton

@synthesize myPhotoHubLib = _myPhotoHubLib;
@synthesize myPHS = _myPHS;
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
    self.myPhotoHubLib = [[PhotoHubLib alloc] init];
    
    [self.myPhotoHubLib initAll];
    
    self.myPHS = self.myPhotoHubLib.pSingleton;
}
-(void)shutdown
{
    if (self.myPhotoHubLib != nil)
    {
        [self.myPhotoHubLib shutdown];
        self.myPhotoHubLib = nil;
        self.myPHS = nil;
    }
}

- (void)dealloc
{
    // Should never be called, but just here for clarity really.
}

@end