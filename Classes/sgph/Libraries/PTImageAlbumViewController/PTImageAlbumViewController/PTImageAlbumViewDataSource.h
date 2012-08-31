#import <Foundation/Foundation.h>

@class PTImageAlbumView;

@protocol PTImageAlbumViewDataSource <NSObject>

@required
- (NSInteger)numberOfImagesInAlbumView:(PTImageAlbumView *)imageAlbumView;
- (CGSize)imageAlbumView:(PTImageAlbumView *)imageAlbumView sizeForImageAtIndex:(NSInteger)index;

@optional
- (UIImage *)imageAlbumView:(PTImageAlbumView *)imageAlbumView imageAtIndex:(NSInteger)index;
- (UIImage *)imageAlbumView:(PTImageAlbumView *)imageAlbumView thumbnailImageAtIndex:(NSInteger)index;

- (NSString *)imageAlbumView:(PTImageAlbumView *)imageAlbumView sourceForImageAtIndex:(NSInteger)index;
- (NSString *)imageAlbumView:(PTImageAlbumView *)imageAlbumView sourceForThumbnailImageAtIndex:(NSInteger)index;

@end
