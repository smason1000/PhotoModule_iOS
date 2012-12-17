#import <UIKit/UIKit.h>
#import "MySingleton.h"
#import "TestViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    TestViewController *testViewController;
}

@property (nonatomic, strong) TestViewController *testViewController;

void onUncaughtException(NSException *exception);

@end
