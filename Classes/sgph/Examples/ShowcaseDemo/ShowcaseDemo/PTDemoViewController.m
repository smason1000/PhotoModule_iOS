#import "PTDemoViewController.h"

@interface PTDemoViewController ()

@property (weak, nonatomic, readonly) NSArray *demoItems;

- (NSArray *)recursiveSearchForItems:(NSArray *)root forUniqueName:(NSString *)uniqueName;

@end

@implementation PTDemoViewController

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

/*
UITabBarItem *tabBarItem = [self tabBarItem];
//UIImage *tabBarImage = [UIImage imageNamed:@"YOUR_IMAGE_NAME.png"];
//[tabBarItem setImage:tabBarImage];
[tabBarItem setTitle:@"Images"];
*/

#pragma mark - private

- (NSArray *)recursiveSearchForItems:(NSArray *)root forUniqueName:(NSString *)uniqueName
{
    
    /*
    if (photos == nil) {
        [self loadPhotos];
    }
    else {
        [self photosComplete];
    }
    */
    
    if (root == nil) {
        return nil;
    }
    
    if (uniqueName == nil) {
        return root;
    }
    
    for (NSDictionary *item in root) {
        if ([[item objectForKey:@"ContentType"] integerValue] == PTContentTypeGroup) {
            if ([uniqueName isEqualToString:[item objectForKey:@"UniqueName"]]) {
                return [item objectForKey:@"Items"];
            }
            
            NSArray *result = [self recursiveSearchForItems:[item objectForKey:@"Items"] forUniqueName:uniqueName];
            if (result) {
                return result;
            }
        }
    }
    
    return nil;
}




- (NSArray *)demoItems
{
    return nil;//[[NSDictionary dictionaryWithContentsOfFile:NIPathForBundleResource(nil, @"ShowcaseDemo.plist")] objectForKey:@"Root"];
}

#pragma mark - View lifecycle

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];

    ////////////////////////////////////////////////////////////////////////////

    /*
     * Optionally change navigation bar color application-wide via appearance
     * proxy (as below), or any other method as you see fit
     */
    [UINavigationBar.appearance setBarStyle:UIBarStyleBlack];
    
    /*
     * Some example 'backgroundColor' values are below, but you can come up with
     * anything you like:
     *
     * - 2.0 and later: [UIColor viewFlipsideBackgroundColor]
     *                  [UIColor blackColor]
     *                  [UIColor whiteColor]
     * - 3.2 and later: [UIColor scrollViewTexturedBackgroundColor]
     * - 5.0 and later: [UIColor underPageBackgroundColor]
     */
    self.view.backgroundColor = [UIColor blackColor];//[UIColor scrollViewTexturedBackgroundColor]; // this is the default by the way ;-)
    
    ////////////////////////////////////////////////////////////////////////////
    
    
    
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    
    ////////////////////////////////////////////////////////////////////////////
    
    /*
     * Decide which interface orientations do you want to support (we can handle
     * them all!)
     */
    
    /*
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return interfaceOrientation == UIInterfaceOrientationPortrait;
    }
    */
    
    if (interfaceOrientation == UIInterfaceOrientationPortrait) return YES;
    if (interfaceOrientation == UIInterfaceOrientationLandscapeLeft) return YES;
    if (interfaceOrientation == UIInterfaceOrientationLandscapeRight) return YES;
    

    ////////////////////////////////////////////////////////////////////////////
    
    return NO;
}

////////////////////////////////////////////////////////////////////////////////

/*
 * Implement required and optional protocols.
 */

#pragma mark - PTShowcaseViewDelegate

- (PTItemOrientation)showcaseView:(PTShowcaseView *)showcaseView orientationForItemAtIndex:(NSInteger)index
{
    if (gSingleton.showTrace)
        NSLog(@"orientationForItemAtIndex()");
    return [[[[self recursiveSearchForItems:self.demoItems forUniqueName:showcaseView.uniqueName] objectAtIndex:index] objectForKey:@"Orientation"] integerValue];
}

#pragma mark - PTShowcaseViewDataSource



- (NSInteger)numberOfItemsInShowcaseView:(PTShowcaseView *)showcaseView
{
    if (gSingleton.showTrace)
        NSLog(@"numberOfItemsInShowcaseView()");
    return [[self recursiveSearchForItems:self.demoItems forUniqueName:showcaseView.uniqueName] count];
}

- (PTContentType)showcaseView:(PTShowcaseView *)showcaseView contentTypeForItemAtIndex:(NSInteger)index
{
    if (gSingleton.showTrace)
        NSLog(@"contentTypeForItemAtIndex()");
    return PTContentTypeImage;// [[[[self recursiveSearchForItems:self.demoItems forUniqueName:showcaseView.uniqueName] objectAtIndex:index] objectForKey:@"ContentType"] integerValue];
}

- (NSString *)showcaseView:(PTShowcaseView *)showcaseView pathForItemAtIndex:(NSInteger)index
{
    if (gSingleton.showTrace)
        NSLog(@"pathForItemAtIndex()");
    NSString *source = [[[self recursiveSearchForItems:self.demoItems forUniqueName:showcaseView.uniqueName] objectAtIndex:index] objectForKey:@"Source"];
    
    if (source != nil) {
        return NIPathForBundleResource(nil, [NSString stringWithFormat:@"ShowcaseDemo.bundle/%@", source]);
    }
    
    return nil;
}

- (NSString *)showcaseView:(PTShowcaseView *)showcaseView uniqueNameForItemAtIndex:(NSInteger)index
{
    if (gSingleton.showTrace)
        NSLog(@"uniqueNameForItemAtIndex()");
    return [[[self recursiveSearchForItems:self.demoItems forUniqueName:showcaseView.uniqueName] objectAtIndex:index] objectForKey:@"UniqueName"];
}

- (NSString *)showcaseView:(PTShowcaseView *)showcaseView sourceForThumbnailImageOfItemAtIndex:(NSInteger)index
{
    if (gSingleton.showTrace)
        NSLog(@"sourceForThumbnailImageOfItemAtIndex()");
    NSString *source = [[[self recursiveSearchForItems:self.demoItems forUniqueName:showcaseView.uniqueName] objectAtIndex:index] objectForKey:@"Thumbnail"];
    if (source != nil) {
        return NIPathForBundleResource(nil, [NSString stringWithFormat:@"ShowcaseDemo.bundle/%@", source]);
    }
    
    return nil;
}

- (NSString *)showcaseView:(PTShowcaseView *)showcaseView textForItemAtIndex:(NSInteger)index
{
    if (gSingleton.showTrace)
        NSLog(@"textForItemAtIndex()");
    return [[[self recursiveSearchForItems:self.demoItems forUniqueName:showcaseView.uniqueName] objectAtIndex:index] objectForKey:@"Title"];
}

////////////////////////////////////////////////////////////////////////////////

@end