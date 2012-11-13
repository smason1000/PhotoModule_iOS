#import "AVCamViewController.h"
#import "AVCamCaptureManager.h"
#import "AVCamRecorder.h"
#import "ExpandyButton.h"


static void *AVCamFocusModeObserverContext = &AVCamFocusModeObserverContext;

@interface AVCamViewController () <UIGestureRecognizerDelegate>
@end

@interface AVCamViewController (InternalMethods)
- (CGPoint)convertToPointOfInterestFromViewCoordinates:(CGPoint)viewCoordinates;
- (void)updateButtonStates;
@end

@interface AVCamViewController (AVCamCaptureManagerDelegate) <AVCamCaptureManagerDelegate>
@end

@implementation AVCamViewController

@synthesize captureManager = _captureManager;
//@synthesize cameraToggleButton;
//@synthesize recordButton;
//@synthesize stillButton;
//@synthesize focusModeLabel;
@synthesize videoPreviewView;
@synthesize captureVideoPreviewLayer;

@synthesize flash = _flash;
@synthesize torch = _torch;
@synthesize focus = _focus;
@synthesize exposure = _exposure;
@synthesize whiteBalance = _whiteBalance;
@synthesize preset = _preset;
@synthesize videoConnection = _videoConnection;
@synthesize audioConnection = _audioConnection;
@synthesize orientation = _orientation;
@synthesize mirroring = _mirroring;
@synthesize zoomSlider = _zoomSlider;

float beginGestureScale;
float beginGestureRotationRadians;
CGPoint beginGestureTranslation;

float effectiveScale;
float effectiveRotationRadians;
CGPoint effectiveTranslation;

- (void)updateHudButtons:(BOOL)hudHidden
{
    if (hudHidden) 
    {
        [[self flash] setHidden:YES];
        //[[self torch] setHidden:YES];
        //[[self focus] setHidden:YES];
        //[[self exposure] setHidden:YES];
        //[[self whiteBalance] setHidden:YES];
        //[[self preset] setHidden:YES];
        //[[self videoConnection] setHidden:YES];
        //[[self audioConnection] setHidden:YES];
        //[[self orientation] setHidden:YES];
        //[[self mirroring] setHidden:YES];        
    } 
    else 
    {
        NSInteger count = 0;
        UIView *view = [self videoPreviewView];
        AVCamCaptureManager *captureManager = [self captureManager];
        ExpandyButton *expandyButton;
        
        expandyButton = [self flash];
        if ([captureManager hasFlash])
        {
            if (expandyButton == nil)
            {
                ExpandyButton *flash =  [[ExpandyButton alloc] initWithPoint:CGPointMake(8.f, 8.f)
                                                                title:@"Flash"
                                                                buttonNames:[NSArray arrayWithObjects:@"Off",@"On",@"Auto",nil]
                                                                selectedItem:[self.captureManager flashMode]];
                [flash addTarget:self action:@selector(flashChange:) forControlEvents:UIControlEventValueChanged];
                [view addSubview:flash];
                [self setFlash:flash];
                //[flash release];
            } 
            else
            {
                CGRect frame = [expandyButton frame];
                [expandyButton setFrame:CGRectMake(8.f, 8.f + (40.f * count), frame.size.width, frame.size.height)];
                [expandyButton setHidden:NO];
                [expandyButton setSelectedItem:[self.captureManager flashMode]];
            }
            count++;
        } 
        else
        {
            [expandyButton setHidden:YES];
        }
        
        /*
        expandyButton = [self torch];        
        if ([captureManager hasTorch])
        {
            if (expandyButton == nil)
            {
                ExpandyButton *torch =  [[ExpandyButton alloc] initWithPoint:CGPointMake(8.f, 8.f + (40.f * count))
                                                                title:@"Torch"
                                                                buttonNames:[NSArray arrayWithObjects:@"Off",@"On",@"Auto",nil]
                                                                selectedItem:[captureManager torchMode]];
                [torch addTarget:self action:@selector(torchChange:) forControlEvents:UIControlEventValueChanged];
                [view addSubview:torch];
                [self setTorch:torch];
                //[torch release];                
            }
            else
            {
                CGRect frame = [expandyButton frame];
                [expandyButton setFrame:CGRectMake(8.f, 8.f + (40.f * count), frame.size.width, frame.size.height)];
                [expandyButton setHidden:NO];
            }
            count++;
        }
        else
        {
            [expandyButton setHidden:YES];
        }
        
        expandyButton = [self focus];
        if ([captureManager hasFocus])
        {
            if (expandyButton == nil)
            {
                ExpandyButton *focus =  [[ExpandyButton alloc] initWithPoint:CGPointMake(8.f, 8.f + (40.f * count))
                                                                title:@"Focus"
                                                                buttonNames:[NSArray arrayWithObjects:@"Lock",@"Auto",@"Cont",nil]
                                                                selectedItem:[captureManager focusMode]];
                [focus addTarget:self action:@selector(focusChange:) forControlEvents:UIControlEventValueChanged];
                [view addSubview:focus];
                [self setFocus:focus];
                //[focus release];
            }
            else
            {
                CGRect frame = [expandyButton frame];
                [expandyButton setFrame:CGRectMake(8.f, 8.f + (40.f * count), frame.size.width, frame.size.height)];
                [expandyButton setHidden:NO];                
            }
            count++;
        }
        else
        {
            [expandyButton setHidden:YES];
        }

        expandyButton = [self exposure];
        if ([captureManager hasExposure])
        {
            if (expandyButton == nil)
            {
                ExpandyButton *exposure =  [[ExpandyButton alloc] initWithPoint:CGPointMake(8.f, 8.f + (40.f * count))
                                                                    title:@"AExp"
                                                                    buttonNames:[NSArray arrayWithObjects:@"Lock",@"Cont",nil]
                                                                    selectedItem:([captureManager exposureMode] == 2 ? 1 : [captureManager exposureMode])];
                [exposure addTarget:self action:@selector(exposureChange:) forControlEvents:UIControlEventValueChanged];
                [view addSubview:exposure];
                [self setExposure:exposure];
                [exposure release];
            }
            else
            {
                CGRect frame = [expandyButton frame];
                [expandyButton setFrame:CGRectMake(8.f, 8.f + (40.f * count), frame.size.width, frame.size.height)];
                [expandyButton setHidden:NO];                
            }
            count++;
        } 
        else
        {
            [expandyButton setHidden:YES];
        }
        
        expandyButton = [self whiteBalance];
        if ([captureManager hasWhiteBalance]) {
            if (expandyButton == nil) {
                ExpandyButton *whiteBalance =  [[ExpandyButton alloc] initWithPoint:CGPointMake(8.f, 8.f + (40.f * count))
                                                                              title:@"AWB"
                                                                        buttonNames:[NSArray arrayWithObjects:@"Lock",@"Cont",nil]
                                                                       selectedItem:([captureManager whiteBalanceMode] == 2 ? 1 : [captureManager whiteBalanceMode])];
                [whiteBalance addTarget:self action:@selector(whiteBalanceChange:) forControlEvents:UIControlEventValueChanged];
                [view addSubview:whiteBalance];
                [self setWhiteBalance:whiteBalance];
                [whiteBalance release];
            } else {
                CGRect frame = [expandyButton frame];
                [expandyButton setFrame:CGRectMake(8.f, 8.f + (40.f * count), frame.size.width, frame.size.height)];
                [expandyButton setHidden:NO];                
            }
            count++;
        } else {
            [expandyButton setHidden:YES];
        }
        
        {
            expandyButton = [self preset];
            if (expandyButton == nil) {
                ExpandyButton *preset =  [[ExpandyButton alloc] initWithPoint:CGPointMake(8.f, 8.f + (40.f * count))
                                                                        title:@"Preset"
                                                                  buttonNames:[NSArray arrayWithObjects:@"Low",@"Med",@"High",@"Photo",@"480p",@"720p",nil]
                                                                 selectedItem:2
                                                                  buttonWidth:40.f];
                [preset addTarget:self action:@selector(presetChange:) forControlEvents:UIControlEventValueChanged];
                [view addSubview:preset];
                [self setPreset:preset];
                [preset release];
            } else {
                CGRect frame = [expandyButton frame];
                [expandyButton setFrame:CGRectMake(8.f, 8.f + (40.f * count), frame.size.width, frame.size.height)];
                [expandyButton setHidden:NO];                
            }
            count++;
        }            
        
        expandyButton = [self videoConnection];
        if ([[captureManager videoInput] device] != nil) {
            if (expandyButton == nil) {
                ExpandyButton *videoConnection =  [[ExpandyButton alloc] initWithPoint:CGPointMake(8.f, 8.f + (40.f * count))
                                                                                 title:@"Video"
                                                                           buttonNames:[NSArray arrayWithObjects:@"Off",@"On",nil]
                                                                          selectedItem:1];
                [videoConnection addTarget:self action:@selector(videoConnectionToggle:) forControlEvents:UIControlEventValueChanged];
                [view addSubview:videoConnection];
                [self setVideoConnection:videoConnection];
                [videoConnection release];
            } else {
                CGRect frame = [expandyButton frame];
                [expandyButton setFrame:CGRectMake(8.f, 8.f + (40.f * count), frame.size.width, frame.size.height)];
                [expandyButton setHidden:NO];                
            }
            count++;
        } else {
            [expandyButton setHidden:YES];
        }
        
        expandyButton = [self audioConnection];
        if ([[captureManager audioInput] device] != nil) {
            if (expandyButton == nil) {
                ExpandyButton *audioConnection =  [[ExpandyButton alloc] initWithPoint:CGPointMake(8.f, 8.f + (40.f * count))
                                                                                 title:@"Audio"
                                                                           buttonNames:[NSArray arrayWithObjects:@"Off",@"On",nil]
                                                                          selectedItem:1];
                [audioConnection addTarget:self action:@selector(audioConnectionToggle:) forControlEvents:UIControlEventValueChanged];
                [view addSubview:audioConnection];
                [self setAudioConnection:audioConnection];
                [audioConnection release];
            } else {
                CGRect frame = [expandyButton frame];
                [expandyButton setFrame:CGRectMake(8.f, 8.f + (40.f * count), frame.size.width, frame.size.height)];
                [expandyButton setHidden:NO];                
            }
            count++;
        } else {
            [expandyButton setHidden:YES];
        }

        {
            expandyButton = [self orientation];
            if (expandyButton == nil)
            {
                ExpandyButton *orientation =  [[ExpandyButton alloc] initWithPoint:CGPointMake(8.f, 8.f + (40.f * count))
                                                                        title:@"Orient"
                                                                        buttonNames:[NSArray arrayWithObjects:@"Port",@"Upsi",@"Left",@"Right",nil]];
                [orientation addTarget:self action:@selector(adjustOrientation:) forControlEvents:UIControlEventValueChanged];
                [view addSubview:orientation];
                [self setOrientation:orientation];
                //[orientation release];
            }
            else
            {
                CGRect frame = [expandyButton frame];
                [expandyButton setFrame:CGRectMake(8.f, 8.f + (40.f * count), frame.size.width, frame.size.height)];
                [expandyButton setHidden:NO];                
            }
            count++;
        }
        expandyButton = [self mirroring];
        if ([captureManager supportsMirroring] || [[self captureVideoPreviewLayer] isMirroringSupported]) {
            if (expandyButton == nil) {
                ExpandyButton *mirroring =  [[ExpandyButton alloc] initWithPoint:CGPointMake(8.f, 8.f + (40.f * count))
                                                                           title:@"Mirror"
                                                                     buttonNames:[NSArray arrayWithObjects:@"Off",@"On",@"Auto",nil]
                                                                    selectedItem:2];
                [mirroring addTarget:self action:@selector(adjustMirroring:) forControlEvents:UIControlEventValueChanged];
                [view addSubview:mirroring];
                [self setMirroring:mirroring];
                [mirroring release];
            } else {
                CGRect frame = [expandyButton frame];
                [expandyButton setFrame:CGRectMake(8.f, 8.f + (40.f * count), frame.size.width, frame.size.height)];
                [expandyButton setHidden:NO];                
            }
        } else {
            [expandyButton setHidden:YES];
        }
        */
        
        // create the zoom slider
        if (self.zoomSlider == nil)
        {
            self.zoomSlider = [[UISlider alloc] initWithFrame:CGRectMake(8.f, view.frame.size.height - 55, view.frame.size.width - 16.f, 24)];   
            //UIImage *sliderLeftTrackImage = [[UIImage imageNamed: @"slider_body_min.png"] stretchableImageWithLeftCapWidth: 9 topCapHeight: 0];   
            //UIImage *sliderRightTrackImage = [[UIImage imageNamed: @"slider_body_max.png"] stretchableImageWithLeftCapWidth: 9 topCapHeight: 0];   
            //UIImage *sliderThumb = [[UIImage imageNamed: @"slider_thumb.png"] stretchableImageWithLeftCapWidth: 9 topCapHeight: 0];   
            //[zoomSlider setMinimumTrackImage: sliderLeftTrackImage forState: UIControlStateNormal];   
            //[zoomSlider setMaximumTrackImage: sliderRightTrackImage forState: UIControlStateNormal];   
            //[zoomSlider setThumbImage:sliderThumb forState:UIControlStateNormal];   

            [self.zoomSlider setMinimumValue:1.0f];
            [self.zoomSlider setMaximumValue:6.0f];
            [self.zoomSlider setContinuous:YES];
            [self.zoomSlider addTarget:self action:@selector(zoomSliderAction:) forControlEvents:UIControlEventValueChanged];
            
            CALayer *layer = [self.zoomSlider layer];
            [layer setBackgroundColor:[[UIColor colorWithWhite:1.f alpha:.35f] CGColor]];
            [layer setBorderWidth:1.f];
            [layer setBorderColor:[[UIColor colorWithWhite:.0f alpha:1.f] CGColor]];
            [layer setCornerRadius:15.f];
            
            [view addSubview:self.zoomSlider];
        }
        else
        {
            [self.zoomSlider setValue:effectiveScale];
        }
        count++;
    }
}

- (void)applyDefaults:(BOOL)hudHidden
{
    if (gSingleton.showTrace)
    {
        if (hudHidden)
            NSLog(@"Applying capture defaults - showing HUD");
        else
            NSLog(@"Applying capture defaults - hiding HUD");
    }
    
	effectiveScale = 1.0;
	effectiveRotationRadians = 0.0;
	effectiveTranslation = CGPointMake(0.0, 0.0);
	[captureVideoPreviewLayer setAffineTransform:CGAffineTransformIdentity];
	captureVideoPreviewLayer.frame = videoPreviewView.layer.bounds;
    
    [[self captureManager] setOrientation:AVCaptureVideoOrientationPortrait];
    [[self captureManager] setSessionPreset:AVCaptureSessionPresetPhoto];
    [[self captureManager] setCameraZoom:1.0f];
    [[self captureManager] setFocusMode:AVCaptureFocusModeAutoFocus];
    [[self captureManager] setFlashMode:AVCaptureFlashModeAuto];
    [[self captureManager] setViewportSize:self.videoPreviewView.frame.size];
    
    [self updateHudButtons:hudHidden];
    gSingleton.applyCaptureDefaults = NO;
}

/*
UITabBarItem *tabBarItem = [self tabBarItem];
//UIImage *tabBarImage = [UIImage imageNamed:@"YOUR_IMAGE_NAME.png"];
//[tabBarItem setImage:tabBarImage];
[tabBarItem setTitle:@"Camera"];
*/

- (void)dealloc
{
    [self removeObserver:self forKeyPath:@"captureManager.videoInput.device.focusMode"];
    [self removeObserver:self forKeyPath:@"captureManager.videoInput.device.flashMode"];
}

- (void)viewDidLoad
{
    NSError *error;

    //[[self cameraToggleButton] setTitle:NSLocalizedString(@"Camera", @"Toggle camera button title")];
    //[[self recordButton] setTitle:NSLocalizedString(@"Record", @"Toggle recording button record title")];
    //[[self stillButton] setTitle:NSLocalizedString(@"Photo", @"Capture still image button title")];
        
	if ([self captureManager] == nil)
    {
		AVCamCaptureManager *manager = [[AVCamCaptureManager alloc] init];
		[self setCaptureManager:manager];
        
        [[NSNotificationCenter defaultCenter]
         addObserver:self
         selector:@selector(eventHandlerCamera:)
         name:@"cameraEvent"
         object:nil ];
        
		
		[[self captureManager] setDelegate:self];

		if ([[self captureManager] setupSessionWithPreset:AVCaptureSessionPresetPhoto error:&error])
        {
            // Create video preview layer and add it to the UI
            
            AVCaptureVideoPreviewLayer *newCaptureVideoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:[[self captureManager] session]];
			            
            //if (gSingleton.iPadDevice)
            //{
            //    self.videoPreviewView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 768, 1024)];
            //}
            //else
            {
                self.videoPreviewView = [[UIView alloc] initWithFrame:CGRectMake(21, 1, 278, 370)];
                //self.videoPreviewView = [[UIView alloc] initWithFrame:CGRectMake(0, 1, 320, 370)];
            }
            [self applyDefaults:YES];
            
            self.videoPreviewView.backgroundColor = [UIColor blackColor];
                        
            [self.view addSubview:self.videoPreviewView];// //videoPreviewView

            UIView *view = [self videoPreviewView];
			CALayer *viewLayer = [view layer];
			[viewLayer setMasksToBounds:YES];

			CGRect bounds = [view bounds];
			[newCaptureVideoPreviewLayer setFrame:bounds];

			if ([newCaptureVideoPreviewLayer isOrientationSupported])
            {
				[newCaptureVideoPreviewLayer setOrientation:AVCaptureVideoOrientationPortrait];
			}
			
			[newCaptureVideoPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
			
			[viewLayer insertSublayer:newCaptureVideoPreviewLayer below:[[viewLayer sublayers] objectAtIndex:0]];
			
			[self setCaptureVideoPreviewLayer:newCaptureVideoPreviewLayer];
			
            // Start the session. This is done asychronously since -startRunning doesn't return until the session is running.
			dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
				[[[self captureManager] session] startRunning];
			});
			
            [self updateButtonStates];
			
            // Create the focus mode UI overlay
			//UILabel *newFocusModeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, viewLayer.bounds.size.width - 20, 20)];
			//[newFocusModeLabel setBackgroundColor:[UIColor clearColor]];
			//[newFocusModeLabel setTextColor:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.50]];
			//AVCaptureFocusMode initialFocusMode = [[[captureManager videoInput] device] focusMode];
			//[newFocusModeLabel setText:[NSString stringWithFormat:@"focus: %@", [self stringForFocusMode:initialFocusMode]]];
			//[view addSubview:newFocusModeLabel];
			[self addObserver:self forKeyPath:@"captureManager.videoInput.device.focusMode" options:NSKeyValueObservingOptionNew context:AVCamFocusModeObserverContext];
			//[self setFocusModeLabel:newFocusModeLabel];
            
            // Add a single tap gesture to focus on the point tapped, then lock focus
			UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapToAutoFocus:)];
			[singleTap setDelegate:self];
			[singleTap setNumberOfTapsRequired:1];
			[view addGestureRecognizer:singleTap];
            
            // Add a double tap gesture to reset the focus mode to continuous auto focus
			UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapToContinouslyAutoFocus:)];
			[doubleTap setDelegate:self];
			[doubleTap setNumberOfTapsRequired:2];
			[singleTap requireGestureRecognizerToFail:doubleTap];
			[view addGestureRecognizer:doubleTap];
            
            /***** manipulation ******/
            // clip sub-layer contents
            view.layer.masksToBounds = YES;
            // do one time set-up of gesture recognizers
            UIGestureRecognizer *recognizer;
            
            //recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTapFrom:)];
            //recognizer.delegate = self;
            //[view addGestureRecognizer:recognizer];
            //[recognizer release];
            
            recognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinchFrom:)];
            recognizer.delegate = self;
            [view addGestureRecognizer:recognizer];
            //[recognizer release];
            
            /*
            recognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleDragFrom:)];
            recognizer.delegate = self;
            ((UIPanGestureRecognizer *)recognizer).maximumNumberOfTouches = 1;
            [view addGestureRecognizer:recognizer];
            //[recognizer release];
            
            recognizer = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(handleRotationFrom:)];
            recognizer.delegate = self;
            [view addGestureRecognizer:recognizer];
            //[recognizer release];
            */
            /************/

		}		
	}
		
    [super viewDidLoad];
    
    //captureManager
    
}

-(void)viewWillAppear:(BOOL)animated
{    
    if (gSingleton.applyCaptureDefaults)
    {
        if (gSingleton.showTrace)
            NSLog(@"********** CamViewController viewWillAppear - defaults needed **********");
        [self applyDefaults:NO];
    }
    else
    {
        if (gSingleton.showTrace)
            NSLog(@"********** CamViewController viewWillAppear - defaults in place **********");
    }
    [super viewWillAppear:animated];
}

// Auto focus at a particular point. The focus mode will change to locked once the auto focus happens.
- (void)tapToAutoFocus:(UIGestureRecognizer *)gestureRecognizer
{
    if ([[[self.captureManager videoInput] device] isFocusPointOfInterestSupported])
    {
        CGPoint tapPoint = [gestureRecognizer locationInView:[self videoPreviewView]];
        CGPoint convertedFocusPoint = [self convertToPointOfInterestFromViewCoordinates:tapPoint];
        [self.captureManager focusAtPoint:convertedFocusPoint];
    }
}

// Change to continuous auto focus. The camera will constantly focus at the point choosen.
- (void)tapToContinouslyAutoFocus:(UIGestureRecognizer *)gestureRecognizer
{
    if ([[[self.captureManager videoInput] device] isFocusPointOfInterestSupported])
        [self.captureManager continuousFocusAtPoint:CGPointMake(.5f, .5f)];
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
	if ( [gestureRecognizer isKindOfClass:[UIPinchGestureRecognizer class]] )
    {
		beginGestureScale = effectiveScale;
	}
	else if ( [gestureRecognizer isKindOfClass:[UIRotationGestureRecognizer class]] )
    {
		beginGestureRotationRadians = effectiveRotationRadians;
	}
	if ( [gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]] )
    {
        CGPoint location = [gestureRecognizer locationInView:videoPreviewView];
        beginGestureTranslation = CGPointMake(effectiveTranslation.x - location.x, effectiveTranslation.x - location.y);
	}
	return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
	if ( touch.view == videoPreviewView )
		return YES;
	return NO;
}

- (void)handleSingleTapFrom:(UITapGestureRecognizer *)recognizer
{
	CGPoint location = [recognizer locationInView:videoPreviewView];
	CGPoint convertedLocation = [captureVideoPreviewLayer convertPoint:location fromLayer:captureVideoPreviewLayer.superlayer];
	if ( [captureVideoPreviewLayer containsPoint:convertedLocation] )
    {
		// cycle to next video gravity mode.
		NSString *videoGravity = captureVideoPreviewLayer.videoGravity;
		if ( [videoGravity isEqualToString:AVLayerVideoGravityResizeAspect] )
			captureVideoPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
		else if ( [videoGravity isEqualToString:AVLayerVideoGravityResizeAspectFill] )
			captureVideoPreviewLayer.videoGravity = AVLayerVideoGravityResize;
		else if ( [videoGravity isEqualToString:AVLayerVideoGravityResize] )
			captureVideoPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspect;
	}
}

- (void)handleRotationFrom:(UIRotationGestureRecognizer *)recognizer
{
	BOOL allTouchesAreOnThePreviewLayer = YES;
	NSUInteger numTouches = [recognizer numberOfTouches], i;
	for ( i = 0; i < numTouches; ++i ) {
		CGPoint location = [recognizer locationOfTouch:i inView:videoPreviewView];
		CGPoint convertedLocation = [captureVideoPreviewLayer convertPoint:location fromLayer:captureVideoPreviewLayer.superlayer];
		if ( ! [captureVideoPreviewLayer containsPoint:convertedLocation] ) {
			allTouchesAreOnThePreviewLayer = NO;
			break;
		}
	}
	
	if ( allTouchesAreOnThePreviewLayer ) {
		effectiveRotationRadians = beginGestureRotationRadians + recognizer.rotation;
		[self makeAndApplyAffineTransform];
	}
}

- (void)handleDragFrom:(UIPanGestureRecognizer *)recognizer
{
	CGPoint location = [recognizer locationInView:videoPreviewView];
	CGPoint convertedLocation = [captureVideoPreviewLayer convertPoint:location fromLayer:captureVideoPreviewLayer.superlayer];
	
	if ( [captureVideoPreviewLayer containsPoint:convertedLocation] )
    {
        effectiveTranslation = CGPointMake(beginGestureTranslation.x + location.x, beginGestureTranslation.y + location.y);
        [self makeAndApplyAffineTransform];
	}
}

-(void) zoomSliderAction:(UISlider*)sender
{
    effectiveScale = [sender value];
    //NSLog(@"Slider value changed: %.2f", [sender value]);
    
    [[self captureManager] setCameraZoom:effectiveScale];
    [self makeAndApplyAffineTransform];
}

- (void)handlePinchFrom:(UIPinchGestureRecognizer *)recognizer
{
	BOOL allTouchesAreOnThePreviewLayer = YES;
	NSUInteger numTouches = [recognizer numberOfTouches], i;
	for ( i = 0; i < numTouches; ++i )
    {
		CGPoint location = [recognizer locationOfTouch:i inView:videoPreviewView];
		CGPoint convertedLocation = [captureVideoPreviewLayer convertPoint:location fromLayer:captureVideoPreviewLayer.superlayer];
		if ( ! [captureVideoPreviewLayer containsPoint:convertedLocation] )
        {
			allTouchesAreOnThePreviewLayer = NO;
			break;
		}
	}
	
	if ( allTouchesAreOnThePreviewLayer )
    {
		effectiveScale = beginGestureScale * recognizer.scale;
        if (effectiveScale < 1.0)
            effectiveScale = 1.0;

        if (effectiveScale > 6.0)
            effectiveScale = 6.0;
                
        //NSLog(@"Pinch Zoom value changed: %.2f", effectiveScale);

        [self.zoomSlider setValue:effectiveScale animated:YES];

        [[self captureManager] setCameraZoom:effectiveScale];
		[self makeAndApplyAffineTransform];
	}
}

- (void)makeAndApplyAffineTransform
{
	// translate, then scale, then rotate
	CGAffineTransform affineTransform = CGAffineTransformMakeTranslation(effectiveTranslation.x, effectiveTranslation.y);
	affineTransform = CGAffineTransformScale(affineTransform, effectiveScale, effectiveScale);
	affineTransform = CGAffineTransformRotate(affineTransform, effectiveRotationRadians);
	[CATransaction begin];
	[CATransaction setAnimationDuration:.025];
	[captureVideoPreviewLayer setAffineTransform:affineTransform];
	[CATransaction commit];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (context == AVCamFocusModeObserverContext) {
        // Update the focus UI overlay string when the focus mode changes
		//[focusModeLabel setText:[NSString stringWithFormat:@"focus: %@", [self stringForFocusMode:(AVCaptureFocusMode)[[change objectForKey:NSKeyValueChangeNewKey] integerValue]]]];
	} else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

/*
#pragma mark Toolbar Actions
- (IBAction)toggleCamera:(id)sender
{
    // Toggle between cameras when there is more than one
    [[self captureManager] toggleCamera];
    
    // Do an initial focus
    [[self captureManager] continuousFocusAtPoint:CGPointMake(.5f, .5f)];
}

- (IBAction)toggleRecording:(id)sender
{
    // Start recording if there isn't a recording running. Stop recording if there is.
    //[[self recordButton] setEnabled:NO];
    if (![[[self captureManager] recorder] isRecording])
        [[self captureManager] startRecording];
    else
        [[self captureManager] stopRecording];
}

*/

-(void)eventHandlerCamera: (NSNotification *) notification
{
    if (gSingleton.showTrace)
        NSLog(@"eventHandlerCamera");
    
    // Capture a still image
    //[[self stillButton] setEnabled:NO];
    [[self captureManager] captureStillImage];
    
    // Flash the screen white and fade it out to give UI feedback that a still image was taken
    UIView *flashView = [[UIView alloc] initWithFrame:[[self videoPreviewView] frame]];
    [flashView setBackgroundColor:[UIColor whiteColor]];
    [[[self view] window] addSubview:flashView];
    
    [UIView animateWithDuration:.4f
                     animations:^{
                         [flashView setAlpha:0.f];
                     }
                     completion:^(BOOL finished){
                         [flashView removeFromSuperview];
                     }
     ];
}

#pragma mark HUD Actions
- (void)flashChange:(id)sender
{
    switch ([(ExpandyButton *)sender selectedItem])
    {
        case 0:
            [[self captureManager] setFlashMode:AVCaptureFlashModeOff];
            break;
        case 1:
            [[self captureManager] setFlashMode:AVCaptureFlashModeOn];
            break;
        case 2:
            [[self captureManager] setFlashMode:AVCaptureFlashModeAuto];
            break;
    }
}

- (void)torchChange:(id)sender
{
    switch ([(ExpandyButton *)sender selectedItem]) {
        case 0:
            [[self captureManager] setTorchMode:AVCaptureTorchModeOff];
            break;
        case 1:
            [[self captureManager] setTorchMode:AVCaptureTorchModeOn];
            break;
        case 2:
            [[self captureManager] setTorchMode:AVCaptureTorchModeAuto];
            break;
    }
}

- (void)focusChange:(id)sender
{
    switch ([(ExpandyButton *)sender selectedItem]) {
        case 0:
            [[self captureManager] setFocusMode:AVCaptureFocusModeLocked];
            break;
        case 1:
            [[self captureManager] setFocusMode:AVCaptureFocusModeAutoFocus];
            break;
        case 2:
            [[self captureManager] setFocusMode:AVCaptureFocusModeContinuousAutoFocus];
            break;
    }
}

- (void)exposureChange:(id)sender
{
    switch ([(ExpandyButton *)sender selectedItem]) {
        case 0:
            [[self captureManager] setExposureMode:AVCaptureExposureModeLocked];
            break;
        case 1:
            [[self captureManager] setExposureMode:AVCaptureExposureModeContinuousAutoExposure];
            break;
    }
}

- (void)whiteBalanceChange:(id)sender
{
    switch ([(ExpandyButton *)sender selectedItem]) {
        case 0:
            [[self captureManager] setWhiteBalanceMode:AVCaptureWhiteBalanceModeLocked];
            break;
        case 1:
            [[self captureManager] setWhiteBalanceMode:AVCaptureWhiteBalanceModeAutoWhiteBalance];
            break;
    }
}

- (void)presetChange:(id)sender
{
    NSString *oldSessionPreset = [[self captureManager] sessionPreset];
    switch ([(ExpandyButton *)sender selectedItem]) {
        case 0:
            [[self captureManager] setSessionPreset:AVCaptureSessionPresetLow];
            break;
        case 1:
            [[self captureManager] setSessionPreset:AVCaptureSessionPresetMedium];
            break;
        case 2:
            [[self captureManager] setSessionPreset:AVCaptureSessionPresetHigh];
            break;
        case 3:
            [[self captureManager] setSessionPreset:AVCaptureSessionPresetPhoto];
            break;
        case 4:
            [[self captureManager] setSessionPreset:AVCaptureSessionPreset640x480];
            break;
        case 5:
            [[self captureManager] setSessionPreset:AVCaptureSessionPreset1280x720];
            break;
    }
    
    if ([oldSessionPreset isEqualToString:[[self captureManager] sessionPreset]]) {
        if ([oldSessionPreset isEqualToString:AVCaptureSessionPresetLow]) {
            [(ExpandyButton *)sender setSelectedItem:0];
        } else if ([oldSessionPreset isEqualToString:AVCaptureSessionPresetMedium]) {
            [(ExpandyButton *)sender setSelectedItem:1];
        } else if ([oldSessionPreset isEqualToString:AVCaptureSessionPresetHigh]) {
            [(ExpandyButton *)sender setSelectedItem:2];
        } else if ([oldSessionPreset isEqualToString:AVCaptureSessionPresetPhoto]) {
            [(ExpandyButton *)sender setSelectedItem:3];
        } else if ([oldSessionPreset isEqualToString:AVCaptureSessionPreset640x480]) {
            [(ExpandyButton *)sender setSelectedItem:4];
        } else if ([oldSessionPreset isEqualToString:AVCaptureSessionPreset1280x720]) {
            [(ExpandyButton *)sender setSelectedItem:5];
        }
    }
}

/*
- (void)videoConnectionToggle:(id)sender
{
    switch ([(ExpandyButton *)sender selectedItem]) {
        case 0:
            [[self captureManager] setConnectionWithMediaType:AVMediaTypeVideo enabled:NO];
            break;
        case 1:
            [[self captureManager] setConnectionWithMediaType:AVMediaTypeVideo enabled:YES];
            break;
    }
}

- (void)audioConnectionToggle:(id)sender
{
    switch ([(ExpandyButton *)sender selectedItem]) {
        case 0:
            [[self captureManager] setConnectionWithMediaType:AVMediaTypeAudio enabled:NO];
            break;
        case 1:
            [[self captureManager] setConnectionWithMediaType:AVMediaTypeAudio enabled:YES];
            break;
    }
}
*/

- (void)adjustOrientation:(id)sender
{
    AVCaptureVideoPreviewLayer *previewLayer = [self captureVideoPreviewLayer];
    AVCaptureSession *session = [[self captureManager] session];
    [session beginConfiguration];    
    switch ([(ExpandyButton *)sender selectedItem]) {
        case 0:
            [[self captureManager] setOrientation:AVCaptureVideoOrientationPortrait];
            if ([previewLayer isOrientationSupported]) {
                [previewLayer setOrientation:AVCaptureVideoOrientationPortrait];
            }
            break;
        case 1:
            [[self captureManager] setOrientation:AVCaptureVideoOrientationPortraitUpsideDown];
            if ([previewLayer isOrientationSupported]) {
                [previewLayer setOrientation:AVCaptureVideoOrientationPortraitUpsideDown];
            }
            break;
        case 2:
            [[self captureManager] setOrientation:AVCaptureVideoOrientationLandscapeLeft];
            if ([previewLayer isOrientationSupported]) {
                [previewLayer setOrientation:AVCaptureVideoOrientationLandscapeLeft];
            }
            break;
        case 3:
            [[self captureManager] setOrientation:AVCaptureVideoOrientationLandscapeRight];
            if ([previewLayer isOrientationSupported]) {
                [previewLayer setOrientation:AVCaptureVideoOrientationLandscapeRight];
            }
            break;
    }
    [session commitConfiguration];
}

- (void)adjustMirroring:(id)sender
{
    AVCaptureVideoPreviewLayer *previewLayer = [self captureVideoPreviewLayer];
    AVCaptureSession *session = [[self captureManager] session];
    [session beginConfiguration];
    switch ([(ExpandyButton *)sender selectedItem]) {
        case 0:
            [[self captureManager] setMirroringMode:AVCamMirroringOff];
            if ([previewLayer isMirroringSupported]) {
                [previewLayer setAutomaticallyAdjustsMirroring:NO];
                [previewLayer setMirrored:NO];
            }
            break;
        case 1:
            [[self captureManager] setMirroringMode:AVCamMirroringOn];
            if ([previewLayer isMirroringSupported]) {
                [previewLayer setAutomaticallyAdjustsMirroring:NO];
                [previewLayer setMirrored:YES];
            }
            break;
        case 2:
            [[self captureManager] setMirroringMode:AVCamMirroringAuto];
            if ([previewLayer isMirroringSupported]) {
                [previewLayer setAutomaticallyAdjustsMirroring:YES];
            }
            break;
    }
    [session commitConfiguration];
}

@end

@implementation AVCamViewController (InternalMethods)

// Convert from view coordinates to camera coordinates, where {0,0} represents the top left of the picture area, and {1,1} represents
// the bottom right in landscape mode with the home button on the right.
- (CGPoint)convertToPointOfInterestFromViewCoordinates:(CGPoint)viewCoordinates 
{
    CGPoint pointOfInterest = CGPointMake(.5f, .5f);
    CGSize frameSize = [[self videoPreviewView] frame].size;
    
    if ([captureVideoPreviewLayer isMirrored]) {
        viewCoordinates.x = frameSize.width - viewCoordinates.x;
    }    

    if ( [[captureVideoPreviewLayer videoGravity] isEqualToString:AVLayerVideoGravityResize] ) {
		// Scale, switch x and y, and reverse x
        pointOfInterest = CGPointMake(viewCoordinates.y / frameSize.height, 1.f - (viewCoordinates.x / frameSize.width));
    } else {
        //CGRect cleanAperture;
        for (AVCaptureInputPort *port in [[[self captureManager] videoInput] ports]) {
            if ([port mediaType] == AVMediaTypeVideo) {
                //cleanAperture = CMVideoFormatDescriptionGetCleanAperture([port formatDescription], YES);
                
                CGSize apertureSize;
                
                if (gSingleton.iPadDevice)
                {
                    apertureSize = CGSizeMake(768, 1024);
                }
                else
                {
                    apertureSize = CGSizeMake(320, 371);
                }
                
                
                CGPoint point = viewCoordinates;

                CGFloat apertureRatio = apertureSize.height / apertureSize.width;
                CGFloat viewRatio = frameSize.width / frameSize.height;
                CGFloat xc = .5f;
                CGFloat yc = .5f;
                
                if ( [[captureVideoPreviewLayer videoGravity] isEqualToString:AVLayerVideoGravityResizeAspect] ) {
                    if (viewRatio > apertureRatio) {
                        CGFloat y2 = frameSize.height;
                        CGFloat x2 = frameSize.height * apertureRatio;
                        CGFloat x1 = frameSize.width;
                        CGFloat blackBar = (x1 - x2) / 2;
						// If point is inside letterboxed area, do coordinate conversion; otherwise, don't change the default value returned (.5,.5)
                        if (point.x >= blackBar && point.x <= blackBar + x2) {
							// Scale (accounting for the letterboxing on the left and right of the video preview), switch x and y, and reverse x
                            xc = point.y / y2;
                            yc = 1.f - ((point.x - blackBar) / x2);
                        }
                    } else {
                        CGFloat y2 = frameSize.width / apertureRatio;
                        CGFloat y1 = frameSize.height;
                        CGFloat x2 = frameSize.width;
                        CGFloat blackBar = (y1 - y2) / 2;
						// If point is inside letterboxed area, do coordinate conversion. Otherwise, don't change the default value returned (.5,.5)
                        if (point.y >= blackBar && point.y <= blackBar + y2) {
							// Scale (accounting for the letterboxing on the top and bottom of the video preview), switch x and y, and reverse x
                            xc = ((point.y - blackBar) / y2);
                            yc = 1.f - (point.x / x2);
                        }
                    }
                } else if ([[captureVideoPreviewLayer videoGravity] isEqualToString:AVLayerVideoGravityResizeAspectFill]) {
					// Scale, switch x and y, and reverse x
                    if (viewRatio > apertureRatio) {
                        CGFloat y2 = apertureSize.width * (frameSize.width / apertureSize.height);
                        xc = (point.y + ((y2 - frameSize.height) / 2.f)) / y2; // Account for cropped height
                        yc = (frameSize.width - point.x) / frameSize.width;
                    } else {
                        CGFloat x2 = apertureSize.height * (frameSize.height / apertureSize.width);
                        yc = 1.f - ((point.x + ((x2 - frameSize.width) / 2)) / x2); // Account for cropped width
                        xc = point.y / frameSize.height;
                    }
                }
                
                pointOfInterest = CGPointMake(xc, yc);
                break;
            }
        }
    }
    
    return pointOfInterest;
}

// Update button states based on the number of available cameras and mics
- (void)updateButtonStates
{
	//NSUInteger cameraCount = [[self captureManager] cameraCount];
	//NSUInteger micCount = [[self captureManager] micCount];
    
    CFRunLoopPerformBlock(CFRunLoopGetMain(), kCFRunLoopCommonModes, ^(void) {
        
        //[[self stillButton] setEnabled:YES];
        
        /*
        if (cameraCount < 2) {
            [[self cameraToggleButton] setEnabled:NO]; 
            
            
            if (cameraCount < 1) {
                [[self stillButton] setEnabled:NO];
                
                if (micCount < 1)
                    [[self recordButton] setEnabled:NO];
                else
                    [[self recordButton] setEnabled:YES];
            } else {
                [[self stillButton] setEnabled:YES];
                [[self recordButton] setEnabled:YES];
            }
        } else {
            [[self cameraToggleButton] setEnabled:YES];
            [[self stillButton] setEnabled:YES];
            [[self recordButton] setEnabled:YES];
        }
         */
    });
}

@end

@implementation AVCamViewController (AVCamCaptureManagerDelegate)

- (void)captureManager:(AVCamCaptureManager *)captureManager didFailWithError:(NSError *)error
{
    CFRunLoopPerformBlock(CFRunLoopGetMain(), kCFRunLoopCommonModes, ^(void) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:[error localizedDescription]
                                                            message:[error localizedFailureReason]
                                                           delegate:nil
                                                  cancelButtonTitle:NSLocalizedString(@"OK", @"OK button title")
                                                  otherButtonTitles:nil];
        [alertView show];
    });
}

- (void) captureStillImageFailedWithError:(NSError *)error
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Still Image Capture Failure"
                                                        message:[error localizedDescription]
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
    [alertView show];
}

- (void) cannotWriteToAssetLibrary
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Incompatible with Asset Library"
                                                        message:@"The captured file cannot be written to the asset library. It is likely an audio-only file."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
    [alertView show];
}

- (void) acquiringDeviceLockFailedWithError:(NSError *)error
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Device Configuration Lock Failure"
                                                        message:[error localizedDescription]
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
    [alertView show];
}

- (void) assetLibraryError:(NSError *)error forURL:(NSURL *)assetURL
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Asset Library Error"
                                                        message:[error localizedDescription]
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
    [alertView show];
}

- (void) someOtherError:(NSError *)error
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:[error localizedDescription]
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
    [alertView show];
}

- (void)captureManagerRecordingBegan:(AVCamCaptureManager *)captureManager
{
    CFRunLoopPerformBlock(CFRunLoopGetMain(), kCFRunLoopCommonModes, ^(void) {
        //[[self recordButton] setTitle:NSLocalizedString(@"Stop", @"Toggle recording button stop title")];
        //[[self recordButton] setEnabled:YES];
    });
}

- (void)captureManagerRecordingFinished:(AVCamCaptureManager *)captureManager
{
    CFRunLoopPerformBlock(CFRunLoopGetMain(), kCFRunLoopCommonModes, ^(void) {
        //[[self recordButton] setTitle:NSLocalizedString(@"Record", @"Toggle recording button record title")];
        //[[self recordButton] setEnabled:YES];
    });
}

- (void)captureManagerStillImageCaptured:(AVCamCaptureManager *)captureManager
{
    CFRunLoopPerformBlock(CFRunLoopGetMain(), kCFRunLoopCommonModes, ^(void) {
        //[[self stillButton] setEnabled:YES];
    });
}

- (void)captureManagerDeviceConfigurationChanged:(AVCamCaptureManager *)captureManager
{
	[self updateButtonStates];
}

@end
