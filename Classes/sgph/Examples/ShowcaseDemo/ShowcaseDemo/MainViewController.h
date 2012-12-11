#import <UIKit/UIKit.h>
#import "SampleViewController.h"
#import "SampleNavigationController.h"
#import "PTImageDetailViewController.h"
#import "PTShowcaseViewDelegate.h"
#import "PTShowcaseViewDataSource.h"
#import "PTShowcaseView.h"

@class PTDemoViewController;
@class AVCamViewController;
@class RootViewController;
@class PTImageDetailViewController;

@interface MainViewController : UIViewController <UIActionSheetDelegate> { //<PTShowcaseViewDelegate, PTShowcaseViewDataSource>
    CGRect fBounds;
    NSArray* bbarItems;
    NSArray* headerItems;
    NSTimer *myTimer;
    NSTimer *refTimer;
}

@property (strong, nonatomic) UILabel* titleLabel;

@property (strong, nonatomic) UIView *avcHolderView;
@property (strong, nonatomic) UIView *ptHolderView;
@property (strong, nonatomic) UIView *ssHolderView;
@property (strong, nonatomic) UIView *togHolderView;
@property (strong, nonatomic) UIView *rvHolderView;
@property (strong, nonatomic) UIView *navView;
@property (strong, nonatomic) UIView *headerView;

//@property (strong, nonatomic) SampleViewController *avcHolderViewController;
//@property (strong, nonatomic) SampleViewController *ptHolderViewController;
//@property (strong, nonatomic) SampleViewController *rvHolderViewController;
@property (strong, nonatomic) SampleNavigationController *navViewController;
@property (strong, nonatomic) SampleNavigationController *headerViewController;
@property (strong, nonatomic) SampleNavigationController *ssHolderViewController;
@property (strong, nonatomic) SampleNavigationController *togHolderViewController;

@property (strong, nonatomic) PTDemoViewController *ptController;
@property (strong, nonatomic) AVCamViewController *avcController;
@property (strong, nonatomic) RootViewController *rvController;
//@property (strong, nonatomic) PTImageDetailViewController *ssController;


@property (strong, nonatomic) UIBarButtonItem *toggleFilterItem;
@property (strong, nonatomic) UIBarButtonItem *toggleFilterItem2;
@property (strong, nonatomic) UIBarButtonItem *cameraItem;
@property (strong, nonatomic) UIBarButtonItem *snapPhotoItem;
@property (strong, nonatomic) UIBarButtonItem *galleryItem;
@property (strong, nonatomic) UIBarButtonItem *expandItem;
@property (strong, nonatomic) UIBarButtonItem *filterItem;
@property (strong, nonatomic) UIBarButtonItem *editItem;
@property (strong, nonatomic) UIBarButtonItem *hudItem;
@property (strong, nonatomic) UIBarButtonItem *labItem;
@property (strong, nonatomic) UIBarButtonItem *curLabItem;

@property (strong, nonatomic) UIBarButtonItem *delItem;

@property (strong, nonatomic) UIBarButtonItem *reqCountItem;
@property (strong, nonatomic) UIBarButtonItem *labCountItem;
@property (strong, nonatomic) UIBarButtonItem *totCountItem;
@property (strong, nonatomic) UIBarButtonItem *nreqCountItem;
@property (strong, nonatomic) UIBarButtonItem *nlabCountItem;
@property (strong, nonatomic) UIBarButtonItem *ntotCountItem;

@property (strong, nonatomic) UIActionSheet *actionSheet;

@property (nonatomic) CGRect fBounds;
@property (nonatomic) BOOL hudHidden;

@property (strong, nonatomic) NSArray* bbarItems;
@property (strong, nonatomic) NSArray* headerItems;

//@property (strong, nonatomic) UIWindow *window;

- (void) updateButtonLabels;
- (void) updateStatusBarLabel:(NSObject *)anObject;
- (void) layoutForOrientation:(UIInterfaceOrientation)orientation;
- (void) setBoundsAndLayout:(CGRect)frameRect;
- (void) shutdown;

@end

/*
 -(void)eventHandlerExpandOn: (NSNotification *) notification
 {
 
 
 PTImageDetailViewController *detailViewController = [[PTImageDetailViewController alloc] initWithImageAtIndex:gSingleton.relativeIndex];
 detailViewController.data = self.showcaseView.imageItems;
 detailViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
 
 
 //[detailViewController.navigationItem setLeftBarButtonItem:
 // [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
 //                                               target:self
 //                                               action:@selector(dismissImageDetailViewController)]];
 
 
 UINavigationController *navCtrl = [[UINavigationController alloc] initWithRootViewController:detailViewController];
 
 
 // TODO zoom in/out (just like in Photos.app in the iPad)
 
 [self presentViewController:navCtrl animated:YES completion:NULL];
 
 
 
 }
 
 -(void)eventHandlerExpandOff: (NSNotification *) notification
 {
 [self dismissImageDetailViewController];
 }
 */