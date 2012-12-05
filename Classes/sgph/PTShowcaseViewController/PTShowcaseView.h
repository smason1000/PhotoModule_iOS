#import "GMGridView.h"

#import "PTShowcase.h"

@protocol PTShowcaseViewDelegate;
@protocol PTShowcaseViewDataSource;

@interface PTShowcaseView : GMGridView
{
    NSTimer *myTimer;
}

@property (nonatomic, weak) id<PTShowcaseViewDelegate> showcaseDelegate;
@property (nonatomic, weak) id<PTShowcaseViewDataSource> showcaseDataSource;

@property (nonatomic, strong, readonly) NSString *uniqueName;

@property (weak, nonatomic, readonly) NSArray *imageItems;

- (id)initWithUniqueName:(NSString *)uniqueName;

- (NSInteger)numberOfItems;

- (PTContentType)contentTypeForItemAtIndex:(NSInteger)index;
- (PTItemOrientation)orientationForItemAtIndex:(NSInteger)index;

- (NSString *)pathForItemAtIndex:(NSInteger)index;

- (NSString *)uniqueNameForItemAtIndex:(NSInteger)index;
- (NSString *)sourceForThumbnailImageOfItemAtIndex:(NSInteger)index;
- (NSString *)textForItemAtIndex:(NSInteger)index;

- (void)reloadData;

@end
