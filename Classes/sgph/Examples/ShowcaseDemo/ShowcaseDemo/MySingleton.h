#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


NSComparisonResult compareLetters(id t1, id t2, void* context);

//./build.py;unzip -o com.phmod-iphone-0.1.zip -d ~/Desktop/Safeguard

@class MySingleton;
extern MySingleton *gSingleton;


typedef enum
{
    PHFilterModeAll,
    PHFilterModeLabeled,
    PHFilterModeUnlabeled,
    PHFilterModeRequiredLabels
    
} PHFilterMode;


typedef enum
{
    PHASLabelFS,
    PHASViewfinder,
    PHASGrid,
    PHASExpanded,
    
} PHAppState;

typedef enum
{
    PHPSNotReady,		// no photo is assigned to this label, or no label is assigned to this photo
    PHPSPendingOrder,	// photo is ready, but waiting for the order to be sent
    PHPSReady,			// Photo Ready to send
    PHPSUploaded,		// Photo has been sent
    PHPSUploadFailed    // Photo failed to send
} PHPhotoStatus;

@interface MySingleton : NSObject
{
    //NSString *someProperty;
    BOOL newPhotos;
    BOOL expandOn;
    BOOL editOn;
    BOOL filterOn;
    BOOL iPadDevice;
    BOOL isModule;
    BOOL doRef;
    BOOL openToGallery;
    BOOL applyCaptureDefaults;
    
    PHFilterMode currentFilterMode;
    PHAppState currentAppState;
    
    NSMutableArray* msgQ;
    
    NSMutableDictionary* infoDict;
    NSMutableDictionary* selDict;
    NSMutableArray* mainData;
    NSMutableArray *labelArr;
    NSMutableArray *requiredLabelArr;
    NSMutableArray *itemArray;
    NSArray *hashVals;
    NSArray *hashValsReq;
    NSArray *curHashVals;
    NSString *currentLabelString;
    NSInteger relativeIndex;
    NSInteger photoCount; 
    NSInteger requiredCount; 
    NSInteger labeledCount;
    NSString* orderNumber;
    NSString* docDir;
    
    
    NSMutableArray *dirContents;
    
    NSArray* curLetArray;
}

//@property (nonatomic, retain) NSString *someProperty;
@property (nonatomic) BOOL newPhotos;
@property (nonatomic) BOOL expandOn;
@property (nonatomic) BOOL editOn;
@property (nonatomic) BOOL filterOn;
@property (nonatomic) BOOL iPadDevice;
@property (nonatomic) BOOL isModule;
@property (nonatomic) BOOL doRef;
@property (nonatomic) BOOL openToGallery;
@property (nonatomic) BOOL applyCaptureDefaults;
@property (nonatomic) BOOL showTrace;


@property (nonatomic) PHFilterMode currentFilterMode;
@property (nonatomic) PHAppState currentAppState;

@property (nonatomic) NSInteger relativeIndex;
@property (nonatomic) NSInteger photoCount;
@property (nonatomic) NSInteger requiredCount;
@property (nonatomic) NSInteger labeledCount;


@property (nonatomic, retain) NSMutableArray *dirContents;
@property (nonatomic, retain) NSArray* curLetArray;
@property (nonatomic, retain) NSMutableArray* msgQ;

@property (nonatomic, retain) NSMutableArray* mainData;
@property (nonatomic, retain) NSMutableDictionary* selDict;
@property (nonatomic, retain) NSMutableDictionary* infoDict;
@property (nonatomic, retain) NSMutableArray *labelArr;
@property (nonatomic, retain) NSMutableArray *requiredLabelArr;

@property (nonatomic, retain) NSArray *curHashVals;
@property (nonatomic, retain) NSArray *hashVals;
@property (nonatomic, retain) NSArray *hashValsReq;

@property (nonatomic, retain) NSMutableArray *itemArray;

@property (nonatomic, retain) NSString *currentLabelString;
@property (nonatomic, retain) NSString *currentLabelDescription;

@property (nonatomic, retain) NSString* orderNumber;
@property (nonatomic, retain) NSString* rootPhotoFolder;
@property (nonatomic, retain) NSString* todaysPhotoFolder;
@property (nonatomic, retain) NSString* docDir;

+ (id)sharedSingleton;

- (NSString*) getDataDirFull;
- (NSString*) getDataDirRelative;
- (NSString*) getPhotoDirFull;
- (NSString*) getPhotoDirRelative;
- (NSString*) getThumbDirFull;
- (NSString*) getThumbDirRelative;

- (NSMutableDictionary*) getInfoEntry:(NSString *)key;
- (void)loadList;
- (void)saveList;
- (BOOL) isReqLab:(NSString*)testLabel;
- (void) updateLabelHash;


- (NSMutableArray*) getPhotoDirContents;
- (NSInteger) getDirCount;
- (void)delImage:(NSString *)name;
- (void)saveImage:(UIImage *)image withName:(NSString *)name;
- (void)renameImage:(NSString *)oldName withName:(NSString *)newName;



- (void) setLabels:(NSString*)newLabels;
- (void) setReqLabels:(NSString*)newLabels withUpdate:(BOOL)doDBUpdate;
- (void) setOrderNum:(NSString *)orderNum;
- (void) setRootPhotoFolder:(NSString *)aFolder;
- (void) setTodaysPhotoFolder:(NSString *)aFolder;
- (void) setReqCount:(NSString *)newCount;
- (void) updateLabelDB:(NSString*)name;
- (void) setHashReq:(BOOL)isReq;
- (void) clearAllKeys;

@end