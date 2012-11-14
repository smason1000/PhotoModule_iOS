#import <UIKit/UIKit.h>

#import "PTShowcaseViewDelegate.h"
#import "PTShowcaseViewDataSource.h"

#import "PTShowcaseView.h"

@interface PTShowcaseViewController : UIViewController <PTShowcaseViewDelegate, PTShowcaseViewDataSource> {
    BOOL detailOn;
}

@property (nonatomic, strong) PTShowcaseView *showcaseView;
@property (nonatomic) BOOL detailOn;

- (id)initWithUniqueName:(NSString *)uniqueName;

@end
