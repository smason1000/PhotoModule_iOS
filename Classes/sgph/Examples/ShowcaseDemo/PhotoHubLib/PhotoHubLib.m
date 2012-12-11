#import "PhotoHubLib.h"

@implementation PhotoHubLib

@synthesize mainViewController;
@synthesize pSingleton;

- (void) initAll
{
    NSLog(@"[PhotoHubLib] initAll");

    gSingleton = [MySingleton sharedSingleton];
    gSingleton.isModule = YES;
    pSingleton = gSingleton;
    
    //self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // Override point for customization after application launch.
    
    mainViewController = [[MainViewController alloc] init];
    
    /*
    SampleViewController *avcHolderViewController = [[SampleViewController alloc] init];
    mainViewController.avcHolderViewController = avcHolderViewController;
    
    SampleViewController *ptHolderViewController = [[SampleViewController alloc] init];
    mainViewController.ptHolderViewController = ptHolderViewController;
    
    SampleViewController *rvHolderViewController = [[SampleViewController alloc] init];
    mainViewController.rvHolderViewController = rvHolderViewController;
    
    SampleNavigationController *navViewController = [[SampleNavigationController alloc] init];
    mainViewController.navViewController = navViewController;
    
    SampleNavigationController *headerViewController = [[SampleNavigationController alloc] init];
    mainViewController.headerViewController = headerViewController;
    
    SampleNavigationController *ssHolderViewController = [[SampleNavigationController alloc] init];
    mainViewController.ssHolderViewController = ssHolderViewController;
    
    SampleNavigationController *togHolderViewController = [[SampleNavigationController alloc] init];
    mainViewController.togHolderViewController = togHolderViewController;
    */
    
    //[self.window setRootViewController:mainViewController];

    ////////
    
    /*
     * Optional: do some disk caching (don't exaggerate though, because this
     * isn't data persistence): less network requests so that content ideally
     * is always there.
     */
    
    // Nimbus implements its own in-memory cache for network images. Because of
    // this we don't allocate any memory for NSURLCache.
    static const NSUInteger kMemoryCapacity = 0;
    static const NSUInteger kDiskCapacity = 1024*1024*50; // 50MB disk cache
    SDURLCache *urlCache = [[SDURLCache alloc] initWithMemoryCapacity:kMemoryCapacity
                                                         diskCapacity:kDiskCapacity
                                                             diskPath:[SDURLCache defaultCachePath]];
    [NSURLCache setSharedURLCache:urlCache];
    
    ////
    
    //[self.window makeKeyAndVisible];
}

-(void)shutdown
{
    NSLog(@"[PhotoHubLib] shutdown");
    [mainViewController.view removeFromSuperview];
    [mainViewController shutdown];
    [gSingleton shutdown];
    pSingleton = nil;
    mainViewController = nil;
}
@end
