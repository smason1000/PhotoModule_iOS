#import <Foundation/Foundation.h>

#import "PTShowcase.h"

@class PTShowcaseView;

@protocol PTShowcaseViewDataSource <NSObject>

@required
- (NSInteger)numberOfItemsInShowcaseView:(PTShowcaseView *)showcaseView;
- (PTContentType)showcaseView:(PTShowcaseView *)showcaseView contentTypeForItemAtIndex:(NSInteger)index;
- (NSString *)showcaseView:(PTShowcaseView *)showcaseView pathForItemAtIndex:(NSInteger)index;

@optional
- (NSString *)showcaseView:(PTShowcaseView *)showcaseView uniqueNameForItemAtIndex:(NSInteger)index;
- (NSString *)showcaseView:(PTShowcaseView *)showcaseView sourceForThumbnailImageOfItemAtIndex:(NSInteger)index;
- (NSString *)showcaseView:(PTShowcaseView *)showcaseView textForItemAtIndex:(NSInteger)index;

@end
