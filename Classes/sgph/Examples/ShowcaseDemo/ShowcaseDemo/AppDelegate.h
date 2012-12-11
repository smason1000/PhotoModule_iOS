#import <UIKit/UIKit.h>
#import "MySingleton.h"
#import "MainViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    MainViewController *mainViewController;
}

@property (nonatomic, strong) MainViewController *mainViewController;

void onUncaughtException(NSException *exception);

@end
