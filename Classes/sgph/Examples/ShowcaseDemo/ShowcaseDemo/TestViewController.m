//
//  TestViewController.m
//  PhotoHub
//
//  Created by Scott Mason on 12/14/12.
//  Copyright (c) 2012 Apex-net srl. All rights reserved.
//

#import "TestViewController.h"
#import "PhotoHubLib.h"

@interface TestViewController ()

@end

@implementation TestViewController

@synthesize headerView = _headerView;
@synthesize headerViewController = _headerViewController;
@synthesize backButton = _backButton;
@synthesize myPhotoHubLib = _myPhotoHubLib;

#pragma mark Initialization

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.backButton = [[UIBarButtonItem alloc] initWithTitle:@"Startup"
                                                           style:UIBarButtonItemStyleBordered
                                                          target:self
                                                          action:@selector(backButtonAction:)];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

    // initialize title bar
    [self initHeaderViewController:[[SampleNavigationController alloc] initWithName:@"Titlebar"]];
    self.headerView = [[UIView alloc] init];
    [self.headerView addSubview:self.headerViewController.view];
    [self.view addSubview:self.headerView];
    
    UIBarButtonItem *flexible = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    self.headerViewController.toolbar.items = [NSArray arrayWithObjects:
                                               self.backButton,
                                               flexible,
                                               nil];
    [self.headerViewController.toolbar sizeToFit];
    self.headerView.frame = CGRectMake(0, 0, self.view.frame.size.width, 44);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Instance Methods

- (void)updateHeaderView
{
    self.headerViewController.view.frame = self.headerView.bounds;
    [self.headerView addSubview:self.headerViewController.view];
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

-(void)setView:(UIView *)view positionRect:(CGRect)frameRect
{
#if	USEFRAME
	[view setFrame:frameRect];
	return;
#endif
	
	CGPoint anchorPoint = [[view layer] anchorPoint];
	CGPoint newCenter;
	newCenter.x = frameRect.origin.x + (anchorPoint.x * frameRect.size.width);
	newCenter.y = frameRect.origin.y + (anchorPoint.y * frameRect.size.height);
	CGRect newBounds = CGRectMake(0, 0, frameRect.size.width, frameRect.size.height);
    
	[view setBounds:newBounds];
	[view setCenter:newCenter];
}

-(void) backButtonAction:(id) sender
{
    if ([self.backButton.title isEqualToString:@"Startup"])
    {
        [[self backButton] setTitle:@"Shutdown"];
        [self startup];
    }
    else
    {
        [[self backButton] setTitle:@"Startup"];
        [self shutdown];
    }
}

-(void)startup
{
    myPhotoHubLib = [[PhotoHubLib alloc] init];
    
    [myPhotoHubLib initAll];
    gSingleton.isModule = NO;
    CGRect bounds = CGRectMake(0, self.headerView.frame.size.height, self.view.frame.size.width, self.view.frame.size.height - self.headerView.frame.size.height);
    [self setView:myPhotoHubLib.mainViewController.view positionRect:bounds];
    [myPhotoHubLib.mainViewController setBoundsAndLayout:bounds];
    [self.view addSubview:myPhotoHubLib.mainViewController.view];
}

-(void)shutdown
{
    if (myPhotoHubLib != nil)
    {
        [myPhotoHubLib shutdown];
        myPhotoHubLib = nil;
    }
}

@end
