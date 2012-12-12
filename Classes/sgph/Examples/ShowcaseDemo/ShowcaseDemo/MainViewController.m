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

//@synthesize avcHolderViewController = _avcHolderViewController;
//@synthesize ptHolderViewController = _ptHolderViewController;
//@synthesize rvHolderViewController = _rvHolderViewController;
@synthesize navViewController = _navViewController;
@synthesize headerViewController = _headerViewController;
@synthesize ssHolderViewController = _ssHolderViewController;
@synthesize togHolderViewController = _togHolderViewController;

@synthesize ptController = _ptController;
@synthesize avcController = _avcController;
@synthesize rvController = _rvController;

@synthesize titleLabel = _titleLabel;
@synthesize titleCurrentLabel = _titleCurrentLabel;

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

@synthesize reqCountItem = _reqCountItem;
@synthesize labCountItem = _labCountItem;
@synthesize totCountItem = _totCountItem;
@synthesize nreqCountItem = _nreqCountItem;
@synthesize nlabCountItem = _nlabCountItem;
@synthesize ntotCountItem = _ntotCountItem;


@synthesize delItem = _delItem;

@synthesize headerItems;
@synthesize bbarItems;

@synthesize fBounds;

@synthesize actionSheet = _actionSheet;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
    }
    
    if (gSingleton.showTrace)
        NSLog(@"MainViewController initWithNibName");    
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
    if (gSingleton.showTrace)
        NSLog(@"MainViewController didReceiveMemoryWarning");    
}

#pragma mark - Child View Controllers

/*
- (void)updateAvcHolderView
{
    self.avcHolderViewController.view.frame = self.avcHolderView.bounds;
    [self.avcHolderView addSubview:self.avcHolderViewController.view];
}

- (void)updatePtHolderView
{
    //_ptHolderViewController.view.frame = ptHolderView.bounds;
    [ptHolderView addSubview:_ptHolderViewController.view];
}

 - (void)updateRvHolderView
{
 //_rvHolderViewController.view.frame = rvHolderView.bounds;
 [rvHolderView addSubview:_rvHolderViewController.view];
}
*/

- (void)updateNavView
{
    self.navViewController.view.frame = self.navView.bounds;
    [self.navView addSubview:self.navViewController.view];
}

- (void)updateHeaderView
{
    self.headerViewController.view.frame = self.headerView.bounds;
    [self.headerView addSubview:self.headerViewController.view];
}

- (void)updateSsHolderView
{
    self.ssHolderViewController.view.frame = self.ssHolderView.bounds;
    [self.ssHolderView addSubview:self.ssHolderViewController.view];
}

- (void)updateTogHolderView
{
    self.togHolderViewController.view.frame = self.togHolderView.bounds;
    [self.togHolderView addSubview:self.togHolderViewController.view];
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
    
        if ([self isViewLoaded])
        {
            [self updateNavView];
        }
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
    
        if ([self isViewLoaded])
        {
            [self updateHeaderView];
        }
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
        
        if([self isViewLoaded])
        {
            [self updateSsHolderView];
        }
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
        
        if([self isViewLoaded])
        {
            [self updateTogHolderView];
        }
    }
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    if (gSingleton.showTrace)
        NSLog(@"MainViewController viewDidLoad");
    
    gSingleton.workOrder = [WorkOrder getWorkOrder:gSingleton.orderNumber andUserId:gSingleton.userId];
    NSLog(@"Initializing workorder: %@ for user: %@, status: %d", gSingleton.workOrder.order_id, gSingleton.workOrder.user_id, gSingleton.workOrder.status_id);

    fBounds = self.view.bounds;//CGRectMake(0.0, 0.0, 0.0, 0.0);
    self.hudHidden = NO;
    
    self.view.backgroundColor = [UIColor blackColor];
    
    self.ptController = [[PTDemoViewController alloc] init];
    self.rvController = [[RootViewController alloc] init];
    self.avcController = [[AVCamViewController alloc] init];
        
    self.ptHolderView = [[UIView alloc] init];
    [self.view addSubview:self.ptHolderView];
    
    self.rvHolderView = [[UIView alloc] init];
    [self.view addSubview:self.rvHolderView];
    
    self.avcHolderView = [[UIView alloc] init];
    [self.view addSubview:self.avcHolderView];

    self.navView = [[UIView alloc] init];
    [self.view addSubview:self.navView];
    
    self.headerView = [[UIView alloc] init];
    [self.view addSubview:self.headerView];
    
    self.ssHolderView = [[UIView alloc] init];
    [self.view addSubview:self.ssHolderView];
    
    self.togHolderView = [[UIView alloc] init];
    [self.view addSubview:self.togHolderView];
    
    
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
    
    bbarItems = [NSArray arrayWithObjects: 
                      
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

    self.curLabItem = [[UIBarButtonItem alloc] initWithCustomView:self.titleCurrentLabel];
    
    /*
    UILabel* titleLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(0.0 , 11.0f, 50, 21.0f)];
    [titleLabel2 setFont:[UIFont fontWithName:@"Helvetica-Bold" size:12]];
    [titleLabel2 setBackgroundColor:[UIColor clearColor]];
    [titleLabel2 setTextColor:[UIColor whiteColor]];
    [titleLabel2 setText:@"Labeled:"];
    [titleLabel2 setTextAlignment:UITextAlignmentRight];
      
    UILabel* titleLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(0.0 , 11.0f, 40, 21.0f)];
    [titleLabel3 setFont:[UIFont fontWithName:@"Helvetica-Bold" size:12]];
    [titleLabel3 setBackgroundColor:[UIColor clearColor]];
    [titleLabel3 setTextColor:[UIColor whiteColor]];
    [titleLabel3 setText:@"Total:"];
    [titleLabel3 setTextAlignment:UITextAlignmentRight];
    */
    
    
    //self.labCountItem = [[UIBarButtonItem alloc] initWithCustomView:titleLabel2];
    //self.totCountItem = [[UIBarButtonItem alloc] initWithCustomView:titleLabel3];    
    
    /*
    self.nreqCountItem = [[UIBarButtonItem alloc] initWithTitle:@"0"
                                                         style:UIBarButtonItemStyleBordered
                                                        target:self
                                                        action:@selector(reqCountAction:)];
    [self.nreqCountItem setTintColor:[UIColor redColor]];
    
    self.nlabCountItem = [[UIBarButtonItem alloc] initWithTitle:@"0"
                                                         style:UIBarButtonItemStyleBordered
                                                        target:self
                                                        action:@selector(labCountAction:)];
    [self.nlabCountItem setTintColor:[UIColor redColor]];
    
    self.ntotCountItem = [[UIBarButtonItem alloc] initWithTitle:@"0"
                                                         style:UIBarButtonItemStyleBordered
                                                        target:self
                                                        action:@selector(totCountAction:)];
    [self.ntotCountItem setTintColor:[UIColor redColor]];
    
     
     self.reqCountItem,
     self.nreqCountItem,
     flexible,
     self.labCountItem,
     self.nlabCountItem,
     flexible,
     self.totCountItem,
     self.ntotCountItem,
     */
    
    headerItems = [NSArray arrayWithObjects: 
                       
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
                       
                       nil];
    
    [self initNavViewController:[[SampleNavigationController alloc] init]];
    [self initHeaderViewController:[[SampleNavigationController alloc] init]];
    [self initSSHolderViewController:[[SampleNavigationController alloc] init]];
    [self initTogHolderViewController:[[SampleNavigationController alloc] init]];

    [self.avcHolderView addSubview:self.avcController.view];
    [self.ptHolderView addSubview:self.ptController.view];
    [self.rvHolderView addSubview:self.rvController.view];
    [self.navView addSubview:self.navViewController.view];
    [self.headerView addSubview:self.headerViewController.view];
    [self.ssHolderView addSubview:self.ssHolderViewController.view];
    [self.togHolderView addSubview:self.togHolderViewController.view];
    
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
    
    [super viewDidLoad];

    refTimer = [NSTimer scheduledTimerWithTimeInterval:0.2
                                                target:self selector:@selector(doRefTimer:)
                                              userInfo:nil
                                               repeats:NO];
}

-(void) shutdown
{
    NSLog(@"[MainViewController] shutdown");

    [self.avcController removeFromParentViewController];
    self.avcController = nil;
    [self.avcHolderView willMoveToSuperview:nil];
    [self.avcHolderView removeFromSuperview];
    self.avcHolderView = nil;
    
    [self.ptController removeFromParentViewController];
    self.ptController = nil;
    [self.ptHolderView willMoveToSuperview:nil];
    [self.ptHolderView removeFromSuperview];
    self.ptHolderView = nil;

    [self.rvController removeFromParentViewController];
    self.rvController = nil;
    [self.rvHolderView willMoveToSuperview:nil];
    [self.rvHolderView removeFromSuperview];
    self.rvHolderView = nil;

    [self.navViewController removeFromParentViewController];
    self.navViewController = nil;
    [self.navView willMoveToSuperview:nil];
    [self.navView removeFromSuperview];
    self.navView = nil;
    
    [self.headerViewController removeFromParentViewController];
    self.headerViewController = nil;
    [self.headerView willMoveToSuperview:nil];
    [self.headerView removeFromSuperview];
    self.headerView = nil;
    
    [self.ssHolderViewController removeFromParentViewController];
    self.ssHolderViewController = nil;
    [self.ssHolderView willMoveToSuperview:nil];
    [self.ssHolderView removeFromSuperview];
    self.ssHolderView = nil;
    
    [self.togHolderViewController removeFromParentViewController];
    self.togHolderViewController = nil;
    [self.togHolderView willMoveToSuperview:nil];
    [self.togHolderView removeFromSuperview];
    self.togHolderView = nil;
    
    self.actionSheet = nil;
    self.cameraItem = nil;
    self.snapPhotoItem = nil;
    self.galleryItem = nil;
    self.expandItem = nil;
    self.filterItem = nil;
    self.toggleFilterItem = nil;
    self.toggleFilterItem2 = nil;
    self.editItem = nil;
    self.labItem = nil;
    self.curLabItem = nil;
    self.delItem = nil;
    bbarItems = nil;
    self.titleLabel = nil;
    self.titleCurrentLabel = nil;
    self.reqCountItem = nil;
    headerItems = nil;

    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"galScrollEvent" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"ulcEvent" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"labelEvent" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"cameraReadyEvent" object:nil];

    if (refTimer != nil)
    {
        [refTimer invalidate];
        refTimer = nil;
    }
}

- (void)doRefTimer:(NSTimer *)timer
{
    [refTimer invalidate];
    refTimer = nil;
    
    if (gSingleton.doRef)
    {
        if (gSingleton.showTrace)
            NSLog(@"doRefTimer");

        gSingleton.doRef = NO;
        
        if (gSingleton.currentAppState == PHASGrid)
        {
            [[NSNotificationCenter defaultCenter]
             postNotificationName:@"expandOffEvent"
             object:nil ];
        }
        
        UIBarButtonItem *flexible = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];

        [self.ssHolderViewController setToolbarHidden:NO];
        [self.ssHolderViewController.toolbar setBarStyle:UIBarStyleDefault];//UIBarStyleBlackOpaque];
        self.ssHolderViewController.toolbar.items = [NSArray arrayWithObjects:
                                                     flexible,
                                                     self.delItem,
                                                     flexible,
                                                     nil];
        
        [self.togHolderViewController setToolbarHidden:NO];
        [self.togHolderViewController.toolbar setBarStyle:UIBarStyleDefault];//UIBarStyleBlackOpaque];
        self.togHolderViewController.toolbar.items = [NSArray arrayWithObjects:
                                                      flexible,
                                                      self.toggleFilterItem2,
                                                      flexible,
                                                      nil],
        
        [self.navViewController setToolbarHidden:NO];
        [self.navViewController.toolbar setBarStyle:UIBarStyleDefault];
        
        [self.headerViewController setToolbarHidden:NO];
        [self.headerViewController.toolbar setBarStyle:UIBarStyleDefault];
        [self updateTableView];
        [self updateButtonLabels];
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
            [self.titleCurrentLabel setText:gSingleton.currentLabelDescription];
        else
            [self.titleCurrentLabel setText:gSingleton.currentLabelString];
    }
    else
    {
        [self updateStatusBar:nil];
    }
}

- (void)camTimer:(NSTimer *)timer
{
    [myTimer invalidate];
    myTimer = nil;
    self.snapPhotoItem.enabled = YES;
}

-(void)eventHandlerCameraReady: (NSNotification *) notification
{
    
    if (!myTimer)
    {
        myTimer = [NSTimer scheduledTimerWithTimeInterval:0.4
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
            [self.titleCurrentLabel setText:photo.label];
        else
            [self.titleCurrentLabel setText:photo.description];
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

-(void) delAction:(id) sender{
    
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"delEvent"
     object:nil ];
}

-(void) reqCountAction:(id) sender{
    
}
-(void) labCountAction:(id) sender{
    
}
-(void) totCountAction:(id) sender{
    
}

-(void) snapPhotoAction:(id) sender {
    
    if (self.snapPhotoItem.enabled) {
        self.snapPhotoItem.enabled = NO;
        
        [[NSNotificationCenter defaultCenter]
         postNotificationName:@"expandOffEvent"
         object:nil ];
        
        [[NSNotificationCenter defaultCenter]
         postNotificationName:@"cameraEvent"
         object:nil ];
    }
}

-(void) cameraAction:(id) sender{
    gSingleton.currentAppState = PHASLabelFS;
    [self updateButtonLabels];
}


-(void) galleryAction:(id) sender{
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
            
        [[NSNotificationCenter defaultCenter]
         postNotificationName:@"expandOnEvent"
         object:nil ];
    }
    else
    {
        gSingleton.currentAppState = PHASGrid;
        gSingleton.expandedViewIndex = -1;        
        
        [[NSNotificationCenter defaultCenter]
         postNotificationName:@"expandOffEvent"
         object:nil ];
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
        curInd = 1;
        self.expandItem.title = @"Grid";
    }
    else
    {
        self.expandItem.title = @"Expand";
        if ([gSingleton.currentLabelDescription length] > 0)
            [self.titleCurrentLabel setText:gSingleton.currentLabelDescription];
        else
            [self.titleCurrentLabel setText:gSingleton.currentLabelString];
    }
    
    if (gSingleton.currentAppState == PHASViewfinder || gSingleton.currentAppState == PHASLabelFS)
    {
        curInd = 1;
    }
    self.headerViewController.toolbar.items = [headerItems objectAtIndex:curInd];
    
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
    
    self.navViewController.toolbar.items = [bbarItems objectAtIndex:gSingleton.currentAppState];
    [self.navViewController.toolbar setNeedsDisplay];
    
    [self layoutForOrientation:[self interfaceOrientation]];
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
        NSLog(@"MainViewController viewDidUnload");    
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
        NSLog(@"MainViewController shouldAutorotateToInterfaceOrientation %d", interfaceOrientation);    
    // Return YES for supported orientations
	return interfaceOrientation == UIInterfaceOrientationMaskPortrait;
}

- (void) setBoundsAndLayout:(CGRect)frameRect
{
    fBounds = frameRect;
    [self layoutForOrientation:[[UIApplication sharedApplication] statusBarOrientation]];
}

- (void)layoutForOrientation:(UIInterfaceOrientation)orientation
{
    
    CGFloat w;
    CGFloat h;
    
    CGFloat borderSize = 0;
    
    w = fBounds.size.width;
    h = fBounds.size.height;
    
    
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
    
    [self.headerViewController.toolbar sizeToFit];
    self.headerView.frame = CGRectMake(0, 0, w, toolbarHeight);
    
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
    
    //[self.ssHolderViewController setToolbarHidden:YES];
    
    /////
    
    self.rvHolderView.hidden = NO;
    self.avcHolderView.hidden = NO;
    self.ptHolderView.hidden = NO;
    self.ssHolderView.hidden = NO;
    self.togHolderView.hidden = NO;
    
    
    switch (gSingleton.currentAppState)
    {
        case PHASLabelFS:
            
            //[self.rvController.searchDC.searchBar setHidden:YES];
            
            self.avcHolderView.hidden = YES;
            self.ptHolderView.hidden = YES;
            self.ssHolderView.hidden = YES;
            self.togHolderView.hidden = YES;
            
            contentPaneWidth = w - (borderSize * 2);
            contentPaneHeight = h - ((toolbarHeight * 2) + (borderSize * 2));
            self.rvHolderView.frame =  CGRectMake(borderSize, borderSize+toolbarHeight, contentPaneWidth, contentPaneHeight);
            
            break;
        
        case PHASViewfinder:
            
            self.rvHolderView.hidden = YES;
            self.ptHolderView.hidden = YES;
            self.ssHolderView.hidden = YES;
            self.togHolderView.hidden = YES;
            
            contentPaneWidth = w - (borderSize * 2);
            contentPaneHeight = h - (toolbarHeight + (borderSize * 2));
            self.avcHolderView.frame = CGRectMake(borderSize, borderSize+toolbarHeight, contentPaneWidth, contentPaneHeight);
            
            break;
            
        default:
            
            self.avcHolderView.hidden = YES;
            
            if (gSingleton.editOn)
            {
                if (gSingleton.expandOn)
                    contentPaneWidth = w - (borderSize * 2);
                else
                    contentPaneWidth = (w - (borderSize * 2)) / 2;
                
                contentPaneHeight = h - ((toolbarHeight * 2) + (borderSize * 2));
                self.ptHolderView.frame =  CGRectMake(borderSize, borderSize+toolbarHeight, contentPaneWidth, contentPaneHeight);
                self.rvHolderView.frame =  CGRectMake(leftPaneWidth + borderSize, borderSize+toolbarHeight, rightPaneWidth - (borderSize*2), contentPaneHeight);
            }
            else
            {
                self.ssHolderView.hidden = YES;
                self.rvHolderView.hidden = YES;
                self.togHolderView.hidden = YES;
                
                contentPaneWidth = w - (borderSize * 2);
                contentPaneHeight = h - ((toolbarHeight * 2) + (borderSize * 2));
                self.ptHolderView.frame =  CGRectMake(borderSize, borderSize+toolbarHeight, contentPaneWidth, contentPaneHeight);
                self.rvHolderView.frame =  CGRectMake(borderSize, borderSize+toolbarHeight, contentPaneWidth, contentPaneHeight);
            }
            
            self.ssHolderView.frame = CGRectMake(self.rvHolderView.frame.origin.x, self.rvHolderView.frame.origin.y, self.rvHolderView.frame.size.width, toolbarHeight);
            self.togHolderView.frame = CGRectMake(self.rvHolderView.frame.origin.x, self.rvHolderView.frame.origin.y+self.rvHolderView.frame.size.height-toolbarHeight, self.rvHolderView.frame.size.width, toolbarHeight);
            
            break;
    }
    
    int flagVal = 0;
    int rvViewTop = 0;
    
    if (!self.ssHolderView.hidden)
    {
        rvViewTop = self.ssHolderView.frame.size.height;
        flagVal++;
    }
    if (!self.togHolderView.hidden)
    {
        flagVal++;
    }
    
    /////
    
    self.avcController.view.frame = CGRectMake(0, 0, self.avcHolderView.frame.size.width, self.avcHolderView.frame.size.height);
    self.ptController.view.frame = CGRectMake(0, 0, self.ptHolderView.frame.size.width, self.ptHolderView.frame.size.height);
    self.rvController.view.frame = CGRectMake(0, rvViewTop, self.rvHolderView.frame.size.width, self.rvHolderView.frame.size.height-toolbarHeight*flagVal);
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self layoutForOrientation:[[UIApplication sharedApplication] statusBarOrientation]];
    if (gSingleton.showTrace)
        NSLog(@"MainViewController viewWillAppear");    
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    if (gSingleton.showTrace)
        NSLog(@"MainViewController viewWillRotateToInterfaceOrientation");    
    [UIView animateWithDuration:duration animations:^{
        [self layoutForOrientation:toInterfaceOrientation];
    }];
}

@end
