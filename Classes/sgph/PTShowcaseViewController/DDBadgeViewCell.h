#import <UIKit/UIKit.h>

@class DDBadgeView;

@interface DDBadgeViewCell : UITableViewCell {

	DDBadgeView *	badgeView;
	
	NSString *		summary;
	NSString *		detail;
	NSString *		badgeText;
	UIColor *		badgeColor;
	UIColor *		badgeHighlightedColor;
}

@property (nonatomic, strong) DDBadgeView * badgeView;
@property (nonatomic, strong) NSString *    summary;
@property (nonatomic, strong) NSString *    detail;
@property (nonatomic, strong) NSString *	badgeText;
@property (nonatomic, strong) UIColor *		badgeColor;
@property (nonatomic, strong) UIColor *		badgeHighlightedColor;

@end
