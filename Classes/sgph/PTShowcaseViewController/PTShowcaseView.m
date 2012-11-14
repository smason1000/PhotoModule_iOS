#import "MySingleton.h"

#import "PTShowcaseView.h"

#import "PTShowcaseViewDelegate.h"
#import "PTShowcaseViewDataSource.h"

#import <AssetsLibrary/AssetsLibrary.h>

@interface PTShowcaseView ()

@property (nonatomic, strong) NSMutableArray *data;

@end

@implementation PTShowcaseView

@synthesize showcaseDelegate = _showcaseDelegate;
@synthesize showcaseDataSource = _showcaseDataSource;

@synthesize uniqueName = _uniqueName;

// private
@synthesize data = _data;

- (id)initWithUniqueName:(NSString *)uniqueName
{
    
    self = [super init];
    if (self)
    {
        // Custom initialization
        _uniqueName = uniqueName;
    }
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(eventHandlerClear:)
     name:@"clearEvent"
     object:nil ];
    
    return self;
}

#pragma mark - Instance properties

- (NSArray *)imageItems
{
    return [self.data filteredArrayUsingPredicate:
            [NSPredicate predicateWithFormat:@"contentType = %d", PTContentTypeImage]];
}

#pragma mark - Instance methods

- (NSInteger)numberOfItems
{
    return [self.data count];
}

- (PTContentType)contentTypeForItemAtIndex:(NSInteger)index
{
    return [[[self.data objectAtIndex:index] objectForKey:@"contentType"] integerValue];
}

- (PTItemOrientation)orientationForItemAtIndex:(NSInteger)index
{
    return [[[self.data objectAtIndex:index] objectForKey:@"orientation"] integerValue];
}

- (NSString *)uniqueNameForItemAtIndex:(NSInteger)index
{
    id object = [[self.data objectAtIndex:index] objectForKey:@"uniqueName"];
    return object == [NSNull null] ? nil : object;
}

- (NSString *)pathForItemAtIndex:(NSInteger)index
{
    id object = [[self.data objectAtIndex:index] objectForKey:@"path"];
    return object == [NSNull null] ? nil : object;
}

- (NSString *)sourceForThumbnailImageOfItemAtIndex:(NSInteger)index
{
    id object = [[self.data objectAtIndex:index] objectForKey:@"thumbnailImageSource"];
    return object == [NSNull null] ? nil : object;
}

- (NSString *)textForItemAtIndex:(NSInteger)index
{
    id object = [[self.data objectAtIndex:index] objectForKey:@"text"];
    return object == [NSNull null] ? nil : object;
}

- (NSInteger)relativeIndexForItemAtIndex:(NSInteger)index withContentType:(PTContentType)contentType
{
    NSInteger relativeIndex = -1;
    for (NSInteger i = 0; i < index+1; i++)
    {
        if ([[[self.data objectAtIndex:i] objectForKey:@"contentType"] integerValue] == contentType)
        {
            relativeIndex++;
        }
    }
    return relativeIndex;
}

-(void)eventHandlerClear: (NSNotification *) notification
{
    if (gSingleton.showTrace)
        NSLog(@"INTERNAL RELOAD FIRED");
    
    [self reloadData];
}


- (void)reloadData
{
    if (gSingleton.showTrace)
        NSLog(@"reloadData()");
    
    NSMutableArray *dirContents = [gSingleton getPhotoDirContents];
    NSInteger numberOfItems = [dirContents count];
    
    // Create an items' info array for reusing
    self.data = [NSMutableArray arrayWithCapacity:numberOfItems];
    
    BOOL hasLabelKey;
    BOOL hasOrientationKey;
    BOOL hasDescKey;
    
    BOOL showImg;
    BOOL isLabeled;
    
    
    NSInteger i;
    
    //
    
    NSLog(@"Loading %d photos for order %@...", numberOfItems, gSingleton.orderNumber);
    
    int labelCount = 0;
    
    //[gSingleton.itemArray removeAllObjects];
    
    for (i = 0; i < numberOfItems; i++)
    {
        // Ask data source and delegate for various data
        PTContentType contentType = PTContentTypeImage;
        PTItemOrientation orientation = PTItemOrientationPortrait;
        NSString *fname = [dirContents objectAtIndex:i];
        
        NSString *path = [NSString stringWithFormat:@"%@/%@", [gSingleton getPhotoDirFull], fname];
        
        NSString *uniqueName = fname;
        NSString *thumbnailImageSource = [NSString stringWithFormat:@"%@/%@", [gSingleton getThumbDirFull], fname];
        
        NSMutableString *text;
        NSMutableString *description;
        NSMutableString *imgOr;
        
        hasLabelKey = YES;
        hasOrientationKey = YES;
        hasDescKey = YES;
        NSDictionary *dict;
        
        @try
        {
            dict = [gSingleton.infoDict valueForKey:fname];
        }
        @catch (NSException *e)
        {
            if ([[e name] isEqualToString:NSUndefinedKeyException])
            {
                hasLabelKey = NO;
                hasOrientationKey = NO;
                hasDescKey = NO;
            }
        }
        
        if (dict == nil)
        {
            // we did not find the main key in the info dictionary
            hasLabelKey = NO;
            hasOrientationKey = NO;
            hasDescKey = NO;
        }
        else
        {
            // label value
            @try
            {
                [dict valueForKey:@"label"];
            }
            @catch (NSException *e)
            {
                if ([[e name] isEqualToString:NSUndefinedKeyException])
                {
                    hasLabelKey = NO;
                }
            }
            if ([dict valueForKey:@"label"] == nil)
            {
                hasLabelKey = NO;
            }

            // description value
            @try
            {
                [dict valueForKey:@"description"];
            }
            @catch (NSException *e)
            {
                if ([[e name] isEqualToString:NSUndefinedKeyException])
                {
                    hasDescKey = NO;
                }
            }
            if ([dict valueForKey:@"description"] == nil)
            {
                hasDescKey = NO;
            }
            
            // orientation value
            @try
            {
                [dict valueForKey:@"orientation"];
            }
            @catch (NSException *e)
            {
                if ([[e name] isEqualToString:NSUndefinedKeyException])
                {
                    hasOrientationKey = NO;
                }
            }
            if ([dict valueForKey:@"orientation"] == nil)
            {
                hasOrientationKey = NO;
            }
        }
        
        /*
         typedef enum {
         UIDeviceOrientationUnknown,
         UIDeviceOrientationPortrait,            // Device oriented vertically, home button on the bottom
         UIDeviceOrientationPortraitUpsideDown,  // Device oriented vertically, home button on the top
         UIDeviceOrientationLandscapeLeft,       // Device oriented horizontally, home button on the right
         UIDeviceOrientationLandscapeRight,      // Device oriented horizontally, home button on the left
         UIDeviceOrientationFaceUp,              // Device oriented flat, face up
         UIDeviceOrientationFaceDown             // Device oriented flat, face down
         } UIDeviceOrientation;
         */

        if (hasLabelKey)
        {
            text = [dict objectForKey:@"label"];
        }
        else
        {
            text = [gSingleton.labelArr objectAtIndex:0];
        }
        
        if (hasDescKey)
        {
            description = [dict objectForKey:@"description"];
        }
        else
        {
            description = [NSMutableString stringWithString:@""];
        }
        
        if (hasOrientationKey)
        {
            imgOr = [dict objectForKey:@"orientation"];
            
            if ([imgOr isEqualToString:@"3"])
            {
                orientation = PTItemOrientationLandscape;
            }
            
            if ([imgOr isEqualToString:@"4"])
            {
                orientation = PTItemOrientationLandscape;
            }
        }
        
        showImg = YES;
        isLabeled = !([text isEqualToString:[gSingleton.labelArr objectAtIndex:0]]);
        
        if (isLabeled)
        {
            labelCount++;
        }
                
        switch (gSingleton.currentFilterMode)
        {
            case PHFilterModeAll:
                break;
                
            case PHFilterModeLabeled:
                if (isLabeled)
                {
                    showImg = YES;
                }
                else
                {
                    showImg = NO;
                }
                break;
            
            case PHFilterModeUnlabeled:
                if (isLabeled)
                {
                    showImg = NO;
                }
                else
                {
                    showImg = YES;
                }
                break;
            
            case PHFilterModeRequiredLabels:
                showImg = [gSingleton isReqLab:text];
                break;
        }
        
        NSNumber* ival =  [NSNumber numberWithInteger:i];
        NSNumber* zval =  [NSNumber numberWithInteger:0];
        
        if (showImg)
        {
            [self.data addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  [NSNumber numberWithInteger:contentType], @"contentType",
                                  [NSNumber numberWithInteger:orientation], @"orientation",
                                  path ? path : [NSNull null], @"path",
                                  uniqueName ? uniqueName : [NSNull null], @"uniqueName",
                                  thumbnailImageSource ? thumbnailImageSource : [NSNull null], @"thumbnailImageSource",
                                  text ? text : [NSNull null], @"text",
                                  description ? description : [NSNull null], @"description",
                                  ival,@"imgIndex",
                                  zval,@"selected",
                                nil]];
        }
    }
    NSLog(@"Done Loading");
    
    gSingleton.mainData = self.data;
    
    gSingleton.labeledCount = labelCount;
    
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"ulcEvent"
     object:nil ];
    
     [super reloadData];
}

@end