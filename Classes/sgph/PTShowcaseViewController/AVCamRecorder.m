#import "AVCamRecorder.h"
#import "AVCamUtilities.h"
#import <AVFoundation/AVFoundation.h>

@interface AVCamRecorder (FileOutputDelegate) <AVCaptureFileOutputRecordingDelegate>
@end

@implementation AVCamRecorder

@synthesize session;
@synthesize movieFileOutput;
@synthesize outputFileURL;
@synthesize delegate;

- (id) initWithSession:(AVCaptureSession *)aSession outputFileURL:(NSURL *)anOutputFileURL
{
    self = [super init];
    if (self != nil) {
        AVCaptureMovieFileOutput *aMovieFileOutput = [[AVCaptureMovieFileOutput alloc] init];
        if ([aSession canAddOutput:aMovieFileOutput])
            [aSession addOutput:aMovieFileOutput];
        [self setMovieFileOutput:aMovieFileOutput];
		
		[self setSession:aSession];
		[self setOutputFileURL:anOutputFileURL];
    }

	return self;
}

- (void) dealloc
{
    [[self session] removeOutput:[self movieFileOutput]];
}

-(BOOL)recordsVideo
{
	AVCaptureConnection *videoConnection = [AVCamUtilities connectionWithMediaType:AVMediaTypeVideo fromConnections:[[self movieFileOutput] connections]];
	return [videoConnection isActive];
}

-(BOOL)recordsAudio
{
	AVCaptureConnection *audioConnection = [AVCamUtilities connectionWithMediaType:AVMediaTypeAudio fromConnections:[[self movieFileOutput] connections]];
	return [audioConnection isActive];
}

-(BOOL)isRecording
{
    return [[self movieFileOutput] isRecording];
}

-(void)startRecordingWithOrientation:(AVCaptureVideoOrientation)videoOrientation;
{
    AVCaptureConnection *videoConnection = [AVCamUtilities connectionWithMediaType:AVMediaTypeVideo fromConnections:[[self movieFileOutput] connections]];
    if ([videoConnection isVideoOrientationSupported])
        [videoConnection setVideoOrientation:videoOrientation];
    
    [[self movieFileOutput] startRecordingToOutputFileURL:[self outputFileURL] recordingDelegate:self];
}

-(void)stopRecording
{
    [[self movieFileOutput] stopRecording];
}

@end

@implementation AVCamRecorder (FileOutputDelegate)

- (void)             captureOutput:(AVCaptureFileOutput *)captureOutput
didStartRecordingToOutputFileAtURL:(NSURL *)fileURL
                   fromConnections:(NSArray *)connections
{
    if ([[self delegate] respondsToSelector:@selector(recorderRecordingDidBegin:)]) {
        [[self delegate] recorderRecordingDidBegin:self];
    }
}

- (void)              captureOutput:(AVCaptureFileOutput *)captureOutput
didFinishRecordingToOutputFileAtURL:(NSURL *)anOutputFileURL
                    fromConnections:(NSArray *)connections
                              error:(NSError *)error
{
    if ([[self delegate] respondsToSelector:@selector(recorder:recordingDidFinishToOutputFileURL:error:)]) {
        [[self delegate] recorder:self recordingDidFinishToOutputFileURL:anOutputFileURL error:error];
    }
}

@end
