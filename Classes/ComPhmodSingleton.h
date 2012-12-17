#import <Foundation/Foundation.h>

#import "PhotoHubLib.h"

@class ComPhmodSingleton;
extern ComPhmodSingleton *mSingleton;

@interface ComPhmodSingleton : NSObject
{
    PhotoHubLib *_myPhotoHubLib;
    MySingleton *_myPHS;
}

@property (nonatomic, strong) PhotoHubLib *myPhotoHubLib;
@property (nonatomic, strong) MySingleton *myPHS;
@property (nonatomic) BOOL showTrace;

//+ (id)sharedSingleton;
-(void)startup;
-(void)shutdown;

@end