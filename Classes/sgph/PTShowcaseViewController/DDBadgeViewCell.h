#import <UIKit/UIKit.h>

@class DDBadgeView;

@interface DDBadgeViewCell : UITableViewCell
{
	DDBadgeView *	_badgeView;
	
	NSString *		_summary;
//	NSString *		_detail;
	NSString *		_badgeText;
	UIColor *		_badgeColor;
	UIColor *		_badgeHighlightedColor;
}

@property (nonatomic, strong) DDBadgeView * badgeView;
@property (nonatomic, strong) NSString *    summary;
//@property (nonatomic, strong) NSString *    detail;
@property (nonatomic, strong) NSString *	badgeText;
@property (nonatomic, strong) UIColor *		badgeColor;
@property (nonatomic, strong) UIColor *		badgeHighlightedColor;

@end
