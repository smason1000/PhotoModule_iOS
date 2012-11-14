#import "NetworkPhotoAlbumViewController.h"

#import "PTImageAlbumViewDataSource.h"

@class PTImageAlbumView;

@interface PTImageAlbumViewController : NetworkPhotoAlbumViewController <PTImageAlbumViewDataSource>

@property (nonatomic, strong) PTImageAlbumView *imageAlbumView;

- (id)initWithImageAtIndex:(NSInteger)index;

@end
