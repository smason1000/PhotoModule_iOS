#import "MySingleton.h"
#import "RootViewController.h"
#import "DDBadgeViewCell.h"
#import "Photo.h"

@implementation RootViewController

//@synthesize ptAppDelegate;

//@synthesize searchDC;

#pragma mark -
#pragma mark View lifecycle

@synthesize filteredListContent = _filteredListContent;

- (void)viewDidLoad
{
    [super viewDidLoad];

    emptyArray = [NSArray arrayWithObjects:
                  nil];
    
    self.filteredListContent = [NSMutableArray arrayWithCapacity:200]; //[self.listContent count]
    
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(eventHandlerDelete:)
     name:@"delEvent"
     object:nil ];
}

-(void)dealloc
{
    NSLog(@"[RootViewController] dealloc");
    emptyArray = nil;
    self.filteredListContent = nil;

    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"delEvent" object:nil];
}
/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}
*/

/*
 // Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations.
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
 */


#pragma mark -
#pragma mark Table view data source

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == self.searchDisplayController.searchResultsTableView)
	{
        return 1;
    }
	else
	{
        return [gSingleton.curLetArray count];
    }
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //NSMutableArray* curArray;
    
    NSInteger curCount;
    
    if (tableView == self.searchDisplayController.searchResultsTableView)
	{
        return [self.filteredListContent count];
    }
	else
	{
        curCount = [[gSingleton.curHashVals objectAtIndex:section] count];
        
        return curCount;
    }
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"BadgeViewCell";
    
    DDBadgeViewCell *cell = (DDBadgeViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[DDBadgeViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
	// Configure the cell.
    
    if (tableView == self.searchDisplayController.searchResultsTableView)
	{
        cell.summary = [self.filteredListContent objectAtIndex:indexPath.row];
    }
	else
	{
        cell.summary = [[gSingleton.curHashVals objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    }
    
    //cell.detail = @"Detail text goes here";
    
    BOOL isReq = [gSingleton isReqLab:cell.summary];
    
    
    if (gSingleton.filterOn)
    {
        cell.contentView.backgroundColor = [UIColor whiteColor];
    }
    else
    {
        if (isReq)
        {
            cell.contentView.backgroundColor = [UIColor yellowColor];
        }
        else
        {
            cell.contentView.backgroundColor = [UIColor whiteColor];
        }
    }
     
    return cell;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{    
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        // Delete the row from the data source.
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert)
    {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark -
#pragma mark Table view delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *description = [[alertView textFieldAtIndex:0] text];

    if ([description length] == 0)
    {
    	[self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:NO];
    }
    else
    {
        gSingleton.currentLabelDescription = description;
        [self applyLabelSelection];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (gSingleton.showTrace)
        NSLog(@"RootViewController: didSelectRowAtIndexPath (%d)", [indexPath row]);
    
	/*
	 <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
	 [self.navigationController pushViewController:detailViewController animated:YES];
	 [detailViewController release];
    */
	
    
    /*
    static NSString *CellIdentifier = @"Cell";
    
    DDBadgeViewCell *cell = (DDBadgeViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[DDBadgeViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    */
    
    //DDBadgeViewCell *cell = (DDBadgeViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    if (tableView == self.searchDisplayController.searchResultsTableView)
	{
        gSingleton.currentLabelString = [self.filteredListContent objectAtIndex:indexPath.row];
    }
	else
	{
        gSingleton.currentLabelString = [ [gSingleton.curHashVals objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    }

    if ([gSingleton.currentLabelString isEqualToString:@"Other: With Description"])
    {
        // user selected other, we need to gather the description
        if (gSingleton.showTrace)
            NSLog(@"Other selected, getting description...");
        
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Description is required" delegate:self cancelButtonTitle:@"Continue" otherButtonTitles:nil];
        alert.alertViewStyle = UIAlertViewStylePlainTextInput;
        UITextField * alertTextField = [alert textFieldAtIndex:0];
        alertTextField.keyboardType = UIKeyboardTypeAlphabet;
        alertTextField.placeholder = @"Enter your description";
        [alert show];
        //[alert release];
    }
    else
    {
        gSingleton.currentLabelDescription = @"";
        [self applyLabelSelection];
    }
}

-(void) applyLabelSelection
{
    //[self.searchDC.searchBar resignFirstResponder];
    
    //labelClicked(indexPath.row);

    if ([gSingleton.currentLabelDescription length] > 0)
        NSLog(@"Entered description: '%@'", gSingleton.currentLabelDescription);
    
    BOOL wasLabeled;
    BOOL isLabeled;
    
    if (gSingleton.expandOn)
    {
        if (gSingleton.expandedViewIndex >= 0)
        {
            Photo *photo = [gSingleton.mainData objectAtIndex:gSingleton.expandedViewIndex];
            wasLabeled = !([photo.label isEqualToString:[gSingleton.labelArr objectAtIndex:0]]);
        
            photo.label = gSingleton.currentLabelString;
            photo.description = gSingleton.currentLabelDescription;
            [photo updateDatabaseEntry];

            isLabeled = !([photo.label isEqualToString:[gSingleton.labelArr objectAtIndex:0]]);
            if (wasLabeled != isLabeled)
            {
                if (wasLabeled)
                    gSingleton.labeledCount--;
                else
                    gSingleton.labeledCount++;
            }
        }
    }
    else
    {
        for (Photo *photo in gSingleton.mainData)
        {
            if (photo.selected)
            {
                wasLabeled = !([photo.label isEqualToString:[gSingleton.labelArr objectAtIndex:0]]);

                photo.label = gSingleton.currentLabelString;
                photo.description = gSingleton.currentLabelDescription;
                [photo updateDatabaseEntry];

                isLabeled = !([photo.label isEqualToString:[gSingleton.labelArr objectAtIndex:0]]);
                if (wasLabeled != isLabeled)
                {
                    if (wasLabeled)
                        gSingleton.labeledCount--;
                    else
                        gSingleton.labeledCount++;
                }
            }
        }
    }
    
    // deselect the label row
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:NO];

    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"labelEvent"
     object:nil ];
}

-(void)eventHandlerDelete:(NSNotification *) notification
{
    if (gSingleton.expandOn)
    {
        if (gSingleton.expandedViewIndex >= 0)
        {
            Photo *photo = [gSingleton.mainData objectAtIndex:gSingleton.expandedViewIndex];
            [gSingleton delImage:photo];
        
            gSingleton.expandOn = NO;
            [[NSNotificationCenter defaultCenter]
             postNotificationName:@"expandOffEvent"
             object:nil ];
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

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    if (tableView == self.searchDisplayController.searchResultsTableView)
	{
        return emptyArray;
    }
	else
	{
        return gSingleton.curLetArray;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{    
    NSInteger curCount;
    
    if (tableView == self.searchDisplayController.searchResultsTableView)
	{
        return @"";
    }
	else
	{
        curCount = [[gSingleton.curHashVals objectAtIndex:section] count];
        
        if (curCount == 0)
        {
            return nil;
        }
        else
        {
            return [gSingleton.curLetArray objectAtIndex:section];
        }
    }
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index 
{
    int result = 0;
    
    int testLetter = [title characterAtIndex:0];
    if (testLetter >= 65 && testLetter <= 90)
    {
        testLetter += 32;
    }
    if (testLetter < 97)
    {
        // no op
    }
    else
    {
        result = (testLetter - 96);
    }
    return result;
}

//


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload
{
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}

//@@@@@@@@@@@@@@

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{	
    //NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    //[self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionNone animated:YES];
    
    
	[self.filteredListContent removeAllObjects]; // First clear the filtered array.
    
    if (gSingleton.filterOn)
    {
        for (NSString *laString in gSingleton.requiredLabelArr)
        {
            NSComparisonResult result = [laString compare:searchText options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, [searchText length])];
            if (result == NSOrderedSame || [searchText isEqualToString:@""])
            {
                [self.filteredListContent addObject:laString];
            }
        }
    }
    else
    {
        for (NSString *laString in gSingleton.labelArr)
        {
            NSComparisonResult result = [laString compare:searchText options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, [searchText length])];
            if (result == NSOrderedSame || [searchText isEqualToString:@""])
            {
                [self.filteredListContent addObject:laString];
            }
        }
    }
}

/*
#pragma mark -
#pragma mark UISearchDisplayController Delegate Methods

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    
    [self filterContentForSearchText:searchString scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}


- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption
{
    [self filterContentForSearchText:[self.searchDisplayController.searchBar text] scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:searchOption]];
    
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}
*/

//@@@@@@@@@@@@@@

@end
