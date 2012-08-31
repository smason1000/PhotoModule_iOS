
#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@class AVCamRecorder;
@protocol AVCamCaptureManagerDelegate;

@interface AVCamCaptureManager : NSObject {
    NSString* curLS;

@private
    // Capture Session
    AVCaptureSession *_session;
    AVCaptureVideoOrientation _orientation;
    AVCamMirroringMode _mirroringMode;
    
    // Devic Inputs
    AVCaptureDeviceInput *_videoInput;
    AVCaptureDeviceInput *_audioInput;
    
    // Capture Outputs
    AVCaptureMovieFileOutput *_movieFileOutput;
    AVCaptureStillImageOutput *_stillImageOutput;
    
    // Identifiers for connect/disconnect notifications
    id _deviceConnectedObserver;
    id _deviceDisconnectedObserver;
    
    // Identifier for background completion of recording
    UIBackgroundTaskIdentifier _backgroundRecordingID; 
    
    // Capture Manager delegate
    id <AVCamCaptureManagerDelegate> _delegate;
}

@property (nonatomic, strong) AVCaptureSession *session;
@property (nonatomic,assign) AVCaptureVideoOrientation orientation;
@property (nonatomic, strong) AVCaptureDeviceInput *videoInput;
@property (nonatomic, strong) AVCaptureDeviceInput *audioInput;
@property (nonatomic, strong) AVCaptureStillImageOutput *stillImageOutput;
@property (nonatomic, strong) AVCamRecorder *recorder;
@property (nonatomic,unsafe_unretained) id deviceConnectedObserver;
@property (nonatomic,unsafe_unretained) id deviceDisconnectedObserver;
@property (nonatomic,assign) UIBackgroundTaskIdentifier backgroundRecordingID;
@property (nonatomic,unsafe_unretained) id <AVCamCaptureManagerDelegate> delegate;

@property (nonatomic,assign) AVCaptureFlashMode flashMode;
@property (nonatomic,assign) AVCaptureTorchMode torchMode;
@property (nonatomic,assign) AVCaptureFocusMode focusMode;
@property (nonatomic,assign) AVCaptureExposureMode exposureMode;
@property (nonatomic,assign) AVCaptureWhiteBalanceMode whiteBalanceMode;

@property (strong, nonatomic) NSString* curLS;

- (BOOL) setupSession;
- (void) startRecording;
- (void) stopRecording;
- (void) captureStillImage;
- (BOOL) toggleCamera;
- (NSUInteger) cameraCount;
- (NSUInteger) micCount;
- (void) autoFocusAtPoint:(CGPoint)point;
- (void) continuousFocusAtPoint:(CGPoint)point;

- (BOOL) hasFlash;
- (BOOL) hasTorch;
- (BOOL) hasFocus;
- (BOOL) hasExposure;
- (BOOL) hasWhiteBalance;
- (void) focusAtPoint:(CGPoint)point;
- (void) exposureAtPoint:(CGPoint)point;

@end

// These delegate methods can be called on any arbitrary thread. If the delegate does something with the UI when called, make sure to send it to the main thread.
@protocol AVCamCaptureManagerDelegate <NSObject>
@optional
- (void) captureManager:(AVCamCaptureManager *)captureManager didFailWithError:(NSError *)error;
- (void) captureManagerRecordingBegan:(AVCamCaptureManager *)captureManager;
- (void) captureManagerRecordingFinished:(AVCamCaptureManager *)captureManager;
- (void) captureManagerStillImageCaptured:(AVCamCaptureManager *)captureManager;
- (void) captureManagerDeviceConfigurationChanged:(AVCamCaptureManager *)captureManager;
@end
