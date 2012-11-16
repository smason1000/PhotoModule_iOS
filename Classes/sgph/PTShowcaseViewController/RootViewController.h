#import <UIKit/UIKit.h>

//@class PTAppDelegate;

@interface RootViewController : UITableViewController <UISearchDisplayDelegate/*, UISearchBarDelegate*/>
{
    //PTAppDelegate *ptAppDelegate;
    NSArray* emptyArray;
    NSMutableArray* filteredListContent;
    //UISearchDisplayController *searchDC;
}

//@property (nonatomic, retain) PTAppDelegate *ptAppDelegate;
@property (nonatomic, strong) NSMutableArray *filteredListContent;
//@property (nonatomic, strong) UISearchDisplayController *searchDC;

@end
