#import <Foundation/Foundation.h>

@class AVCaptureConnection;

@interface AVCamUtilities : NSObject
{

}

+ (AVCaptureConnection *)connectionWithMediaType:(NSString *)mediaType fromConnections:(NSArray *)connections;
+ (UIImage *)imageRotatedByDegrees:(UIImage *)imageToRotate degreesToRotate:(CGFloat)degrees;

@end
