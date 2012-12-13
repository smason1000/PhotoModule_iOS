#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MySingleton.h"

#import "MainViewController.h"
#import "SampleViewController.h"
#import "PTShowcaseView.h"
//#import "SDURLCache.h"
#import "PTDemoViewController.h"
#import "AVCamViewController.h"
#import "RootViewController.h"

@interface PhotoHubLib : NSObject
{
    MainViewController* mainViewController;
    MySingleton* pSingleton;
}

@property (nonatomic, strong) MainViewController *mainViewController;
@property (nonatomic, strong) MySingleton* pSingleton;

- (void) initAll;
- (void) shutdown;

@end
