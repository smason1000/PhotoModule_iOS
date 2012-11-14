#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreMedia/CoreMedia.h>
#import <CoreMedia/CMFormatDescription.h>
#import "ExpandyButton.h"

@class AVCamCaptureManager, AVCamPreviewView, AVCaptureVideoPreviewLayer;

@interface AVCamViewController : UIViewController <UIImagePickerControllerDelegate,UINavigationControllerDelegate> { //UIViewController
    AVCamCaptureManager *_captureManager;
    ExpandyButton *_flash;
    ExpandyButton *_torch;
    ExpandyButton *_focus;
    ExpandyButton *_exposure;
    ExpandyButton *_whiteBalance;
    ExpandyButton *_preset;
    ExpandyButton *_videoConnection;
    ExpandyButton *_audioConnection;
    ExpandyButton *_orientation;
    ExpandyButton *_mirroring;
    UISlider *_zoomSlider;
}

@property (nonatomic, strong) AVCamCaptureManager *captureManager;
@property (nonatomic, strong) UIView *videoPreviewView; //IBOutlet
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *captureVideoPreviewLayer;
//@property (nonatomic) IBOutlet UIBarButtonItem *cameraToggleButton;
//@property (nonatomic) IBOutlet UIBarButtonItem *recordButton;
//@property (nonatomic) IBOutlet UIBarButtonItem *stillButton;
//@property (nonatomic, strong) IBOutlet UILabel *focusModeLabel;

@property (nonatomic,strong) ExpandyButton *flash;
@property (nonatomic,strong) ExpandyButton *torch;
@property (nonatomic,strong) ExpandyButton *focus;
@property (nonatomic,strong) ExpandyButton *exposure;
@property (nonatomic,strong) ExpandyButton *whiteBalance;
@property (nonatomic,strong) ExpandyButton *preset;
@property (nonatomic,strong) ExpandyButton *videoConnection;
@property (nonatomic,strong) ExpandyButton *audioConnection;
@property (nonatomic,strong) ExpandyButton *orientation;
@property (nonatomic,strong) ExpandyButton *mirroring;
@property (nonatomic,strong) UISlider *zoomSlider;

#pragma mark Toolbar Actions
/*
- (IBAction)toggleRecording:(id)sender;
- (IBAction)captureStillImage:(id)sender;
- (IBAction)toggleCamera:(id)sender;
*/

- (void)updateHudButtons:(BOOL)hudHidden;

#pragma mark HUD Actions
- (void)flashChange:(id)sender;
- (void)torchChange:(id)sender;
- (void)focusChange:(id)sender;
- (void)exposureChange:(id)sender;
- (void)whiteBalanceChange:(id)sender;
- (void)presetChange:(id)sender;
- (void)adjustOrientation:(id)sender;
- (void)adjustMirroring:(id)sender;

@end

