#import "PTImageDetailViewController.h"
#import "Photo.h"

@implementation PTImageDetailViewController

@synthesize data = _data;

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

-(void)dealloc
{
    NSLog(@"[PTImageDetailViewController] dealloc");
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    NSLog(@"PTImageDetailViewController viewDidLoad");

    [super viewDidLoad];

    self.view.frame = CGRectMake(0, 88, 320, 328);
    self.view.bounds = CGRectMake(0, 0, 320, 328);
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    
    self.data = nil;
    NSLog(@"PTImageDetailViewController viewDidUnload");
}

#pragma mark - PTImageAlbumViewDataSource

- (NSInteger)numberOfImagesInAlbumView:(PTImageAlbumView *)imageAlbumView
{
    return [self.data count];
}

- (CGSize)imageAlbumView:(PTImageAlbumView *)imageAlbumView sizeForImageAtIndex:(NSInteger)index
{
    Photo *photo = (Photo *)[self.data objectAtIndex:index];
    return [[UIImage imageWithContentsOfFile:[photo photoPath]] size];
}

- (UIImage *)imageAlbumView:(PTImageAlbumView *)imageAlbumView imageAtIndex:(NSInteger)index
{
    //NSLog(@"CURRENT INDEX: %d", index);
    
    Photo *photo = (Photo *)[self.data objectAtIndex:index];
    return [UIImage imageWithContentsOfFile:[photo photoPath]];
}

- (NSString *)imageAlbumView:(PTImageAlbumView *)imageAlbumView sourceForThumbnailImageAtIndex:(NSInteger)index
{
    Photo *photo = (Photo *)[self.data objectAtIndex:index];
    return [photo thumbPath];
}

@end
