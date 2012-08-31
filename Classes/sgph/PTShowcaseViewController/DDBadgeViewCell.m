#import <QuartzCore/QuartzCore.h>
#import "DDBadgeViewCell.h"

#pragma mark -
#pragma mark DDBadgeView declaration

@interface DDBadgeView : UIView {
    DDBadgeViewCell *cell;
}

@property (nonatomic, retain) DDBadgeViewCell *cell;
- (id)initWithFrame:(CGRect)frame cell:(DDBadgeViewCell *)newCell;
@end

    
#pragma mark -
#pragma mark DDBadgeView implementation

@implementation DDBadgeView 

@synthesize cell = cell;

#pragma mark -
#pragma mark init

- (id)initWithFrame:(CGRect)frame cell:(DDBadgeViewCell *)newCell {
	
	if ((self = [super initWithFrame:frame])) {
		cell = newCell;
		
		self.backgroundColor = [UIColor clearColor];
		self.layer.masksToBounds = YES;
	}
	return self;
}

#pragma mark -
#pragma mark redraw

- (void)drawRect:(CGRect)rect {	

	//CGContextRef context = UIGraphicsGetCurrentContext();

    UIColor *currentSummaryColor = [UIColor blackColor];
    UIColor *currentDetailColor = [UIColor grayColor];
    UIColor *currentBadgeColor = self.cell.badgeColor;
    if (!currentBadgeColor) {
        currentBadgeColor = [UIColor colorWithRed:0.53 green:0.6 blue:0.738 alpha:1.];
    }
    
	if (self.cell.isHighlighted || self.cell.isSelected) {
        currentSummaryColor = [UIColor whiteColor];
        currentDetailColor = [UIColor whiteColor];
		currentBadgeColor = self.cell.badgeHighlightedColor;
		if (!currentBadgeColor) {
			currentBadgeColor = [UIColor whiteColor];
		}
	} 
	
    
	if (self.cell.isEditing) {
		[currentSummaryColor set];
		[self.cell.summary drawAtPoint:CGPointMake(10, 10) forWidth:rect.size.width withFont:[UIFont boldSystemFontOfSize:18.] lineBreakMode:UILineBreakModeTailTruncation];
		
		[currentDetailColor set];
		[self.cell.detail drawAtPoint:CGPointMake(10, 32) forWidth:rect.size.width withFont:[UIFont systemFontOfSize:14.] lineBreakMode:UILineBreakModeTailTruncation];		
	} else {
		CGSize badgeTextSize = [self.cell.badgeText sizeWithFont:[UIFont boldSystemFontOfSize:13.0]];
		CGRect badgeViewFrame = CGRectIntegral(CGRectMake(
                                                rect.size.width - badgeTextSize.width - 24,
                                                (rect.size.height - badgeTextSize.height - 4) / 2,
                                                badgeTextSize.width + 14,
                                                badgeTextSize.height + 4
                                            ));
		
		/*
        CGContextSaveGState(context);	
		CGContextSetFillColorWithColor(context, currentBadgeColor.CGColor);
		CGMutablePathRef path = CGPathCreateMutable();
		CGPathAddArc(path, NULL, badgeViewFrame.origin.x + badgeViewFrame.size.width - badgeViewFrame.size.height / 2, badgeViewFrame.origin.y + badgeViewFrame.size.height / 2, badgeViewFrame.size.height / 2, M_PI / 2, M_PI * 3 / 2, YES);
		CGPathAddArc(path, NULL, badgeViewFrame.origin.x + badgeViewFrame.size.height / 2, badgeViewFrame.origin.y + badgeViewFrame.size.height / 2, badgeViewFrame.size.height / 2, M_PI * 3 / 2, M_PI / 2, YES);
		CGContextAddPath(context, path);
		CGContextDrawPath(context, kCGPathFill);
		CFRelease(path);
		CGContextRestoreGState(context);
		
		CGContextSaveGState(context);	
		CGContextSetBlendMode(context, kCGBlendModeClear);
		[self.cell.badgeText drawInRect:CGRectInset(badgeViewFrame, 7, 2) withFont:[UIFont boldSystemFontOfSize:13.]];
		CGContextRestoreGState(context);
		*/
		[currentSummaryColor set];
		[self.cell.summary drawAtPoint:CGPointMake(10, 10) forWidth:(rect.size.width - badgeViewFrame.size.width - 24) withFont:[UIFont boldSystemFontOfSize:14.0] lineBreakMode:UILineBreakModeTailTruncation];
		
		//[currentDetailColor set];
		//[self.cell.detail drawAtPoint:CGPointMake(10, 32) forWidth:(rect.size.width - badgeViewFrame.size.width - 24) withFont:[UIFont systemFontOfSize:12.0] lineBreakMode:UILineBreakModeTailTruncation];		
	}
}

@end

#pragma mark -
#pragma mark DDBadgeViewCell private

#pragma mark -
#pragma mark DDBadgeViewCell implementation

@implementation DDBadgeViewCell

@synthesize summary;
@synthesize detail;
@synthesize badgeView;
@synthesize badgeText;
@synthesize badgeColor;
@synthesize badgeHighlightedColor;

#pragma mark -
#pragma mark init & dealloc

- (void)dealloc {

	
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
	
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
		badgeView = [[DDBadgeView alloc] initWithFrame:self.contentView.bounds cell:self];
        badgeView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        badgeView.contentMode = UIViewContentModeRedraw;
		badgeView.contentStretch = CGRectMake(1., 0., 0., 0.);
        [self.contentView addSubview:badgeView];
    }
    return self;
}

#pragma mark -
#pragma mark accessors

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

    [super setSelected:selected animated:animated];
		
	[self.badgeView setNeedsDisplay];
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {

	[super setHighlighted:highlighted animated:animated];
		
	[self.badgeView setNeedsDisplay];
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
	
	[super setEditing:editing animated:animated];

	[self.badgeView setNeedsDisplay];
}

@end
