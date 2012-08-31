#import <Foundation/Foundation.h>

#import "PTShowcase.h"

@class PTShowcaseView;

@protocol PTShowcaseViewDelegate <NSObject>

@optional
- (PTItemOrientation)showcaseView:(PTShowcaseView *)showcaseView orientationForItemAtIndex:(NSInteger)index;

@end
