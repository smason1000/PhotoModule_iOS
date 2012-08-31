#import "NINetworkImageView.h"

#import "PTShowcase.h"

@interface PTPdfThumbnailImageView : NINetworkImageView

@property (nonatomic, assign) PTItemOrientation orientation;

+ (UIImage *)applyMask:(UIImage *)image forOrientation:(PTItemOrientation)orientation;

@end
