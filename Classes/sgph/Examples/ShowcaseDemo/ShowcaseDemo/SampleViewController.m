#import "SampleViewController.h"

@implementation SampleViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [[self view] setBackgroundColor:[UIColor blackColor]];
    }
    if (gSingleton.showTrace)
        NSLog(@"SampleViewController initWithNibName");
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    if (gSingleton.showTrace)
        NSLog(@"SampleViewController didReceiveMemoryWarning");
    // Release any cached data, images, etc that aren't in use.
}

- (void)layoutForOrientation:(UIInterfaceOrientation)orientation
{

}

- (void)updateLayout
{
    [self layoutForOrientation:[[UIApplication sharedApplication] statusBarOrientation]];
    
    //[self setToolbarHidden:NO];
    //[self setNavigationBarHidden:YES];
}

#pragma mark - View lifecycle


// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    [super loadView];
    if (gSingleton.showTrace)
        NSLog(@"SampleViewController loadView");
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    if (gSingleton.showTrace)
        NSLog(@"SampleViewController viewDidLoad");
    
    [super viewDidLoad];
    [self updateLayout];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    if (gSingleton.showTrace)
        NSLog(@"SampleViewController viewDidUnload");    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if (gSingleton.showTrace)
        NSLog(@"SampleViewController shouldAutorotateToInterfaceOrientation");
    // Return YES for supported orientations
	return interfaceOrientation == UIInterfaceOrientationMaskPortrait;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    if (gSingleton.showTrace)
        NSLog(@"SampleViewController willRotateToInterfaceOrientation");
    [UIView animateWithDuration:duration animations:^{
        [self layoutForOrientation:toInterfaceOrientation];
    }];
}

@end
