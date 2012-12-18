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
    NSArray* _bbarItems;
    NSArray* _headerItems;
}

@property (strong, nonatomic) UILabel* titleLabel;
@property (strong, nonatomic) UILabel* titleCurrentLabel;
@property (strong, nonatomic) UILabel* titleExpandedLabel;
@property (strong, nonatomic) UILabel* titleExpandedCount;

@property (strong, nonatomic) UIView *avcHolderView;
@property (strong, nonatomic) UIView *ptHolderView;
@property (strong, nonatomic) UIView *ssHolderView;
@property (strong, nonatomic) UIView *togHolderView;
@property (strong, nonatomic) UIView *rvHolderView;
@property (strong, nonatomic) UIView *navView;
@property (strong, nonatomic) UIView *headerView;
@property (strong, nonatomic) UIView *detailView;
@property (strong, nonatomic) UIView *expandedLabelView;

@property (strong, nonatomic) SampleNavigationController *navViewController;
@property (strong, nonatomic) SampleNavigationController *headerViewController;
@property (strong, nonatomic) SampleNavigationController *ssHolderViewController;
@property (strong, nonatomic) SampleNavigationController *togHolderViewController;

@property (strong, nonatomic) PTDemoViewController *ptController;
@property (strong, nonatomic) AVCamViewController *avcController;
@property (strong, nonatomic) RootViewController *rvController;
@property (strong, nonatomic) PTImageDetailViewController *detailViewController;

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
@property (strong, nonatomic) UIBarButtonItem *expandedLabItem;

@property (strong, nonatomic) UIBarButtonItem *delItem;

@property (strong, nonatomic) UIBarButtonItem *reqCountItem;

@property (strong, nonatomic) UIActionSheet *actionSheet;

@property (nonatomic) BOOL hudHidden;

@property (strong, nonatomic) NSArray* bbarItems;
@property (strong, nonatomic) NSArray* headerItems;

@property (strong, nonatomic) NSTimer *myTimer;

- (void) updateButtonLabels;
- (void) updateStatusBarLabel:(NSObject *)anObject;
- (void) layoutForOrientation:(UIInterfaceOrientation)orientation andRect:(CGRect)frameRect;
- (void) setBoundsAndLayout:(CGRect)frameRect;

@end