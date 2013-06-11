#import "MySingleton.h"
#import "MainViewController.h"
#import "AVCamViewController.h"
#import "RootViewController.h"
#import "PTDemoViewController.h"
#import "Photo.h"

@implementation MainViewController

@synthesize avcHolderView = _avcHolderView;
@synthesize ptHolderView = _ptHolderView;
@synthesize ssHolderView = _ssHolderView;
@synthesize togHolderView = _togHolderView;
@synthesize rvHolderView = _rvHolderView;
@synthesize navView = _navView;
@synthesize headerView = _headerView;
@synthesize detailView = _detailView;
@synthesize expandedLabelView = _expandedLabelView;

@synthesize navViewController = _navViewController;
@synthesize headerViewController = _headerViewController;
@synthesize ssHolderViewController = _ssHolderViewController;
@synthesize togHolderViewController = _togHolderViewController;
@synthesize detailViewController = _detailViewController;

@synthesize ptController = _ptController;
@synthesize avcController = _avcController;
@synthesize rvController = _rvController;

@synthesize titleLabel = _titleLabel;
@synthesize titleCurrentLabel = _titleCurrentLabel;
@synthesize titleExpandedLabel = _titleExpandedLabel;
@synthesize titleExpandedCount = _titleExpandedCount;

@synthesize labItem = _labItem;
@synthesize hudItem = _hudItem;
@synthesize hudHidden = _hudHidden;

@synthesize cameraItem = _cameraItem;
@synthesize snapPhotoItem = _snapPhotoItem;
@synthesize galleryItem = _galleryItem;
@synthesize expandItem = _expandItem;
@synthesize filterItem = _filterItem;
@synthesize toggleFilterItem = _toggleFilterItem;
@synthesize toggleFilterItem2 = _toggleFilterItem2;
@synthesize editItem = _editItem;
@synthesize curLabItem = _curLabItem;
@synthesize expandedLabItem = _expandedLabItem;

@synthesize reqCountItem = _reqCountItem;


@synthesize delItem = _delItem;

@synthesize headerItems = _headerItems;
@synthesize bbarItems = _bbarItems;
@synthesize myTimer = _myTimer;

@synthesize actionSheet = _actionSheet;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
        if (gSingleton.showTrace)
            NSLog(@"[MainViewController] initWithNibName");
        
        self.actionSheet = [[UIActionSheet alloc] initWithTitle:@"Filter By:"
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel"
                                         destructiveButtonTitle:nil
                                              otherButtonTitles:@"All Photos", @"All Labeled Photos", @"All Unlabeled Photos",@"Required Labels", nil];
        
        self.cameraItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera
                                                                        target:self
                                                                        action:@selector(cameraAction:)];
        [self.cameraItem setStyle:UIBarButtonItemStyleDone];
        
        
        self.snapPhotoItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera
                                                                           target:self
                                                                           action:@selector(snapPhotoAction:)];
        [self.snapPhotoItem setStyle:UIBarButtonItemStyleBordered];
        
        self.galleryItem = [[UIBarButtonItem alloc] initWithTitle:@""
                                                            style:UIBarButtonItemStyleBordered
                                                           target:self
                                                           action:@selector(galleryAction:)];
        
        self.expandItem = [[UIBarButtonItem alloc] initWithTitle:@""
                                                           style:UIBarButtonItemStyleBordered
                                                          target:self
                                                          action:@selector(expandAction:)];
        
        self.filterItem = [[UIBarButtonItem alloc] initWithTitle:@""
                                                           style:UIBarButtonItemStyleBordered
                                                          target:self
                                                          action:@selector(filterAction:)];
        
        self.toggleFilterItem = [[UIBarButtonItem alloc] initWithTitle:@""
                                                                 style:UIBarButtonItemStyleBordered
                                                                target:self
                                                                action:@selector(toggleFilterAction:)];
        self.toggleFilterItem2 = [[UIBarButtonItem alloc] initWithTitle:@""
                                                                  style:UIBarButtonItemStyleBordered
                                                                 target:self
                                                                 action:@selector(toggleFilterAction:)];
        
        self.editItem = [[UIBarButtonItem alloc] initWithTitle:@""
                                                         style:UIBarButtonItemStyleBordered
                                                        target:self
                                                        action:@selector(editAction:)];
        
        self.labItem = [[UIBarButtonItem alloc] initWithTitle:@"Choose Label"
                                                        style:UIBarButtonItemStyleBordered
                                                       target:self
                                                       action:@selector(labAction:)];
        
        /*
         self.hudItem = [[UIBarButtonItem alloc] initWithTitle:@"HUD"
         style:UIBarButtonItemStyleBordered
         target:self
         action:@selector(hudAction:)];
         */
        
        
        UIBarButtonItem *flexible = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        
        self.bbarItems = [NSArray arrayWithObjects:
                     
                     //PHASLabelFS
                     [NSArray arrayWithObjects:
                      flexible,
                      self.toggleFilterItem,
                      flexible,
                      nil],
                     
                     //PHASViewfinder
                     [NSArray arrayWithObjects:
                      //flexible,
                      //self.hudItem,
                      flexible,
                      self.galleryItem,
                      flexible,
                      self.snapPhotoItem,
                      flexible,
                      self.labItem,
                      flexible,
                      nil],
                     
                     //PHASGrid
                     [NSArray arrayWithObjects:
                      flexible,
                      self.cameraItem,
                      flexible,
                      self.expandItem,
                      flexible,
                      self.filterItem,
                      flexible,
                      self.editItem,
                      flexible,
                      nil],
                     
                     //PHASExpanded
                     [NSArray arrayWithObjects:
                      flexible,
                      self.cameraItem,
                      flexible,
                      self.expandItem,
                      flexible,
                      self.editItem,
                      flexible,
                      nil],
                     
                     
                     nil];
        
        self.delItem = [[UIBarButtonItem alloc] initWithTitle:@"Delete"
                                                        style:UIBarButtonItemStyleBordered
                                                       target:self
                                                       action:@selector(delAction:)];
        [self.delItem setTintColor:[UIColor redColor]];
        
        // Title Label for Counts in grid view
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 11.0f, 320, 21.0f)];
        [self.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:14]];
        [self.titleLabel setBackgroundColor:[UIColor clearColor]];
        [self.titleLabel setTextColor:[UIColor whiteColor]];
        if (gSingleton.iPadDevice)
        {
            [self.titleLabel setTextColor:[UIColor darkGrayColor]];
        }
        [self.titleLabel setText:@""];
        [self.titleLabel setTextAlignment:UITextAlignmentCenter];
        
        self.reqCountItem = [[UIBarButtonItem alloc] initWithCustomView:self.titleLabel];
        
        // Title Label for Current Item in navigation views
        self.titleCurrentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 11.0f, 320, 21.0f)];
        [self.titleCurrentLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
        [self.titleCurrentLabel setBackgroundColor:[UIColor clearColor]];
        [self.titleCurrentLabel setTextColor:[UIColor whiteColor]];
        if (gSingleton.iPadDevice)
        {
            [self.titleCurrentLabel setTextColor:[UIColor darkGrayColor]];
        }
        [self.titleCurrentLabel setText:@""];
        [self.titleCurrentLabel setTextAlignment:UITextAlignmentCenter];
        
        // Title Labels for Expanded View
        self.titleExpandedLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 5.0f, 320, 21.0f)];
        [self.titleExpandedLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
        [self.titleExpandedLabel setBackgroundColor:[UIColor clearColor]];
        [self.titleExpandedLabel setTextColor:[UIColor whiteColor]];
        if (gSingleton.iPadDevice)
        {
            [self.titleExpandedLabel setTextColor:[UIColor darkGrayColor]];
        }
        [self.titleExpandedLabel setText:@"Label Name"];
        [self.titleExpandedLabel setTextAlignment:UITextAlignmentCenter];

        self.titleExpandedCount = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 23.0f, 320, 17.0f)];
        [self.titleExpandedCount setFont:[UIFont fontWithName:@"Helvetica" size:13]];
        [self.titleExpandedCount setBackgroundColor:[UIColor clearColor]];
        [self.titleExpandedCount setTextColor:[UIColor whiteColor]];
        if (gSingleton.iPadDevice)
        {
            [self.titleExpandedCount setTextColor:[UIColor darkGrayColor]];
        }
        [self.titleExpandedCount setText:@"(1 of 32)"];
        [self.titleExpandedCount setTextAlignment:UITextAlignmentCenter];
        self.expandedLabelView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
        [self.expandedLabelView addSubview:self.titleExpandedLabel];
        [self.expandedLabelView addSubview:self.titleExpandedCount];
        
        self.curLabItem = [[UIBarButtonItem alloc] initWithCustomView:self.titleCurrentLabel];
        self.expandedLabItem = [[UIBarButtonItem alloc] initWithCustomView:self.expandedLabelView];
        
        self.headerItems = [NSArray arrayWithObjects:
                       
                    [NSArray arrayWithObjects:
                        flexible,
                        self.reqCountItem,
                        flexible,
                        nil],
                       
                    [NSArray arrayWithObjects:
                        flexible,
                        self.curLabItem,
                        flexible,
                        nil],
                       
                    [NSArray arrayWithObjects:
                        flexible,
                        self.expandedLabItem,
                        flexible,
                        nil],
                            
                    nil];
        
        self.hudHidden = NO;
        
        if (gSingleton.openToGallery)
        {
            gSingleton.currentAppState = PHASGrid;
        }
        else
        {
            if (gSingleton.preSelectedLabel != nil)
            {
                gSingleton.currentPhotoLabel = gSingleton.preSelectedLabel;
                gSingleton.preSelectedLabel = nil;
                gSingleton.currentLabelDescription = @"";
                gSingleton.currentAppState = PHASViewfinder;
            }
        }
        gSingleton.editOn = NO;
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
    if (gSingleton.showTrace)
        NSLog(@"[MainViewController] didReceiveMemoryWarning");
}

#pragma mark - Child View Controllers

- (void)updateAvcHolderView
{
    self.avcController.view.frame = self.avcHolderView.bounds;
}

- (void)updatePtHolderView
{
    self.ptController.view.frame = self.ptHolderView.bounds;
}

 - (void)updateRvHolderView
{
    self.rvController.view.frame = self.rvHolderView.bounds;
}

- (void)updateNavView
{
    self.navViewController.view.frame = self.navView.bounds;
}

- (void)updateHeaderView
{
    self.headerViewController.view.frame = self.headerView.bounds;
}

- (void)updateSsHolderView
{
    self.ssHolderViewController.view.frame = self.ssHolderView.bounds;
}

- (void)updateTogHolderView
{
    self.togHolderViewController.view.frame = self.togHolderView.bounds;
}

/*
- (void)setAvcHolderViewController:(SampleViewController *)avcHolderViewController
{
    //_avcHolderViewController = avcHolderViewController;
    
    if (avcHolderViewController != nil)
    {
        // handle view controller hierarchy
        [self addChildViewController:_avcHolderViewController];
        [_avcHolderViewController didMoveToParentViewController:self];
    
        if ([self isViewLoaded])
        {
            [self updateAvcHolderView];
        }
    }
}

- (void)setPtHolderViewController:(SampleViewController *)ptHolderViewController
{
    _ptHolderViewController = ptHolderViewController;
    
    if (ptHolderViewController != nil)
    {
        // handle view controller hierarchy
        [self addChildViewController:_ptHolderViewController];
        [ptHolderViewController didMoveToParentViewController:self];
    
        if([self isViewLoaded])
        {
            [self updatePtHolderView];
        }
    }
}

 - (void)setRvHolderViewController:(SampleViewController *)rvHolderViewController
 {
 _rvHolderViewController = rvHolderViewController;
 
 if (rvHolderViewController != nil)
 {
 // handle view controller hierarchy
 [self addChildViewController:_rvHolderViewController];
 [_rvHolderViewController didMoveToParentViewController:self];
 
 if ([self isViewLoaded])
 {
 [self updateRvHolderView];
 }
 }
 }
*/

- (void)initNavViewController:(SampleNavigationController *)navViewController
{
    self.navViewController = navViewController;
    
    if (self.navViewController != nil)
    {
        // handle view controller hierarchy
        [self addChildViewController:self.navViewController];
        [self.navViewController didMoveToParentViewController:self];
    }
}

- (void)initHeaderViewController:(SampleNavigationController *)headerViewController
{
    self.headerViewController = headerViewController;
    
    if (self.headerViewController != nil)
    {
        // handle view controller hierarchy
        [self addChildViewController:self.headerViewController];
        [self.headerViewController didMoveToParentViewController:self];
    }
}

- (void)initSSHolderViewController:(SampleNavigationController *)ssHolderViewController
{
    self.ssHolderViewController = ssHolderViewController;
    
    if (self.ssHolderViewController != nil)
    {
        // handle view controller hierarchy
        [self addChildViewController:self.ssHolderViewController];
        [self.ssHolderViewController didMoveToParentViewController:self];
    }
}

- (void)initTogHolderViewController:(SampleNavigationController *)togHolderViewController
{
    self.togHolderViewController = togHolderViewController;
    
    if (self.togHolderViewController != nil)
    {
        // handle view controller hierarchy
        [self addChildViewController:self.togHolderViewController];
        [self.togHolderViewController didMoveToParentViewController:self];
    }
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    if (gSingleton.showTrace)
        NSLog(@"[MainViewController] viewDidLoad");

    [super viewDidLoad];

    if (gSingleton.orderNumber != nil)
    {
        gSingleton.workOrder = [WorkOrder getWorkOrder:gSingleton.orderNumber andUserId:gSingleton.userId];
    }

    UIBarButtonItem *flexible = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];

    // initialize label list
    self.rvController = [[RootViewController alloc] init];
    self.rvHolderView = [[UIView alloc] init];
    [self updateRvHolderView];
    [self.rvHolderView addSubview:self.rvController.view];
    
    // initialize bottom toolbar
    [self initNavViewController:[[SampleNavigationController alloc] initWithName:@"Toolbar"]];
    self.navView = [[UIView alloc] init];
    [self updateNavView];
    [self.navView addSubview:self.navViewController.view];
    
    // initialize title bar
    [self initHeaderViewController:[[SampleNavigationController alloc] initWithName:@"Titlebar"]];
    self.headerView = [[UIView alloc] init];
    [self updateHeaderView];
    [self.headerView addSubview:self.headerViewController.view];
    
    // initialize photo grid
    self.ptController = [[PTDemoViewController alloc] init];
    self.ptHolderView = [[UIView alloc] init];
    [self updatePtHolderView];
    [self.ptHolderView addSubview:self.ptController.view];

    // initialize camera viewfinder
    self.avcController = [[AVCamViewController alloc] init];
    self.avcHolderView = [[UIView alloc] init];
    [self updateAvcHolderView];
    [self.avcHolderView addSubview:self.avcController.view];
    
    // initialize the label required toggle view
    [self initSSHolderViewController:[[SampleNavigationController alloc] initWithName:@"Required/All Labels"]];
    self.ssHolderView = [[UIView alloc] init];
    [self updateSsHolderView];
    [self.ssHolderView addSubview:self.ssHolderViewController.view];

    [self.ssHolderViewController setToolbarHidden:NO];
    [self.ssHolderViewController.toolbar setBarStyle:UIBarStyleDefault];//UIBarStyleBlackOpaque];
    self.ssHolderViewController.toolbar.items = [NSArray arrayWithObjects:
                                                 flexible,
                                                 self.delItem,
                                                flexible,
                                                 nil];

    // initialize the label delete view
    [self initTogHolderViewController:[[SampleNavigationController alloc] initWithName:@"Delete Labels"]];
    self.togHolderView = [[UIView alloc] init];
    [self updateTogHolderView];
    [self.togHolderView addSubview:self.togHolderViewController.view];
    
    [self.togHolderViewController setToolbarHidden:NO];
    [self.togHolderViewController.toolbar setBarStyle:UIBarStyleDefault];//UIBarStyleBlackOpaque];
    self.togHolderViewController.toolbar.items = [NSArray arrayWithObjects:
                                                  flexible,
                                                  self.toggleFilterItem2,
                                                  flexible,
                                                  nil];
    
    // initialize the image detail (expanded) view
    CGFloat statusBarHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
    
    if ([UIApplication sharedApplication].statusBarHidden)
        statusBarHeight = 0 - statusBarHeight;
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    
    // adjust the view to account for a title bar, header, footer each assumed to be 44 pixels tall
    self.detailView = [[UIView alloc] initWithFrame:CGRectMake(0, 44, screenWidth, (screenHeight - 132) - statusBarHeight)];
    
    self.detailView.backgroundColor = [UIColor greenColor];
    
    [self.navViewController setToolbarHidden:NO];
    [self.navViewController.toolbar setBarStyle:UIBarStyleDefault];
    
    [self.headerViewController setToolbarHidden:NO];
    [self.headerViewController.toolbar setBarStyle:UIBarStyleDefault];
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(eventHandlerGalScroll:)
     name:@"galScrollEvent"
     object:nil ];
    
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(eventHandlerULC:)
     name:@"ulcEvent"
     object:nil ];
    
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(eventHandlerLabel:)
     name:@"labelEvent"
     object:nil ];
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(eventHandlerCameraReady:)
     name:@"cameraReadyEvent"
     object:nil ];
    
    // add the views here - note that the order they are added is important since the last added is topmost
    [self.view addSubview:self.navView];
    [self.view addSubview:self.headerView];
    [self.view addSubview:self.detailView];
    [self.view addSubview:self.ptHolderView];
    [self.view addSubview:self.avcHolderView];
    [self.view addSubview:self.rvHolderView];
    [self.view addSubview:self.ssHolderView];
    [self.view addSubview:self.togHolderView];

    [self updateTableView];
    [self updateButtonLabels];
}

-(void)dealloc
{
    NSLog(@"[MainViewController] dealloc");
    
    // remove label list
    if (self.rvHolderView)
    {
        [self.rvController.view removeFromSuperview];
        [self.rvController removeFromParentViewController];
        [self.rvHolderView removeFromSuperview];
    }
    
    // remove bottom toolbar
    if (self.navView)
    {
        [self.navViewController.view removeFromSuperview];
        [self.navViewController removeFromParentViewController];
        [self.navView removeFromSuperview];
    }
    
    // remove title bar
    if (self.headerView)
    {
        [self.headerViewController.view removeFromSuperview];
        [self.headerViewController removeFromParentViewController];
        [self.headerView removeFromSuperview];
    }
    
    // remove camera viewfinder
    if (self.avcHolderView)
    {
        [self.avcController.view removeFromSuperview];
        [self.avcController removeFromParentViewController];
        [self.avcHolderView removeFromSuperview];
    }

    // remove photo grid
    if (self.ptHolderView)
    {
        [self.ptController.view removeFromSuperview];
        [self.ptController removeFromParentViewController];
        [self.ptHolderView removeFromSuperview];
    }

    // remove the required/all button view
    if (self.ssHolderView)
    {
        [self.ssHolderViewController.view removeFromSuperview];
        [self.ssHolderViewController removeFromParentViewController];
        [self.ssHolderView removeFromSuperview];
    }

    // remove the delete button view
    if (self.togHolderView)
    {
        [self.togHolderViewController.view removeFromSuperview];
        [self.togHolderViewController removeFromParentViewController];
        [self.togHolderView removeFromSuperview];
    }
    
    if (self.detailView)
    {
        if (self.detailViewController)
        {
            [self.detailViewController.view removeFromSuperview];
            [self.detailViewController removeFromParentViewController];
        }
        [self.detailView removeFromSuperview];
    }
    
    if (self.expandedLabelView)
    {
        [self.expandedLabelView removeFromSuperview];
    }
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"galScrollEvent" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"ulcEvent" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"labelEvent" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"cameraReadyEvent" object:nil];
}

-(void)showExpandedView:(BOOL)shouldShow
{
    if (shouldShow)
    {
        NSLog(@"[MainViewController] expand ON at index %d", gSingleton.expandedViewIndex);

        if (self.detailViewController == nil)
        {
            self.detailViewController = [[PTImageDetailViewController alloc] initWithImageAtIndex:gSingleton.expandedViewIndex];
        
            self.detailViewController.data = ((PTShowcaseView *)self.ptController.view).imageItems;
            self.detailViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        
            self.detailViewController.view.backgroundColor = [UIColor blackColor];
            self.detailViewController.wantsFullScreenLayout = NO;
            
            gSingleton.expandOn = YES;
            
            [self.detailView addSubview:self.detailViewController.view];
            
            [[NSNotificationCenter defaultCenter]
             postNotificationName:@"galScrollEvent"
             object:nil ];
        }
    }
    else
    {
        NSLog(@"[MainViewController] expand OFF at index %d", gSingleton.expandedViewIndex);

        if (self.detailViewController != nil)
        {
            gSingleton.expandOn = NO;
            gSingleton.expandedViewIndex = -1;
            [self.detailViewController.view removeFromSuperview];
            [self.detailViewController removeFromParentViewController];
            self.detailViewController = nil;
        }
    }
}

-(void)eventHandlerLabel:(NSNotification *) notification
{
    if (gSingleton.showTrace)
        NSLog(@"labelEvent (MainViewController) %d", gSingleton.currentAppState);
    
    if (gSingleton.currentAppState == PHASLabelFS)
    {
        gSingleton.currentAppState = PHASViewfinder;
        gSingleton.editOn = NO;
        
        [self updateButtonLabels];
    }
    else if (gSingleton.currentAppState == PHASExpanded)
    {
        if ([gSingleton.currentLabelDescription length] > 0)
        {
            [self.titleCurrentLabel setText:gSingleton.currentLabelDescription];
            [self.titleExpandedLabel setText:gSingleton.currentLabelDescription];
        }
        else
        {
            [self.titleCurrentLabel setText:gSingleton.currentPhotoLabel.getDisplayText];
            [self.titleExpandedLabel setText:gSingleton.currentPhotoLabel.getDisplayText];
        }
    }
    else
    {
        [self updateStatusBar:nil];
    }
}

- (void)camTimer:(NSTimer *)timer
{
    [self.myTimer invalidate];
    self.myTimer = nil;
    self.snapPhotoItem.enabled = YES;
}

-(void)eventHandlerCameraReady: (NSNotification *) notification
{
    if (!self.myTimer)
    {
        self.myTimer = [NSTimer scheduledTimerWithTimeInterval:0.4
                                                   target:self selector:@selector(camTimer:)
                                                 userInfo:nil
                                                  repeats:NO];
    }
}

-(void)eventHandlerGalScroll: (NSNotification *) notification
{
    if ([gSingleton.mainData count] > 0)
    {
        Photo *photo = [gSingleton.mainData objectAtIndex:gSingleton.expandedViewIndex];

        if (gSingleton.showTrace)
            NSLog(@"Gallery Scroll event (%d) %@", gSingleton.expandedViewIndex, photo.label);

        if ([photo.description length] == 0)
        {
            [self.titleCurrentLabel setText:photo.label.getDisplayText];
            [self.titleExpandedLabel setText:photo.label.getDisplayText];
        }
        else
        {
            [self.titleCurrentLabel setText:photo.description];
            [self.titleExpandedLabel setText:photo.description];
        }
        [self.titleExpandedCount setText:[NSString stringWithFormat:@"(%d of %d)", gSingleton.expandedViewIndex + 1, [gSingleton.mainData count]]];
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (gSingleton.showTrace)
        NSLog(@"%d", buttonIndex);
    
    gSingleton.currentFilterMode = buttonIndex;
    
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"clearEvent"
     object:nil ];    
}

-(void)eventHandlerULC: (NSNotification *) notification
{
    if (gSingleton.showTrace)
        NSLog(@"ulcEvent");
    [self updateButtonLabels];
}

-(void) delAction:(id) sender
{
    if (gSingleton.expandOn)
    {
        if (gSingleton.expandedViewIndex >= 0)
        {
            Photo *photo = [gSingleton.mainData objectAtIndex:gSingleton.expandedViewIndex];
            [gSingleton delImage:photo];
            [self showExpandedView:NO];
        }
    }
    else
    {
        for (Photo *photo in gSingleton.mainData)
        {
            if (photo.selected)
            {
                [gSingleton delImage:photo];
            }
        }
    }
    gSingleton.expandedViewIndex = -1;
        
    // force a reload of the data to update images and indexes
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"clearEvent"
     object:nil];
}

-(void) snapPhotoAction:(id) sender
{
    if (self.snapPhotoItem.enabled)
    {
        self.snapPhotoItem.enabled = NO;
        
        [self showExpandedView:NO];
        
        [[NSNotificationCenter defaultCenter]
         postNotificationName:@"cameraEvent"
         object:nil ];
    }
}

-(void) cameraAction:(id) sender
{
    [self showExpandedView:NO];
    gSingleton.currentAppState = PHASLabelFS;
    [self updateButtonLabels];
}


-(void) galleryAction:(id) sender
{
    gSingleton.currentAppState = PHASGrid;
    gSingleton.expandOn = NO;
    gSingleton.expandedViewIndex = -1;
    
    [self updateButtonLabels];
}

-(void) expandAction:(id) sender{
    
    gSingleton.expandOn = !gSingleton.expandOn;
    
    if (gSingleton.expandOn)
    {
        gSingleton.currentAppState = PHASExpanded;
        
        if (gSingleton.currentFilterMode != PHFilterModeAll)
        {
            gSingleton.currentFilterMode = PHFilterModeAll;
            [[NSNotificationCenter defaultCenter]
             postNotificationName:@"clearEvent"
             object:nil ];     
        }
        if (gSingleton.expandedViewIndex == -1 && gSingleton.photoCount > 0)
            gSingleton.expandedViewIndex = 0;
        
        // open up expanded view
        [self showExpandedView:YES];
    }
    else
    {
        gSingleton.currentAppState = PHASGrid;
        gSingleton.expandedViewIndex = -1;        
        
        // close expanded view
        [self showExpandedView:NO];
    }
    [self updateButtonLabels];
}

-(void) updateTableView
{      
    if (gSingleton.filterOn)
    {
        [gSingleton setHashReq:YES];
        
        //self.rvController.tableView = self.rvController.searchDC.searchResultsTableView;
        //self.rvController.searchDC.searchBar.text = @" ";
        [self.rvController.tableView reloadData];
    }
    else
    {
        [gSingleton setHashReq:NO];
        
        //self.rvController.searchDC.searchBar.text = @"";
        [self.rvController.tableView reloadData];
    }
}

-(void) toggleFilterAction:(id) sender {
    gSingleton.filterOn = !gSingleton.filterOn;

    [self updateTableView];
    [self updateButtonLabels];
}

-(void) filterAction:(id) sender{
    [self.actionSheet showInView:self.view];

}

-(void) curLabAction:(id) sender {
    
}

-(void) hudAction:(id) sender
{
    self.hudHidden = !self.hudHidden;
    [self.avcController updateHudButtons:self.hudHidden];
}

-(void) labAction:(id) sender{
    gSingleton.currentAppState = PHASLabelFS;
    
    [self updateButtonLabels];
}

-(void) editAction:(id) sender{
    gSingleton.editOn = !gSingleton.editOn;
    
    [self updateButtonLabels];
}

-(void) updateButtonLabels
{
    self.galleryItem.title = @"Gallery";
    self.snapPhotoItem.title = @"Take Photo";
    
    int curInd = 0;
    
    if (gSingleton.expandOn)
    {
        curInd = 2;
        self.expandItem.title = @"Grid";
    }
    else
    {
        self.expandItem.title = @"Expand";
        if ([gSingleton.currentLabelDescription length] > 0)
            [self.titleCurrentLabel setText:gSingleton.currentLabelDescription];
        else
            [self.titleCurrentLabel setText:gSingleton.currentPhotoLabel.getDisplayText];
    }
    
    if (gSingleton.currentAppState == PHASViewfinder || gSingleton.currentAppState == PHASLabelFS)
    {
        curInd = 1;
    }
    self.headerViewController.toolbar.items = [self.headerItems objectAtIndex:curInd];
    
    if (gSingleton.filterOn)
    {
        self.toggleFilterItem.title = @"Show All";
        self.toggleFilterItem2.title = self.toggleFilterItem.title;
    }
    else
    {
        self.toggleFilterItem.title = @"Show Required";
        self.toggleFilterItem2.title = @"Show Required";
    }
    
    self.filterItem.title = @"Filter";
    
    if (gSingleton.editOn)
    { 
        self.editItem.title = @"Done";
    }
    else
    {
        self.editItem.title = @"Edit";
    }
    
    [self updateStatusBar:nil];
    
    [self.navViewController.toolbar setItems:[self.bbarItems objectAtIndex:gSingleton.currentAppState]];
    [self.navViewController.toolbar setNeedsDisplay];
    
    [self layoutForOrientation:[self interfaceOrientation] andRect:self.view.frame];
}

-(void)updateStatusBarLabel:(NSObject *)anObject
{
    if (gSingleton.showTrace)
        NSLog(@"Required: %d     Labeled: %d     Total: %d", gSingleton.requiredCount, gSingleton.labeledCount, gSingleton.photoCount);
    
    [self.titleLabel setText:[NSString stringWithFormat:@"Required: %d     Labeled: %d     Total: %d", gSingleton.requiredCount, gSingleton.labeledCount, gSingleton.photoCount ]];
}

-(void)updateStatusBar:(NSNotification *)notification
{
    [self performSelector:@selector(updateStatusBarLabel:) withObject:[NSNull null] afterDelay:0.2];
}

- (void)viewDidUnload
{
    if (gSingleton.showTrace)
        NSLog(@"[MainViewController] viewDidUnload");
    //[self setAvcHolderViewController:nil];
    //[self setPtHolderViewController:nil];
    [self setSsHolderViewController:nil];
    [self setTogHolderViewController:nil];
    //[self setRvHolderViewController:nil];
    [self setNavViewController:nil];
    [self setHeaderViewController:nil];
    [self setAvcHolderView:nil];
    [self setPtHolderView:nil];
    [self setTogHolderView:nil];
    [self setSsHolderView:nil];
    [self setRvHolderView:nil];
    [self setNavView:nil];
    [self setHeaderView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if (gSingleton.showTrace)
        NSLog(@"[MainViewController] shouldAutorotateToInterfaceOrientation %d", interfaceOrientation);
    // Return YES for supported orientations
	return interfaceOrientation == UIInterfaceOrientationMaskPortrait;
}

- (void) setBoundsAndLayout:(CGRect)frameRect
{
    [self.view setBounds:CGRectMake(0, 0, frameRect.size.width, frameRect.size.height)];
    [self layoutForOrientation:[[UIApplication sharedApplication] statusBarOrientation] andRect:frameRect];
}

- (void)layoutForOrientation:(UIInterfaceOrientation)orientation andRect:(CGRect)frameRect
{
    CGFloat w;
    CGFloat h;
    
    CGFloat borderSize = 0;
    
    w = frameRect.size.width;
    h = frameRect.size.height;
    
    CGFloat toolbarHeight = 44;
    //CGFloat statusBarHeight = 20;
    
    CGFloat leftPaneWidth = 0;
    CGFloat rightPaneWidth = 0;
    CGFloat contentPaneHeight = 0;
    CGFloat contentPaneWidth = 0;
    
    /*
    if (orientation == UIInterfaceOrientationPortrait || orientation == UIInterfaceOrientationPortraitUpsideDown) {
        temp = w;
        w = h;
        h = temp;
    }
    else {
        if (gSingleton.iPadDevice) {
            
        }
        else {
            toolbarHeight = 32;
        }
    }
    */
    
    
    //[self.ssHolderViewController.navigationBar sizeToFit];
    
    [self.navViewController.toolbar sizeToFit];
    self.navView.frame = CGRectMake(0, h-toolbarHeight, w, toolbarHeight);
    [self updateNavView];
    
    [self.headerViewController.toolbar sizeToFit];
    self.headerView.frame = CGRectMake(0, 0, w, toolbarHeight);
    [self updateHeaderView];
    
    if (gSingleton.iPadDevice)
    {
        if (orientation == UIInterfaceOrientationPortrait || orientation == UIInterfaceOrientationPortraitUpsideDown)
        {
            leftPaneWidth = (w*2)/3;
            rightPaneWidth = w/3;
        }
        else
        {
            leftPaneWidth = (w*3)/4;
            rightPaneWidth = w/4;
        }
        
    }
    else
    {
        leftPaneWidth = w/2;
        rightPaneWidth = w/2;
    }
    
    self.rvHolderView.hidden = NO;
    self.avcHolderView.hidden = NO;
    self.ptHolderView.hidden = NO;
    self.ssHolderView.hidden = NO;
    self.togHolderView.hidden = NO;
    self.detailView.hidden = !gSingleton.expandOn;
    
    switch (gSingleton.currentAppState)
    {
        case PHASLabelFS:   // labels full screen
            
            //[self.rvController.searchDC.searchBar setHidden:YES];
            
            self.avcHolderView.hidden = YES;
            self.ptHolderView.hidden = YES;
            self.ssHolderView.hidden = YES;
            self.togHolderView.hidden = YES;
            
            contentPaneWidth = w - (borderSize * 2);
            contentPaneHeight = h - ((toolbarHeight * 2) + (borderSize * 2));
            self.rvHolderView.frame =  CGRectMake(borderSize, borderSize+toolbarHeight, contentPaneWidth, contentPaneHeight);
            self.rvHolderView.bounds =  CGRectMake(0, 0, contentPaneWidth, contentPaneHeight);
            
            // spin up the GPS and location services
            [[NSNotificationCenter defaultCenter]
             postNotificationName:@"startGPSEvent"
             object:nil ];

            break;
        
        case PHASViewfinder:
            
            self.rvHolderView.hidden = YES;
            self.ptHolderView.hidden = YES;
            self.ssHolderView.hidden = YES;
            self.togHolderView.hidden = YES;
            
            contentPaneWidth = w - (borderSize * 2);
            contentPaneHeight = h - ((toolbarHeight * 2) + (borderSize * 2));
            self.avcHolderView.frame = CGRectMake(borderSize, borderSize+toolbarHeight, contentPaneWidth, contentPaneHeight);
            self.avcHolderView.bounds = CGRectMake(0, 0, contentPaneWidth, contentPaneHeight);

            break;
            
        default:
            
            // stop tracking GPS events
            [[NSNotificationCenter defaultCenter]
             postNotificationName:@"stopGPSEvent"
             object:nil ];

            self.avcHolderView.hidden = YES;
            
            if (gSingleton.editOn)
            {
                if (gSingleton.expandOn)
                    contentPaneWidth = w - (borderSize * 2);
                else
                    contentPaneWidth = (w - (borderSize * 2)) / 2;
                
                contentPaneHeight = h - ((toolbarHeight * 2) + (borderSize * 2));
                self.ptHolderView.frame =  CGRectMake(borderSize, borderSize+toolbarHeight, contentPaneWidth, contentPaneHeight);
                self.ptHolderView.bounds = CGRectMake(0, 0, contentPaneWidth, contentPaneHeight);
                self.rvHolderView.frame =  CGRectMake(leftPaneWidth + borderSize, borderSize+toolbarHeight, rightPaneWidth - (borderSize*2), contentPaneHeight);
                self.rvHolderView.bounds = CGRectMake(0, 0, rightPaneWidth - (borderSize*2), contentPaneHeight);
            }
            else
            {
                self.ssHolderView.hidden = YES;
                self.rvHolderView.hidden = YES;
                self.togHolderView.hidden = YES;
                
                contentPaneWidth = w - (borderSize * 2);
                contentPaneHeight = h - ((toolbarHeight * 2) + (borderSize * 2));
                self.ptHolderView.frame = CGRectMake(borderSize, borderSize+toolbarHeight, contentPaneWidth, contentPaneHeight);
                self.ptHolderView.bounds = CGRectMake(0, 0, contentPaneWidth, contentPaneHeight);
                self.rvHolderView.frame = CGRectMake(borderSize, borderSize+toolbarHeight, contentPaneWidth, contentPaneHeight);
                self.rvHolderView.bounds = CGRectMake(0, 0, contentPaneWidth, contentPaneHeight);
            }
            
            self.ssHolderView.frame = CGRectMake(self.rvHolderView.frame.origin.x, self.rvHolderView.frame.origin.y, self.rvHolderView.frame.size.width, toolbarHeight);
            self.ssHolderView.bounds = CGRectMake(0, 0, self.ssHolderView.frame.size.width, self.ssHolderView.frame.size.height);
            self.togHolderView.frame = CGRectMake(self.rvHolderView.frame.origin.x, self.rvHolderView.frame.origin.y+self.rvHolderView.frame.size.height-toolbarHeight, self.rvHolderView.frame.size.width, toolbarHeight);
            self.togHolderView.bounds = CGRectMake(0, 0, self.togHolderView.frame.size.width, self.togHolderView.frame.size.height);
            
            break;
    }
    
    int flagVal = 0;
    int rvViewTop = 0;
    
    if (self.ssHolderView && !self.ssHolderView.hidden)
    {
        rvViewTop = self.ssHolderView.frame.size.height;
        flagVal++;
    }
    if (self.togHolderView && !self.togHolderView.hidden)
    {
        flagVal++;
    }
    
    /////
    
    self.avcController.view.frame = CGRectMake(0, 0, self.avcHolderView.frame.size.width, self.avcHolderView.frame.size.height);
    self.ptController.view.frame = CGRectMake(0, 0, self.ptHolderView.frame.size.width, self.ptHolderView.frame.size.height);
    self.rvController.view.frame = CGRectMake(0, rvViewTop, self.rvHolderView.frame.size.width, self.rvHolderView.frame.size.height-toolbarHeight*flagVal);
    
    [self.view sendSubviewToBack:self.ptHolderView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (gSingleton.openToGallery && (gSingleton.preSelectedLabel != nil))
    {
        if (gSingleton.showTrace)
            NSLog(@"[MainViewController] opening to Viewfinder with label: %@", gSingleton.preSelectedLabel.getDisplayText);
        gSingleton.currentPhotoLabel = gSingleton.preSelectedLabel;
        gSingleton.preSelectedLabel = nil;
        gSingleton.currentLabelDescription = @"";
        gSingleton.currentAppState = PHASViewfinder;
    }
    [self layoutForOrientation:[[UIApplication sharedApplication] statusBarOrientation] andRect:self.view.frame];
    if (gSingleton.showTrace)
        NSLog(@"[MainViewController] viewWillAppear");
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    if (gSingleton.showTrace)
        NSLog(@"[MainViewController] viewWillRotateToInterfaceOrientation");
    __gm_weak MainViewController *weakSelf = self;
    [UIView animateWithDuration:duration animations:^{
        [weakSelf layoutForOrientation:toInterfaceOrientation andRect:self.view.frame];
    }];
}

@end