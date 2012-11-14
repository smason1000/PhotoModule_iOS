#import <UIKit/UIKit.h>

//@class PTAppDelegate;

@interface RootViewController : UITableViewController <UISearchDisplayDelegate/*, UISearchBarDelegate*/>
{
    //PTAppDelegate *ptAppDelegate;
    NSArray* emptyArray;
    NSMutableArray *__weak filteredListContent;
    //UISearchDisplayController *searchDC;
}

//@property (nonatomic, retain) PTAppDelegate *ptAppDelegate;
@property (weak, nonatomic) NSMutableArray *filteredListContent;
//@property (nonatomic, strong) UISearchDisplayController *searchDC;

@end
