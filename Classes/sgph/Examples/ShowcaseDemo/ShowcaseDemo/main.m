#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "WorkOrder.h"

int main(int argc, char *argv[])
{
    @autoreleasepool
    {
        gSingleton = [[MySingleton alloc] init];
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
