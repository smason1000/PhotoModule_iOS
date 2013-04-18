#import "MySingleton.h"
#import "Photo.h"

#import "PTShowcaseView.h"

#import "PTShowcaseViewDelegate.h"
#import "PTShowcaseViewDataSource.h"

#import <AssetsLibrary/AssetsLibrary.h>

@interface PTShowcaseView ()
@end

@implementation PTShowcaseView

@synthesize showcaseDelegate = _showcaseDelegate;
@synthesize showcaseDataSource = _showcaseDataSource;

@synthesize uniqueName = _uniqueName;

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

-(void) dealloc
{
    NSLog(@"[PTShowcaseView] dealloc");
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"clearEvent" object:nil];
}

#pragma mark - Instance properties

- (NSArray *)imageItems
{
    return gSingleton.mainData;
}

#pragma mark - Instance methods

- (NSInteger)numberOfItems
{
    return [gSingleton.mainData count];
}

- (PTContentType)contentTypeForItemAtIndex:(NSInteger)index
{
    return PTContentTypeImage;
}

- (PTItemOrientation)orientationForItemAtIndex:(NSInteger)index
{
    return ((Photo *)[gSingleton.mainData objectAtIndex:index]).orientation;
}

- (NSString *)uniqueNameForItemAtIndex:(NSInteger)index
{
    id object = ((Photo *)[gSingleton.mainData objectAtIndex:index]).name;
    return object == [NSNull null] ? nil : object;
}

- (NSString *)pathForItemAtIndex:(NSInteger)index
{
    NSString *fullPath = [((Photo *)[gSingleton.mainData objectAtIndex:index]) photoPath];
    return fullPath;
}

- (NSString *)sourceForThumbnailImageOfItemAtIndex:(NSInteger)index
{
    NSString *fullPath = [((Photo *)[gSingleton.mainData objectAtIndex:index]) thumbPath];
    return fullPath;
}

- (NSString *)textForItemAtIndex:(NSInteger)index
{
    id object = ((Photo *)[gSingleton.mainData objectAtIndex:index]).label.getDisplayText;
    return object == [NSNull null] ? nil : object;
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
    
    // clear out the current array
    [self clearData];
    [gSingleton.mainData removeAllObjects];

    // read the photos from the database
    NSMutableArray *photos = [Photo getPhotos:gSingleton.orderNumber andUserId:gSingleton.userId];
    
    BOOL showImg;
    BOOL isLabeled;
    
    int labeledCount = 0;
    int totalCount = 0;
    
    for (Photo *photo in photos)
    {
        totalCount++;
        
        showImg = YES;
        isLabeled = !([photo.label.label isEqualToString:((PhotoLabel *)[gSingleton.labelArr objectAtIndex:0]).label]);
        
        if (isLabeled)
        {
            labeledCount++;
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
                showImg = [gSingleton isReqLab:photo.label.getDisplayText];
                break;
        }
        
        if (showImg)
        {
            photo.selected = NO;
            [gSingleton.mainData addObject:photo];
        }
    }
    NSLog(@"Loaded %d photos for order %@", totalCount, gSingleton.orderNumber);
    
    gSingleton.photoCount = totalCount;
    gSingleton.labeledCount = labeledCount;
    
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"ulcEvent"
     object:nil ];
    
    [super reloadData];
}

@end