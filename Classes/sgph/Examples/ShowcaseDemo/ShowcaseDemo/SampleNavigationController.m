#import "SampleNavigationController.h"

@implementation SampleNavigationController

@synthesize name = _name;

- (id)initWithName:(NSString *)name
{
    if (gSingleton.showTrace)
        NSLog(@"[NavigationController] (%@) init", name);
    
    self = [super init];
    if (self)
    {
        self.name = name;
        
        // Custom initialization
        [[self view] setBackgroundColor:[UIColor blackColor]];
    }
    return self;
}

- (void)dealloc
{
    NSLog(@"[NavigationController] dealloc %@", self.name);
    self.name = nil;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    if (gSingleton.showTrace)
        NSLog(@"[NavigationController] (%@) didReceiveMemoryWarning", self.name);
    // Release any cached data, images, etc that aren't in use.
}

- (void)layoutForOrientation:(UIInterfaceOrientation)orientation
{

}

- (void)updateLayout
{
    [self layoutForOrientation:[[UIApplication sharedApplication] statusBarOrientation]];
    
    [self setToolbarHidden:NO];
    [self setNavigationBarHidden:YES];
}

#pragma mark - View lifecycle


// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    [super loadView];
    if (gSingleton.showTrace)
        NSLog(@"[NavigationController] (%@) loadView", self.name);
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    if (gSingleton.showTrace)
        NSLog(@"[NavigationController] (%@) viewDidLoad", self.name);
    
    [super viewDidLoad];
    [self updateLayout];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    if (gSingleton.showTrace)
        NSLog(@"[NavigationController] (%@) viewDidUnload", self.name);
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if (gSingleton.showTrace)
        NSLog(@"[NavigationController] (%@) shouldAutorotateToInterfaceOrientation", self.name);
    // Return YES for supported orientations
	return interfaceOrientation == UIInterfaceOrientationMaskPortrait;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    if (gSingleton.showTrace)
        NSLog(@"[NavigationController] (%@) willRotateToInterfaceOrientation", self.name);
    
    __unsafe_unretained SampleNavigationController *weakSelf = self;
    [UIView animateWithDuration:duration animations:^{
        [weakSelf layoutForOrientation:toInterfaceOrientation];
    }];
}

@end