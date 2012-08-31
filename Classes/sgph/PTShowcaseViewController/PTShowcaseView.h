#import "GMGridView.h"

#import "PTShowcase.h"

@protocol PTShowcaseViewDelegate;
@protocol PTShowcaseViewDataSource;

@interface PTShowcaseView : GMGridView {
    NSTimer *myTimer;
}

@property (nonatomic, assign) id<PTShowcaseViewDelegate> showcaseDelegate;
@property (nonatomic, assign) id<PTShowcaseViewDataSource> showcaseDataSource;

@property (nonatomic, retain, readonly) NSString *uniqueName;

@property (nonatomic, readonly) NSArray *imageItems;

- (id)initWithUniqueName:(NSString *)uniqueName;

- (NSInteger)numberOfItems;

- (PTContentType)contentTypeForItemAtIndex:(NSInteger)index;
- (PTItemOrientation)orientationForItemAtIndex:(NSInteger)index;

- (NSString *)pathForItemAtIndex:(NSInteger)index;

- (NSString *)uniqueNameForItemAtIndex:(NSInteger)index;
- (NSString *)sourceForThumbnailImageOfItemAtIndex:(NSInteger)index;
- (NSString *)textForItemAtIndex:(NSInteger)index;

- (NSInteger)relativeIndexForItemAtIndex:(NSInteger)index withContentType:(PTContentType)contentType;

- (void)reloadData;

@end
