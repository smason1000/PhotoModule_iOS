#import <Foundation/Foundation.h>

#import "PhotoHubLib.h"

@class ComPhmodSingleton;
extern ComPhmodSingleton *mSingleton;


@interface ComPhmodSingleton : NSObject {
    PhotoHubLib *myPhotoHubLib;
    MySingleton *myPHS;
}

@property (nonatomic, retain) PhotoHubLib *myPhotoHubLib;
@property (nonatomic, retain) MySingleton *myPHS;
@property (nonatomic) BOOL showTrace;

+ (id)sharedSingleton;

@end