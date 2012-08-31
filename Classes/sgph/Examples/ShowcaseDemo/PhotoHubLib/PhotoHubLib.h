#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MySingleton.h"

#import "MainViewController.h"
#import "SampleViewController.h"
#import "PTShowcaseView.h"
#import "SDURLCache.h"
#import "PTDemoViewController.h"
#import "AVCamViewController.h"
#import "RootViewController.h"

@interface PhotoHubLib : NSObject {
    MainViewController *mainViewController;
    MySingleton* pSingleton;
}

@property (nonatomic, retain) MainViewController *mainViewController;
@property (nonatomic, retain) MySingleton* pSingleton;

- (void) initAll;

@end
