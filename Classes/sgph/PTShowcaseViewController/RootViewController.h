#import <UIKit/UIKit.h>

//@class PTAppDelegate;

@interface RootViewController : UITableViewController <UISearchDisplayDelegate/*, UISearchBarDelegate*/>
{
    NSArray*        emptyArray;
    NSMutableArray* _filteredListContent;
}

@property (nonatomic, strong) NSMutableArray *filteredListContent;

@end
