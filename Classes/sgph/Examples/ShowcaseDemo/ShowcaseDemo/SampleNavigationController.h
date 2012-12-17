#import <UIKit/UIKit.h>

@interface SampleNavigationController : UINavigationController

- (id)initWithName:(NSString *)name;

@property (nonatomic, weak) NSString *name;

@end
