#import "MySingleton.h"
#import "MainViewController.h"
#import "AVCamViewController.h"
#import "RootViewController.h"
#import "PTDemoViewController.h"

#import "DataController.h"

@implementation MainViewController

@synthesize avcHolderView;
@synthesize ptHolderView;
@synthesize ssHolderView;
@synthesize togHolderView;
@synthesize rvHolderView;
@synthesize navView;
@synthesize headerView;

@synthesize avcHolderViewController = _avcHolderViewController;
@synthesize ptHolderViewController = _ptHolderViewController;
@synthesize ssHolderViewController = _ssHolderViewController;
@synthesize togHolderViewController = _togHolderViewController;
@synthesize rvHolderViewController = _rvHolderViewController;
@synthesize navViewController = _navViewController;
@synthesize headerViewController = _headerViewController;

@synthesize ptController = _ptController;
@synthesize avcController = _avcController;
@synthesize rvController = _rvController;

@synthesize titleLabel;

@synthesize labItem;
@synthesize hudItem;
@synthesize hudHidden;

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

        DataController *data = [[DataController alloc] init];
        NSString *dbPath = [data dbPath:@"inspi"];
        bool databaseExists = [[NSFileManager defaultManager] fileExistsAtPath:dbPath];
        NSLog(@"dbPath: %@ exists:%@", dbPath, databaseExists ? @"YES" : @"NO");
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

- (void)updateAvcHolderView
{
    _avcHolderViewController.view.frame = avcHolderView.bounds;
    [avcHolderView addSubview:_avcHolderViewController.view];    
}

- (void)updatePtHolderView
{
    _ptHolderViewController.view.frame = ptHolderView.bounds;
    [ptHolderView addSubview:_ptHolderViewController.view];
}

- (void)updateSsHolderView
{
    _ssHolderViewController.view.frame = ssHolderView.bounds;
    [ssHolderView addSubview:_ssHolderViewController.view];
}

- (void)updateTogHolderView
{
    _togHolderViewController.view.frame = togHolderView.bounds;
    [togHolderView addSubview:_togHolderViewController.view];
}

- (void)updateRvHolderView
{
    _rvHolderViewController.view.frame = rvHolderView.bounds;
    [rvHolderView addSubview:_rvHolderViewController.view];    
}

- (void)updateNavView
{
    _navViewController.view.frame = navView.bounds;
    [navView addSubview:_navViewController.view];    
}

- (void)updateHeaderView
{
    _headerViewController.view.frame = headerView.bounds;
    [headerView addSubview:_headerViewController.view];    
}

- (void)setAvcHolderViewController:(SampleViewController *)avcHolderViewController
{
    _avcHolderViewController = avcHolderViewController;
    
    // handle view controller hierarchy
    [self addChildViewController:_avcHolderViewController];
    [_avcHolderViewController didMoveToParentViewController:self];
    
    if ([self isViewLoaded]) {
        [self updateAvcHolderView];
    }
}

- (void)setPtHolderViewController:(SampleViewController *)ptHolderViewController
{
    _ptHolderViewController = ptHolderViewController;
    
    // handle view controller hierarchy
    [self addChildViewController:_ptHolderViewController];
    [ptHolderViewController didMoveToParentViewController:self];
    
    if([self isViewLoaded]) {
        [self updatePtHolderView];
    }
}

- (void)setSsHolderViewController:(SampleNavigationController *)ssHolderViewController
{
    _ssHolderViewController = ssHolderViewController;
    
    // handle view controller hierarchy
    [self addChildViewController:_ssHolderViewController];
    [ssHolderViewController didMoveToParentViewController:self];
    
    if([self isViewLoaded]) {
        [self updateSsHolderView];
    }
}

- (void)setTogHolderViewController:(SampleNavigationController *)togHolderViewController
{
    _togHolderViewController = togHolderViewController;
    
    // handle view controller hierarchy
    [self addChildViewController:_togHolderViewController];
    [togHolderViewController didMoveToParentViewController:self];
    
    if([self isViewLoaded]) {
        [self updateTogHolderView];
    }
}

- (void)setRvHolderViewController:(SampleViewController *)rvHolderViewController
{
    _rvHolderViewController = rvHolderViewController;
    
    // handle view controller hierarchy
    [self addChildViewController:_rvHolderViewController];
    [_rvHolderViewController didMoveToParentViewController:self];
    
    if ([self isViewLoaded]) {
        [self updateRvHolderView];
    }
}

- (void)setNavViewOtherController:(SampleNavigationController *)navViewController
{
    _navViewController = navViewController;
    
    // handle view controller hierarchy
    [self addChildViewController:_navViewController];
    [_navViewController didMoveToParentViewController:self];
    
    if ([self isViewLoaded]) {
        [self updateNavView];
    }
}

- (void)setHeaderViewController:(SampleNavigationController *)headerViewController
{
    _headerViewController = headerViewController;
    
    // handle view controller hierarchy
    [self addChildViewController:_headerViewController];
    [_headerViewController didMoveToParentViewController:self];
    
    if ([self isViewLoaded]) {
        [self updateHeaderView];
    }
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    if (gSingleton.showTrace)
        NSLog(@"MainViewController viewDidLoad");
    
    DataController *data = [[DataController alloc] init];
    NSString *dbPath = [data dbPath:@"inspi"];
    bool databaseExists = [[NSFileManager defaultManager] fileExistsAtPath:dbPath];
    NSLog(@"dbPath: %@ exists:%@", dbPath, databaseExists ? @"YES" : @"NO");

    fBounds = self.view.bounds;//CGRectMake(0.0, 0.0, 0.0, 0.0);
    hudHidden = NO;
    
    self.view.backgroundColor = [UIColor blackColor];
    
    self.ptController = [[PTDemoViewController alloc] init];
    self.rvController = [[RootViewController alloc] init];
    self.avcController = [[AVCamViewController alloc] init];
        
    self.avcHolderView = [[UIView alloc] init];
    [self.view addSubview:self.avcHolderView];
    
    self.ptHolderView = [[UIView alloc] init];
    [self.view addSubview:self.ptHolderView];
    
    self.rvHolderView = [[UIView alloc] init];
    [self.view addSubview:self.rvHolderView];
    
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
    
    self.curLabItem = [[UIBarButtonItem alloc] initWithTitle:@""
                                                     style:UIBarButtonItemStylePlain
                                                    target:self
                                                    action:@selector(curLabAction:)];
    
    
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
    
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0 , 11.0f, 320, 21.0f)];
    [titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:14]];
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    [titleLabel setTextColor:[UIColor whiteColor]];
    
    if (gSingleton.iPadDevice) {
        [titleLabel setTextColor:[UIColor darkGrayColor]];
    }
    
    [titleLabel setText:@""];
    [titleLabel setTextAlignment:UITextAlignmentCenter];
     
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
    
    self.reqCountItem = [[UIBarButtonItem alloc] initWithCustomView:titleLabel];
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
    
    
    [self updateButtonLabels];
    [self.avcController updateHudButtons:hudHidden];

    
    if (gSingleton.showTrace)
        NSLog(@"MainViewController viewDidLoad");
    [self updateAvcHolderView];
    [self updatePtHolderView];
    [self updateSsHolderView];
    [self updateTogHolderView];
    [self updateRvHolderView];
    [self updateNavView];
    [self updateHeaderView];
    
    [super viewDidLoad];
    
    
    [self.avcHolderView addSubview:self.avcController.view];
    [self.ptHolderView addSubview:self.ptController.view];
    [self.rvHolderView addSubview:self.rvController.view];
    
    
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
    
    refTimer = [NSTimer scheduledTimerWithTimeInterval:0.5
                                                target:self selector:@selector(doRefTimer:)
                                              userInfo:nil
                                               repeats:YES];
}

- (void)doRefTimer:(NSTimer *)timer
{
    
    //[refTimer invalidate];
    //refTimer = nil;
    
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
        
        [self updateTableView];
        [self updateButtonLabels];
        
        [[NSNotificationCenter defaultCenter]
         postNotificationName:@"clearEvent"
         object:nil ];
    }
}

-(void)eventHandlerLabel: (NSNotification *) notification
{
    if (gSingleton.showTrace)
        NSLog(@"labelEvent (MainViewController)");
    
    if (gSingleton.currentAppState == PHASLabelFS)
    {
        gSingleton.currentAppState = PHASViewfinder;
        gSingleton.editOn = NO;
        
        [self updateButtonLabels];
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
    
    if (!myTimer) {
        myTimer = [NSTimer scheduledTimerWithTimeInterval:0.4
                                                   target:self selector:@selector(camTimer:)
                                                 userInfo:nil
                                                  repeats:NO];
        
    }
    
}

-(void)eventHandlerGalScroll: (NSNotification *) notification
{
    
    if (gSingleton.dirContents.count > 0)
    {
        NSMutableDictionary* dict = [gSingleton.infoDict objectForKey:[gSingleton.dirContents objectAtIndex:gSingleton.relativeIndex]];
        NSString* label = [dict objectForKey:@"label"];
        NSString* description = [dict objectForKey:@"description"];
        gSingleton.currentLabelString = label;
        gSingleton.currentLabelDescription = description;

        if ([description length] == 0)
            self.curLabItem.title = label;
        else
            self.curLabItem.title = description;
    }
    
    //self.curLabItem.title = [self.ptController.showcaseView textForItemAtIndex:gSingleton.relativeIndex];
    
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
    
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"clearEvent"
     object:nil ];
    
    [gSingleton saveList];
    
    // we just deleted all the selected items, clear the selected array
    [gSingleton clearAllKeys];
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
    
    [self updateButtonLabels];

}

-(void) expandAction:(id) sender{
    
    gSingleton.expandOn = !gSingleton.expandOn;
    
    if (gSingleton.expandOn) {
        gSingleton.currentAppState = PHASExpanded;
        
        
        if (gSingleton.currentFilterMode != PHFilterModeAll) {
            gSingleton.currentFilterMode = PHFilterModeAll;
            [[NSNotificationCenter defaultCenter]
             postNotificationName:@"clearEvent"
             object:nil ];     
        }
        
        [[NSNotificationCenter defaultCenter]
         postNotificationName:@"expandOnEvent"
         object:nil ];
    }
    else {
        gSingleton.currentAppState = PHASGrid;
        
        
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
    hudHidden = !hudHidden;
    [self.avcController updateHudButtons:hudHidden];
}

-(void) labAction:(id) sender{
    gSingleton.currentAppState = PHASLabelFS;
    
    [self updateButtonLabels];
}

-(void) editAction:(id) sender{
    if (gSingleton.editOn)
    {
        [gSingleton saveList];        
    }
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
    }
    
    if ([gSingleton.currentLabelDescription length] > 0)
        self.curLabItem.title = gSingleton.currentLabelDescription;
    else
        self.curLabItem.title = gSingleton.currentLabelString;
    
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
    
    int lCount = 0;
    for(id key in gSingleton.infoDict)
    {        
        NSDictionary *dict = [gSingleton.infoDict objectForKey:key];
        id value = [dict objectForKey:@"label"];
        id desc = [dict objectForKey:@"description"];

        if (gSingleton.showTrace)
        {
            if ([value isEqualToString:@"Other: With Description"])
                NSLog(@"infoDict read: %@ for label Other: %@", key, desc);
            else
                NSLog(@"infoDict read: %@ for label %@", key, value);
        }
        
        if ([value isEqualToString:[gSingleton.labelArr objectAtIndex:0]])
        {
            // no op
        }
        else
        {
            lCount++;
        }
    }
    if (gSingleton.showTrace)
        NSLog(@"Required: %d     Labeled: %d     Total: %d", gSingleton.requiredCount, lCount, gSingleton.photoCount);
    
    [titleLabel setText:[NSString stringWithFormat:@"Required: %d     Labeled: %d     Total: %d", gSingleton.requiredCount, lCount, gSingleton.photoCount ]];
    
    //self.nreqCountItem.title = [NSString stringWithFormat:@"%d",[gSingleton.requiredLabelArr count]];
    //self.nlabCountItem.title = [NSString stringWithFormat:@"%d",lCount];
    //self.ntotCountItem.title = [NSString stringWithFormat:@"%d",gSingleton.photoCount];
    
    self.navViewController.toolbar.items = [bbarItems objectAtIndex:gSingleton.currentAppState];
    [self.navViewController.toolbar setNeedsDisplay];
    
    [self layoutForOrientation:[self interfaceOrientation]];
}

- (void)viewDidUnload
{
    if (gSingleton.showTrace)
        NSLog(@"MainViewController viewDidUnload");    
    [self setAvcHolderViewController:nil];
    [self setPtHolderViewController:nil];
    [self setSsHolderViewController:nil];
    [self setTogHolderViewController:nil];
    [self setRvHolderViewController:nil];
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
	return YES;
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
    navView.frame = CGRectMake(0, h-toolbarHeight, w, toolbarHeight);
    
    [self.headerViewController.toolbar sizeToFit];
    headerView.frame = CGRectMake(0, 0, w, toolbarHeight);
    
    
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
    
    rvHolderView.hidden = NO;
    avcHolderView.hidden = NO;
    ptHolderView.hidden = NO;
    ssHolderView.hidden = NO;
    togHolderView.hidden = NO;
    
    
    switch (gSingleton.currentAppState)
    {
        case PHASLabelFS:
            
            //[self.rvController.searchDC.searchBar setHidden:YES];
            
            avcHolderView.hidden = YES;
            ptHolderView.hidden = YES;
            ssHolderView.hidden = YES;
            togHolderView.hidden = YES;
            
            contentPaneWidth = w - (borderSize * 2);
            contentPaneHeight = h - ((toolbarHeight * 2) + (borderSize * 2));
            rvHolderView.frame =  CGRectMake(borderSize, borderSize+toolbarHeight, contentPaneWidth, contentPaneHeight);
            
            break;
        
        case PHASViewfinder:
            
            rvHolderView.hidden = YES;
            ptHolderView.hidden = YES;
            ssHolderView.hidden = YES;
            togHolderView.hidden = YES;
            
            contentPaneWidth = w - (borderSize * 2);
            contentPaneHeight = h - (toolbarHeight + (borderSize * 2));
            avcHolderView.frame = CGRectMake(borderSize, borderSize+toolbarHeight, contentPaneWidth, contentPaneHeight);
            
            break;
            
        default:
            
            avcHolderView.hidden = YES;
            
            if (gSingleton.editOn)
            {
                contentPaneWidth = (w - (borderSize * 2)) / 2;
                contentPaneHeight = h - ((toolbarHeight * 2) + (borderSize * 2));
                ptHolderView.frame =  CGRectMake(borderSize, borderSize+toolbarHeight, contentPaneWidth, contentPaneHeight);
                
                rvHolderView.frame =  CGRectMake(leftPaneWidth + borderSize, borderSize+toolbarHeight, rightPaneWidth - (borderSize*2), contentPaneHeight);
                ssHolderView.frame = CGRectMake(rvHolderView.frame.origin.x, rvHolderView.frame.origin.y, rvHolderView.frame.size.width, toolbarHeight);
                togHolderView.frame = CGRectMake(rvHolderView.frame.origin.x, rvHolderView.frame.origin.y+rvHolderView.frame.size.height-toolbarHeight, rvHolderView.frame.size.width, toolbarHeight);
            }
            else
            {
                ssHolderView.hidden = YES;
                rvHolderView.hidden = YES;
                togHolderView.hidden = YES;
                
                contentPaneWidth = w - (borderSize * 2);
                contentPaneHeight = h - ((toolbarHeight * 2) + (borderSize * 2));
                ptHolderView.frame =  CGRectMake(borderSize, borderSize+toolbarHeight, contentPaneWidth, contentPaneHeight);
                rvHolderView.frame =  CGRectMake(borderSize, borderSize+toolbarHeight, contentPaneWidth, contentPaneHeight);
            }
            
            // send the notification event to any detail view controllers listening
            NSValue *rectValue = [NSValue valueWithCGRect:CGRectMake(0, 0, ptHolderView.frame.size.width, ptHolderView.frame.size.height)];
            NSDictionary *userInfo = [NSDictionary dictionaryWithObject:rectValue forKey:@"rectValue"];

            [[NSNotificationCenter defaultCenter]
             postNotificationName:@"contentFrameChangedEvent"
             object:nil
             userInfo:userInfo];

            break;
    }
    
    int flagVal = 0;
    int rvViewTop = 0;
    
    if (!ssHolderView.hidden)
    {
        rvViewTop = ssHolderView.frame.size.height;
        flagVal++;
    }
    if (!togHolderView.hidden)
    {
        flagVal++;
    }
    
    /////
    
    self.avcController.view.frame = CGRectMake(0, 0, avcHolderView.frame.size.width, avcHolderView.frame.size.height);
    self.ptController.view.frame = CGRectMake(0, 0, ptHolderView.frame.size.width, ptHolderView.frame.size.height);
    self.rvController.view.frame = CGRectMake(0, rvViewTop, rvHolderView.frame.size.width, rvHolderView.frame.size.height-toolbarHeight*flagVal);    
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
