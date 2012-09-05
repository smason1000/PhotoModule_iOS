#import "MySingleton.h"

NSComparisonResult compareLetters(id t1, id t2, void* context)
{    
    return [ [t1 lowercaseString] compare: [t2 lowercaseString] ];
}


MySingleton *gSingleton = nil;
//static MySingleton *sharedMySingleton = nil;

@implementation MySingleton

@synthesize doRef;
@synthesize openToGallery;
@synthesize applyCaptureDefaults;
@synthesize orderNumber;
@synthesize rootPhotoFolder;
@synthesize hashVals;
@synthesize curHashVals;
@synthesize hashValsReq;
@synthesize docDir;
@synthesize curLetArray;
@synthesize mainData;
@synthesize showTrace;

@synthesize dirContents;

@synthesize newPhotos;
@synthesize expandOn;
@synthesize editOn;
@synthesize filterOn;
@synthesize iPadDevice;
@synthesize isModule;

@synthesize currentFilterMode;
@synthesize currentAppState;

@synthesize relativeIndex;
@synthesize photoCount;
@synthesize requiredCount;
@synthesize labeledCount;

@synthesize msgQ;

@synthesize infoDict;
@synthesize selDict;
@synthesize labelArr;
@synthesize itemArray;
@synthesize currentLabelString;
@synthesize currentLabelDescription;
@synthesize requiredLabelArr;

#pragma mark Singleton Methods

/*
// Not thread safe (supposedly?)
 
+ (id)sharedSingleton {
    @synchronized(self) {
        if (sharedMySingleton == nil)
            sharedMySingleton = [[self alloc] init];
    }
    return sharedMySingleton;
}
*/

+(id)sharedSingleton
{
    static dispatch_once_t pred;
    static MySingleton *shared = nil;
    
    dispatch_once(&pred, ^{
        shared = [[MySingleton alloc] init];
    });
    return shared;
}


- (id)init
{
    if (self = [super init])
    {
        
        self.iPadDevice = NO;
        
#ifdef UI_USER_INTERFACE_IDIOM
        self.iPadDevice = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad;
#endif
        self.docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        
        self.orderNumber = @"0";
        
        self.curLetArray = [NSArray arrayWithObjects:
                    @"#",
                    @"A",
                    @"B",
                    @"C",
                    @"D",
                    @"E",
                    @"F",
                    @"G",
                    @"H",
                    @"I",
                    @"J",
                    @"K",
                    @"L",
                    @"M",
                    @"N",
                    @"O",
                    @"P",
                    @"Q",
                    @"R",
                    @"S",
                    @"T",
                    @"U",
                    @"V",
                    @"W",
                    @"X",
                    @"Y",
                    @"Z",
                    nil];
        
        self.newPhotos = NO;
        self.expandOn = NO;
        self.editOn = YES;
        self.filterOn = NO;
        self.doRef = YES;
        self.openToGallery = NO;
        self.isModule = YES;
        
        self.showTrace = YES;
        
        self.currentFilterMode = PHFilterModeAll;
        self.currentAppState = PHASLabelFS;

        self.relativeIndex = 0;
        self.photoCount = [self getDirCount];
        self.requiredCount = 0;
        self.labeledCount = 0;
        
        self.mainData = nil;
        self.infoDict = nil;
        self.selDict = [[NSMutableDictionary alloc] init];
        
        self.msgQ = [[NSMutableArray alloc] init];
        
        //not mutable, so can't do this in a loop...(probably a way, but too lazy to look it up :D)
        self.hashVals = [[NSArray alloc] initWithObjects:
                    [[NSMutableArray alloc] init],
                    [[NSMutableArray alloc] init],
                    [[NSMutableArray alloc] init],
                    [[NSMutableArray alloc] init],
                    [[NSMutableArray alloc] init],
                    [[NSMutableArray alloc] init],
                    [[NSMutableArray alloc] init],
                    [[NSMutableArray alloc] init],
                    [[NSMutableArray alloc] init],
                    [[NSMutableArray alloc] init],
                    [[NSMutableArray alloc] init],
                    [[NSMutableArray alloc] init],
                    [[NSMutableArray alloc] init],
                    [[NSMutableArray alloc] init],
                    [[NSMutableArray alloc] init],
                    [[NSMutableArray alloc] init],
                    [[NSMutableArray alloc] init],
                    [[NSMutableArray alloc] init],
                    [[NSMutableArray alloc] init],
                    [[NSMutableArray alloc] init],
                    [[NSMutableArray alloc] init],
                    [[NSMutableArray alloc] init],
                    [[NSMutableArray alloc] init],
                    [[NSMutableArray alloc] init],
                    [[NSMutableArray alloc] init],
                    [[NSMutableArray alloc] init],
                    [[NSMutableArray alloc] init],
                    [[NSMutableArray alloc] init],
                    [[NSMutableArray alloc] init],
                    [[NSMutableArray alloc] init]
                    , nil];
        
        self.hashValsReq = [[NSArray alloc] initWithObjects:
                    [[NSMutableArray alloc] init],
                    [[NSMutableArray alloc] init],
                    [[NSMutableArray alloc] init],
                    [[NSMutableArray alloc] init],
                    [[NSMutableArray alloc] init],
                    [[NSMutableArray alloc] init],
                    [[NSMutableArray alloc] init],
                    [[NSMutableArray alloc] init],
                    [[NSMutableArray alloc] init],
                    [[NSMutableArray alloc] init],
                    [[NSMutableArray alloc] init],
                    [[NSMutableArray alloc] init],
                    [[NSMutableArray alloc] init],
                    [[NSMutableArray alloc] init],
                    [[NSMutableArray alloc] init],
                    [[NSMutableArray alloc] init],
                    [[NSMutableArray alloc] init],
                    [[NSMutableArray alloc] init],
                    [[NSMutableArray alloc] init],
                    [[NSMutableArray alloc] init],
                    [[NSMutableArray alloc] init],
                    [[NSMutableArray alloc] init],
                    [[NSMutableArray alloc] init],
                    [[NSMutableArray alloc] init],
                    [[NSMutableArray alloc] init],
                    [[NSMutableArray alloc] init],
                    [[NSMutableArray alloc] init],
                    [[NSMutableArray alloc] init],
                    [[NSMutableArray alloc] init],
                    [[NSMutableArray alloc] init]
                    , nil];
        
        
        self.itemArray = [[NSMutableArray alloc] init];
        
        self.labelArr = [NSMutableArray arrayWithObjects:nil];
        self.requiredLabelArr = [NSMutableArray arrayWithObjects:nil];
        
        [self setLabels:
         @"[No Label],a picture of the house,back of house,center of house,demolition,eviction notice,Other: With Description,f,g,Hg,gh,gha,a1,b1,c1,d1,E1,f1,g1,a2,b2,c2,d2,e2,f2,g2,a3,b3,c3,D3,e3,f3,g3,a11,b11,c11,d11,e11,f11,w11,x11,y11,z11"
         ];
        //g11,h11,i11,j11,K11,l11,m11,n11,o11,p11,q11,r11,s11,t11,u11,v11,
        [self setReqLabels: @"g2,a3,b3,c3,d3,e3" withUpdate:NO
         ];
        
        // mimic the way INSPI will initialize the application
        BOOL emu = NO;        
        NSString *model = [[UIDevice currentDevice] model];
        if ([model isEqualToString:@"iPhone Simulator"] || [model isEqualToString:@"iPad Simulator"])
        {
            emu = YES;
        }
        if (emu)
        {
            self.openToGallery = NO;
            
            // labels set appropriately above
            //updatePHReqLabels({});
            
            // photo folder already set
            //krollDemo.photoFolder = getVal("photoFolder", currentOrderId);
            
            [self setOrderNum:@"12345678"];
        }
    }
    return self;
}

- (void) updateLabelHash
{
    [self.labelArr sortUsingFunction:compareLetters context:nil];
    
    int i;
    
    int testLetter;
    int currentIndex;
    
    
    for (i = 0; i < [self.hashVals count]; i++)
    {
        [[self.hashVals objectAtIndex:i] removeAllObjects];
    }
    
    NSMutableArray* curHash;
    NSString* curString;
    
    for (i = 0; i < [self.labelArr count]; i++)
    {
        curString = [self.labelArr objectAtIndex:i];
        testLetter = [curString characterAtIndex:0];
        
        if (testLetter >= 65 && testLetter <= 90)
        {
            testLetter += 32;
        }
        
        //is symbol
        if (testLetter < 97)
        {
            currentIndex = 0;
        }
        else
        {
            currentIndex = testLetter - 96;
        }
        
        curHash = [self.hashVals objectAtIndex:currentIndex];
        [curHash addObject:curString];
    }
}

- (void) updateLabelHashReq
{
    [self.requiredLabelArr sortUsingFunction:compareLetters context:nil];

    int i;
    
    int testLetter;
    int currentIndex;
        
    for (i = 0; i < [self.hashValsReq count]; i++)
    {
        [[self.hashValsReq objectAtIndex:i] removeAllObjects];
    }
    
    NSMutableArray* curHash;
    NSString* curString;
    
    for (i = 0; i < [self.requiredLabelArr count]; i++)
    {
        curString = [self.requiredLabelArr objectAtIndex:i];
        testLetter = [curString characterAtIndex:0];
        
        if (testLetter >= 65 && testLetter <= 90)
        {
            testLetter += 32;
        }
        
        //is symbol
        if (testLetter < 97)
        {
            currentIndex = 0;
        }
        else
        {
            currentIndex = testLetter - 96;
        }
        
        curHash = [self.hashValsReq objectAtIndex:currentIndex];
        [curHash addObject:curString];
    }
}

- (void) setOrderNum:(NSString *)orderNum
{    
    self.orderNumber = orderNum;
    self.currentAppState = PHASLabelFS;
    self.photoCount = [self getDirCount];
    // make sure requiredCount is set before this call
    //requiredCount = 0;
    self.editOn = YES;
    self.expandOn = NO;
    self.filterOn = NO;
    self.applyCaptureDefaults = YES;
    
    if (self.openToGallery)
    {
        self.editOn = NO;
        self.currentAppState = PHASGrid;
    }

    [self loadList];
    
    self.doRef = YES;
}

- (void) setPhotoFolder:(NSString *)aFolder
{    
    self.rootPhotoFolder = aFolder;
}
    
- (void) setReqCount:(NSString *)newCount
{
    //NSLog(@"setReqCount %@", newCount);
    requiredCount = [newCount intValue];
}

- (void) setHashReq:(BOOL)isReq
{    
    if (isReq)
    {
        self.curHashVals = self.hashValsReq;
    }
    else
    {
        self.curHashVals = self.hashVals;
    }
}

- (void) setLabels:(NSString*)newLabels
{
    [self.labelArr removeAllObjects];
    
    NSMutableArray *tempArr = (NSMutableArray*)[newLabels componentsSeparatedByString: @","];
    
    NSInteger i;
    for (i = 0; i < [tempArr count]; i++)
    {
        //[labelArr addObject: [[tempArr objectAtIndex:i] capitalizedString] ];
        [self.labelArr addObject: [tempArr objectAtIndex:i] ];
    }
    
    self.currentLabelString = [labelArr objectAtIndex:0];
    self.currentLabelDescription = @"";
    
    [self updateLabelHash];
    
    [self setHashReq:NO];
}

- (void) setReqLabels:(NSString*)newLabels withUpdate:(BOOL)doDBUpdate
{
    //requiredLabelArr = (NSMutableArray*)[newLabels componentsSeparatedByString: @","];
    
    [self.requiredLabelArr removeAllObjects];
    
    NSMutableArray *tempArr;    
    NSInteger i;
    
    if ([newLabels isEqualToString:@""])
    {
        // do nothing
    }
    else
    {
        tempArr= (NSMutableArray*)[newLabels componentsSeparatedByString: @","];
        for (i = 0; i < [tempArr count]; i++)
        {
            //[requiredLabelArr addObject: [[tempArr objectAtIndex:i] capitalizedString] ];
            [self.requiredLabelArr addObject: [tempArr objectAtIndex:i] ];
        }
    }

    [self updateLabelHashReq];

    
    if (doDBUpdate)
    {
        [self updateAllDB];
    }
}

- (NSMutableDictionary*) getInfoEntry:(NSString *)key
{
    NSMutableDictionary *innerDict = [self.infoDict objectForKey:key];
    
    if (innerDict == nil)
    {
        innerDict = [NSMutableDictionary dictionaryWithObjects:
                     [NSArray arrayWithObjects: @"", @"", @"", @"", nil]
                     forKeys:[NSArray arrayWithObjects:@"label", @"description", @"orientation", @"status", nil]];
        [self.infoDict setObject:innerDict forKey:key];
    }
    return innerDict;
}

-(void)removeInfoEntry:(NSString*)key
{
    [self.infoDict removeObjectForKey:key];
    
    // debug remove code below
    for(id key in self.infoDict)
    {        
        NSDictionary *dict = [gSingleton.infoDict objectForKey:key];
        id value = [dict objectForKey:@"label"];
        id desc = [dict objectForKey:@"description"];

        if ([value isEqualToString:@"Other: With Description"])
            NSLog(@"infoDict read: %@ for label Other: %@", key, desc);
        else
            NSLog(@"infoDict read: %@ for label %@", key, value);
    }
}

- (void) loadList
{    
    self.infoDict = [self loadListSpec:@"photoinfo.plist"];
}

- (void) saveList
{    
    [self saveListSpec:self.infoDict withFileName:@"photoinfo.plist"];    
}

- (BOOL) isReqLab:(NSString*)testLabel
{
    int i;
    int tot = [self.requiredLabelArr count];
    
    for (i = 0; i < tot; i++)
    {
        if ([testLabel isEqualToString:[self.requiredLabelArr objectAtIndex:i]])
        {
            return YES;
        }
    }
    return NO;
}


-(void) clearAllKeys
{
    NSNumber* num =  [NSNumber numberWithBool:NO];
    
    NSInteger i;
    
    for (i = 0; i < [gSingleton.mainData count]; i++)
    {
        [[gSingleton.mainData objectAtIndex:i] setObject:num forKey:@"selected"];
    }
}


//####


- (void) checkDir:(NSString*) directory
{
    NSFileManager *fileManager= [NSFileManager defaultManager]; 
    
    BOOL isDir;
    
    if(![fileManager fileExistsAtPath:directory isDirectory:&isDir])
    {
        if(![fileManager createDirectoryAtPath:directory withIntermediateDirectories:YES attributes:nil error:NULL])
        {
            NSLog(@"Error: Create folder failed %@", directory);
        }
    }
}

- (NSString*) getDataDirRelative
{
    NSString* res = [NSString stringWithFormat:@"data/%@", self.rootPhotoFolder ];
    return res;
}

- (NSString*) getDataDirFull
{
    NSString* res = [self.docDir stringByAppendingPathComponent:[self getDataDirRelative]];
    [self checkDir:res];
    return res;
}

- (NSString*) getPhotoDirRelative
{
    NSString* res = [NSString stringWithFormat:@"photos/%@", self.rootPhotoFolder ];
    return res;
}

- (NSString*) getPhotoDirFull
{
    NSString* res = [self.docDir stringByAppendingPathComponent:[self getPhotoDirRelative]];
    [self checkDir:res];
    return res;
}

- (NSString*) getThumbDirRelative
{
    NSString* res = [NSString stringWithFormat:@"data/%@/thumbs", self.rootPhotoFolder ];
    return res;
}

- (NSString*) getThumbDirFull
{
    NSString* res = [self.docDir stringByAppendingPathComponent:[self getThumbDirRelative]];
    [self checkDir:res];
    return res;
}

- (NSArray*) getPhotoDirContents
{
    NSFileManager *fm = [NSFileManager defaultManager];
    self.dirContents = [fm contentsOfDirectoryAtPath:[self getPhotoDirFull] error:nil];
    
    return self.dirContents;
}

- (NSInteger) getDirCount
{
    return [[self getPhotoDirContents] count];
}

-(NSMutableDictionary*) loadListSpec:(NSString*)dFileName
{
    NSMutableDictionary* dToLoad;
    NSString *ldFile = [[self getDataDirFull] stringByAppendingPathComponent:dFileName];
    
    NSLog(@"loadListSpec: %@", ldFile);

    dToLoad = [[NSMutableDictionary alloc] initWithContentsOfFile:ldFile];
    if (!dToLoad)
    {
        dToLoad = [NSMutableDictionary new];
        [dToLoad writeToFile:ldFile atomically:YES];
    }
    
    return dToLoad;
}

- (void) saveListSpec:(NSMutableDictionary*)dToSave withFileName:(NSString*)dFileName
{    
    NSString *ldFile = [[self getDataDirFull] stringByAppendingPathComponent:dFileName];
    NSLog(@"saveListSpec: %@", ldFile);
    [dToSave writeToFile:ldFile atomically:NO];
}

/*
- (NSString*)base64forData:(NSData*)theData {
    
    const uint8_t* input = (const uint8_t*)[theData bytes];
    NSInteger length = [theData length];
    
    static char table[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
    
    NSMutableData* data = [NSMutableData dataWithLength:((length + 2) / 3) * 4];
    uint8_t* output = (uint8_t*)data.mutableBytes;
    
    NSInteger i;
    for (i=0; i < length; i += 3) {
        NSInteger value = 0;
        NSInteger j;
        for (j = i; j < (i + 3); j++) {
            value <<= 8;
            
            if (j < length) {
                value |= (0xFF & input[j]);
            }
        }
        
        NSInteger theIndex = (i / 3) * 4;
        output[theIndex + 0] =                    table[(value >> 18) & 0x3F];
        output[theIndex + 1] =                    table[(value >> 12) & 0x3F];
        output[theIndex + 2] = (i + 1) < length ? table[(value >> 6)  & 0x3F] : '=';
        output[theIndex + 3] = (i + 2) < length ? table[(value >> 0)  & 0x3F] : '=';
    }
    
    return [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
}
*/

-(void) updateLabelDB:(NSString*)name
{
    NSString *req = @"0";
    
    NSDictionary* dict = [self.infoDict objectForKey: name];
    
    if (dict != nil)
    {
        NSString *curLabel = [dict objectForKey:@"label"];
        NSString *curDesc = [dict objectForKey:@"description"];
        if (curLabel != nil)
        {
            if ([self isReqLab:curLabel])
            {
                req = @"1";
            }
            NSDictionary *myObj = [[NSDictionary alloc] initWithObjectsAndKeys:
                                   @"msg",@"property",
                                   @"update",@"op",
                                   self.orderNumber, @"order_id",
                                   name, @"name",
                                   curLabel,@"label",
                                   curDesc,@"description",
                                   req,@"required",
                                   nil];
            [self.msgQ addObject:myObj];
        }
    }
}

-(void) updateAllDB
{
    NSArray* dirArr = [self getPhotoDirContents];
    
    NSInteger i;
    
    for (i = 0; i < [dirArr count]; i++)
    {
        [self updateLabelDB:[dirArr objectAtIndex:i]];
    }
}

-(void) saveImage:(UIImage*)image withName:(NSString *)name
{    
    CGSize origSize = [image size];//image.size;
    CGSize largeSize;
    CGSize smallSize;
    
    NSLog(@"Saving image (%.f x %.f) with name %@", origSize.width, origSize.height, name);

    if (origSize.height > origSize.width)
    {
        largeSize.height = 640;
        largeSize.width = (640 / origSize.height) * origSize.width;
    }
    else
    {
        largeSize.width = 640;
        largeSize.height = (640 / origSize.width) * origSize.height;        
    }
    smallSize.width = 0.234 * largeSize.width;
    smallSize.height = 0.234 * largeSize.height;
    
    NSLog(@"Resized size: %.f x %.f", largeSize.width, largeSize.height);
    
    UIGraphicsBeginImageContext(largeSize);
    [image drawInRect:CGRectMake(0,0,largeSize.width,largeSize.height)];
    UIImage* largeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIGraphicsBeginImageContext(smallSize);
    [image drawInRect:CGRectMake(0,0,smallSize.width,smallSize.height)];
    UIImage* smallImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //UIImage *sLargeImage = [[[UIImage alloc] initWithData: [image ] ] scaleToSize:CGSizeMake(640.0,480.0)];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSData *data = UIImageJPEGRepresentation(largeImage, 1.0);
    NSString *fullPath = [[self getPhotoDirFull] stringByAppendingPathComponent:name];
    NSLog(@"fullPath: %@", fullPath);    
    NSString *relativePath = [[self getPhotoDirRelative] stringByAppendingPathComponent:name];
    NSLog(@"relativePath: %@", relativePath);
    [fileManager createFileAtPath:fullPath contents:data attributes:nil];
    
    NSData *data2 = UIImageJPEGRepresentation(smallImage, 1.0);
    NSString *fullPath2 = [[self getThumbDirFull] stringByAppendingPathComponent:name];
    NSLog(@"fullPath2: %@", fullPath2);    
    NSString *relativePath2 = [[self getThumbDirRelative] stringByAppendingPathComponent:name];
    NSLog(@"relativePath2: %@", relativePath2);
    [fileManager createFileAtPath:fullPath2 contents:data2 attributes:nil];
    
    NSString *req = @"0";
    
    if ([self isReqLab:currentLabelString])
    {
        req = @"1";
    }
    
    NSDictionary *myObj = [[NSDictionary alloc] initWithObjectsAndKeys:
                           @"msg",@"property",
                           @"insert",@"op",
                           self.orderNumber, @"order_id",
                           name, @"name",
                           self.currentLabelString, @"label",
                           self.currentLabelDescription, @"description",
                           relativePath, @"photo_data",
                           relativePath2, @"thumb_data",
                           req, @"required",
                           nil];
    [self.msgQ addObject:myObj];
    
    self.photoCount++;
    self.newPhotos = YES;
}

- (void)renameImage:(NSString *)oldName withName:(NSString *)newName
{
    NSLog(@"renameImage %@ to %@", oldName, newName);
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSString *oldPath = [[self getPhotoDirFull] stringByAppendingPathComponent:oldName];
    NSString *newPath = [[self getPhotoDirFull] stringByAppendingPathComponent:newName];
    [fileManager moveItemAtPath:oldPath toPath:newPath error:nil];
    
    NSString *oldPath2 = [[self getThumbDirFull] stringByAppendingPathComponent:oldName];
    NSString *newPath2 = [[self getThumbDirFull] stringByAppendingPathComponent:newName];
    [fileManager moveItemAtPath:oldPath2 toPath:newPath2 error:nil];
     
    [self.infoDict setObject:[self.infoDict objectForKey:oldName] forKey:newName];
    [self removeInfoEntry:oldName];
    //[self updateLabelDB:oldName renameTo:newName];
}

- (void)delImage:(NSString *)name
{
    self.photoCount--;
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSString *fullPath = [[self getPhotoDirFull] stringByAppendingPathComponent:name];
    [fileManager removeItemAtPath:fullPath error:NULL];
    
    NSString *fullPath2 = [[self getThumbDirFull] stringByAppendingPathComponent:name];
    [fileManager removeItemAtPath:fullPath2 error:NULL];
    
    [self removeInfoEntry:name];
    
    NSDictionary *myObj = [[NSDictionary alloc] initWithObjectsAndKeys:
                           @"msg",@"property",
                           @"delete",@"op",
                           self.orderNumber, @"order_id",
                           name,@"name",
                           self.currentLabelString,@"label",
                           self.currentLabelDescription,@"description",
                           //rr,@"required",
                           nil];
    [self.msgQ addObject:myObj];
}

//####

- (void)dealloc 
{
}

@end