#import <AssetsLibrary/AssetsLibrary.h>

@protocol PTImageAlbumViewDataSource;

@interface PTImageAlbumView : NIPhotoAlbumScrollView

@property (nonatomic, weak) id<PTImageAlbumViewDataSource> imageAlbumDataSource;

- (NSInteger)numberOfImages;

- (CGSize)sizeForImageAtIndex:(NSInteger)index;

- (UIImage *)imageAtIndex:(NSInteger)index;
- (UIImage *)thumbnailImageAtIndex:(NSInteger)index;

- (NSString *)sourceForImageAtIndex:(NSInteger)index;
- (NSString *)sourceForThumbnailImageAtIndex:(NSInteger)index;

- (void)reloadData;

@end
