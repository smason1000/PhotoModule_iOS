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

@property (nonatomic, retain) DDBadgeView * badgeView;
@property (nonatomic, retain) NSString *    summary;
@property (nonatomic, retain) NSString *    detail;
@property (nonatomic, retain) NSString *	badgeText;
@property (nonatomic, retain) UIColor *		badgeColor;
@property (nonatomic, retain) UIColor *		badgeHighlightedColor;

@end
