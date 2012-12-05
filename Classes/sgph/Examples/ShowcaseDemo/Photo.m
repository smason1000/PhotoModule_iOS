//
//  Photo.m
//  PhotoHub
//
//  Created by Scott Mason on 11/27/12.
//  Copyright (c) 2012 Apex-net srl. All rights reserved.
//

#import "Photo.h"
#import "WorkOrder.h"
#import "DataController.h"

const int QUESTION_ROW_HUB = -42;

@implementation Photo

@synthesize order_id = _order_id;
@synthesize name = _name;
@synthesize label = _label;
@synthesize description = _description;
@synthesize upload_status = _upload_status;
@synthesize user_id = _user_id;
@synthesize photo_data = _photo_data;
@synthesize thumb_data = _thumb_data;
@synthesize required = _required;
@synthesize orientation = _orientation;
@synthesize selected = _selected;
@synthesize question_row = _question_row;

#pragma mark Initialization Methods

-(id)initWithOrderId:(NSString*)anOrderId
             andName:(NSString*)aName
            andLabel:(NSString*)aLabel
      andDescription:(NSString*)aDescription
     andUploadStatus:(NSNumber*)anUploadStatus
           andUserId:(NSString*)aUserId
        andPhotoData:(NSString*)aPhotoData
        andThumbData:(NSString*)aThumbData
         andRequired:(NSNumber*)aRequired
{
    self = [super init];
    if (self)
    {
        self.order_id = anOrderId;
        self.name = aName;
        self.label = aLabel;
        self.description = aDescription;
        self.upload_status = [anUploadStatus integerValue];
        self.user_id = aUserId;
        self.photo_data = aPhotoData;
        self.thumb_data = aThumbData;
        self.required = [aRequired integerValue];
        self.orientation = PTItemOrientationPortrait;
        self.question_row = QUESTION_ROW_HUB;
        self.selected = NO;
    }
    return self;
}
-(id)initWithOrderId:(NSString*)anOrderId
             andName:(NSString*)aName
           andUserId:(NSString*)aUserId
{
    self = [super init];
    if (self)
    {
        self.order_id = anOrderId;
        self.name = aName;
        self.label = @"";
        self.description = @"";
        self.upload_status = -1;
        self.user_id = aUserId;
        self.photo_data = @"";
        self.thumb_data = @"";
        self.required = 0;
        self.question_row = QUESTION_ROW_HUB;
        self.orientation = PTItemOrientationPortrait;
        self.selected = NO;
    }
    return self;
}

#pragma mark Internal Methods

-(NSNumber *)getPhotoUploadStatus:(WorkOrder *)aWorkOrder andLabel:(NSString *)aLabel
{
	//check if the photo's order has been submitted so its status can be set appropriately...
	NSNumber *uploadStatus = NUMINT(kStatusPhotoPendingOrder);
    
	// make sure we have a label and a photo file
	if ([UNLABELED_STRING isEqualToString:aLabel])
	{
		uploadStatus = NUMINT(kStatusPhotoNotReady);
	}
	else
	{
		if (aWorkOrder.status_id == kStatusSubmitted)
		{
			uploadStatus = NUMINT(kStatusPhotoReady);
			//app.global.setVal("pendingOrders","true");
		}
	}
	return uploadStatus;
}

-(BOOL)insertDatabaseEntry
{
    /*
     Ti.API.info(String.format("Insert operation: %s,%s,%s,'%s'", e.order_id, e.name, e.label, desc));
     uploadStatus = getPhotoUploadStatus(e.order_id, e.label);
     insertObj = {
        order_id: e.order_id,  			//currentOrderId,
        name: e.name,              		//app.global.getVal("user")+"_"+new Date().getTime(),
        label: e.label, 				//labelsArr[0],
        description: desc,
        upload_status: uploadStatus,	//app.global.PHOTO_STATUS_ID.notready,
        photo_data: e.photo_data,      	//"",
        thumb_data: e.thumb_data,      	//"",
        required: e.required       		//0,1
        //question_id: 	//"",
        //possible_labels://allPhotoLabels
     };
     executeInsertSql("photos",insertObj,true);
    */
    BOOL rc;
    
    WorkOrder *aWorkOrder = [WorkOrder getWorkOrder:[self order_id] andUserId:[self user_id]];
    NSNumber *uploadStatus = [self getPhotoUploadStatus:aWorkOrder andLabel:[self label]];
    
    NSString *sql = @"INSERT INTO photos (order_id, name, label, description, upload_status, user_id, photo_data, thumb_data, required, question_row) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
    
    sqlite3_stmt *stmt = [gSingleton.dbController execute:[NSArray arrayWithObjects:sql, self.order_id, self.name, self.label, self.description, uploadStatus, self.user_id, self.photo_data, self.thumb_data, NUMINT(self.required), NUMINT(self.question_row), nil]];
    @try
    {
        if (sqlite3_step(stmt) == SQLITE_DONE)
        {
            rc = YES;
        }
        else
        {
            rc = NO;
        }
    }
    @catch (NSException *e)
    {
        NSLog(@"Caught exception in insertDatabaseEntry %@: %@", e.name, e.reason);
    }
    @finally
    {
        sqlite3_finalize(stmt);
        [gSingleton.dbController close];
    }
    return rc;
}

-(NSString *)photoPath
{
    return [[gSingleton docDir] stringByAppendingPathComponent:self.photo_data];
}

-(NSString *)thumbPath
{
    return [[gSingleton docDir] stringByAppendingPathComponent:self.thumb_data];
}

#pragma mark Public Methods

+(NSMutableArray *)getPhotos:(NSString *)withOrderId andUserId:(NSString *)aUserId
{
    NSMutableArray *photoArray = [[NSMutableArray alloc] init];
    @try
    {
        NSString *sql = @"SELECT order_id, name, label, description, upload_status, user_id, photo_data, thumb_data, required, question_row FROM photos WHERE order_id = ? and user_id = ? and question_row = ?";
        
        sqlite3_stmt *stmt = [gSingleton.dbController execute:[NSArray arrayWithObjects:sql, withOrderId, aUserId, NUMINT(QUESTION_ROW_HUB), nil]];
        @try
        {
            // get the rows and put them in the return array
            char *text;
            while (sqlite3_step(stmt) == SQLITE_ROW)
            {
                Photo *aPhoto = [[Photo alloc] init];
                
                int i = 0;
                
                // order_id
                text = (char *) sqlite3_column_text(stmt,i++);
                aPhoto.order_id = text != NULL ? [NSString stringWithUTF8String:text] : [NSNull null];
                // name
                text = (char *) sqlite3_column_text(stmt,i++);
                aPhoto.name = text != NULL ? [NSString stringWithUTF8String:text] : [NSNull null];
                // label
                text = (char *) sqlite3_column_text(stmt,i++);
                aPhoto.label = text != NULL ? [NSString stringWithUTF8String:text] : @"";
                // description
                text = (char *) sqlite3_column_text(stmt,i++);
                aPhoto.description = text != NULL ? [NSString stringWithUTF8String:text] : @"";
                // upload_status
                aPhoto.upload_status = sqlite3_column_int(stmt,i++);
                // user_id
                text = (char *) sqlite3_column_text(stmt,i++);
                aPhoto.user_id = text != NULL ? [NSString stringWithUTF8String:text] : [NSNull null];
                // photo_data
                text = (char *) sqlite3_column_text(stmt,i++);
                aPhoto.photo_data = text != NULL ? [NSString stringWithUTF8String:text] : @"";
                // thumb_data
                text = (char *) sqlite3_column_text(stmt,i++);
                aPhoto.thumb_data = text != NULL ? [NSString stringWithUTF8String:text] : @"";
                // question_row
                aPhoto.question_row = sqlite3_column_int(stmt,i++);
                // required
                aPhoto.required = sqlite3_column_int(stmt,i++);
                // selected
                aPhoto.selected = NO;
                
                [photoArray addObject:[aPhoto self]];
            }
        }
        @catch (NSException *e)
        {
            NSLog(@"Caught exception in getPhotos %@: %@", e.name, e.reason);
        }
        @finally
        {
            sqlite3_finalize(stmt);
            [gSingleton.dbController close];
        }
    }
    @catch (NSException *exception)
    {
        NSLog(@"An exception occured: %@", [exception reason]);
    }
    @finally
    {
        return photoArray;
    }
}

+(Photo *)getPhoto:(NSString *)withOrderId andUserId:(NSString *)aUserId andName:(NSString *)aName andCreateIfNotInDB:(BOOL)aCreateFlag
{
    Photo *aPhoto = nil;
    @try
    {
        NSString *sql = @"SELECT order_id, name, label, description, upload_status, user_id, photo_data, thumb_data, required, question_row FROM photos WHERE order_id = ? and user_id = ? and name = ?";
        
        sqlite3_stmt *stmt = [gSingleton.dbController execute:[NSArray arrayWithObjects:sql, withOrderId, aUserId, aName, nil]];
        @try
        {
            // get the rows and put them in the return array
            if (sqlite3_step(stmt) == SQLITE_ROW)
            {
                aPhoto = [[Photo alloc] init];

                int i = 0;

                // order_id
                char *text = (char *) sqlite3_column_text(stmt,i++);
                aPhoto.order_id = text != NULL ? [NSString stringWithUTF8String:text] : [NSNull null];
                // name
                text = (char *) sqlite3_column_text(stmt,i++);
                aPhoto.name = text != NULL ? [NSString stringWithUTF8String:text] : [NSNull null];
                // label
                text = (char *) sqlite3_column_text(stmt,i++);
                aPhoto.label = text != NULL ? [NSString stringWithUTF8String:text] : @"";
                // description
                text = (char *) sqlite3_column_text(stmt,i++);
                aPhoto.description = text != NULL ? [NSString stringWithUTF8String:text] : @"";
                // upload_status
                aPhoto.upload_status = sqlite3_column_int(stmt,i++);
                // user_id
                text = (char *) sqlite3_column_text(stmt,i++);
                aPhoto.user_id = text != NULL ? [NSString stringWithUTF8String:text] : [NSNull null];
                // photo_data
                text = (char *) sqlite3_column_text(stmt,i++);
                aPhoto.photo_data = text != NULL ? [NSString stringWithUTF8String:text] : @"";
                // thumb_data
                text = (char *) sqlite3_column_text(stmt,i++);
                aPhoto.thumb_data = text != NULL ? [NSString stringWithUTF8String:text] : @"";
                // question_row
                aPhoto.question_row = sqlite3_column_int(stmt,i++);
                // required
                aPhoto.required = sqlite3_column_int(stmt,i++);
                // selected
                aPhoto.selected = NO;
            }
            else
            {
                if (aCreateFlag)
                {
                    aPhoto = [[Photo alloc] init];

                    aPhoto.order_id = withOrderId;
                    aPhoto.user_id = aUserId;
                    aPhoto.name = aName;
                    aPhoto.label = @"";
                    aPhoto.description = @"";
                    aPhoto.photo_data = @"";
                    aPhoto.thumb_data = @"";
                    aPhoto.required = 0;
                    aPhoto.question_row = QUESTION_ROW_HUB;
                    aPhoto.selected = NO;
                }
            }
        }
        @catch (NSException *e)
        {
            NSLog(@"Caught exception in getPhoto %@: %@", e.name, e.reason);
        }
        @finally
        {
            sqlite3_finalize(stmt);
            [gSingleton.dbController close];
        }
    }
    @catch (NSException *exception)
    {
        NSLog(@"An exception occurred getting Photo: %@", [exception reason]);
    }
    @finally
    {
        return aPhoto;
    }
}

-(BOOL)updateDatabaseEntry
{
    BOOL rc;
    
    if ([self name] != nil)
    {
        // Check to see if we need to do an insert
        Photo *photoInDb = [Photo getPhoto:[self order_id] andUserId:[self user_id] andName:[self name] andCreateIfNotInDB:NO];
        if (photoInDb == nil)
            return [self insertDatabaseEntry];
        
        // we know that we just need to update our phot entry since it's already in the database
        WorkOrder *aWorkOrder = [WorkOrder getWorkOrder:[self order_id] andUserId:[self user_id]];
        NSNumber *uploadStatus = [self getPhotoUploadStatus:aWorkOrder andLabel:[self label]];
    
        /*
         Ti.API.info(String.format("Update operation: %s,%s,%s,'%s'", e.order_id, e.name, e.label, desc));
         var photoRow;
         photoRow = getSelectFirstRow("photos",{order_id:e.order_id, name:e.name},true);
    
         if (photoRow)
         {
            // the photo was in the database, make sure we don't edit an already uploaded photo
            if (photoRow.upload_status !== app.global.PHOTO_STATUS_ID.uploaded)
            {
                uploadStatus = getPhotoUploadStatus(e.order_id, e.label);
                executeUpdateSql("photos",{upload_status:uploadStatus, label:e.label, description:desc},{order_id:e.order_id, name:e.name},true);
            }
         }
         else
         {
            Ti.API.error("Property update operation without database entry!");
         }
         */
        // the photo was in the database, make sure we don't edit an already uploaded photo

        if (photoInDb.upload_status != kStatusPhotoUploaded)
        {
            NSString *sql = @"UPDATE photos SET upload_status = ?, label = ?, description = ?, photo_data = ?, thumb_data = ?, required = ?, question_row = ? WHERE order_id = ? AND name = ? AND user_id = ?";
            
            sqlite3_stmt *stmt = [gSingleton.dbController execute:[NSArray arrayWithObjects:sql, uploadStatus, self.label, self.description, self.photo_data, self.thumb_data, NUMINT(self.required), NUMINT(self.question_row), self.order_id, self.name, self.user_id, nil]];
            @try
            {
                if (sqlite3_step(stmt) == SQLITE_DONE)
                {
                    rc = YES;
                }
                else
                {
                    rc = NO;
                }
            }
            @catch (NSException *e)
            {
                NSLog(@"Caught exception in updateDatabaseEntry %@: %@", e.name, e.reason);
            }
            @finally
            {
                sqlite3_finalize(stmt);
                [gSingleton.dbController close];
            }
            return rc;
        }
        else
        {
            rc = NO;
        }
    }
    return rc;
}

-(BOOL)deleteDatabaseEntry
{
    BOOL rc = NO;
    
    if ([self name] != nil)
    {
        // Create insert statement for the person
        NSString *sql = @"DELETE FROM photos WHERE name = ?";
        
        sqlite3_stmt *stmt = [gSingleton.dbController execute:[NSArray arrayWithObjects:sql, self.name, nil]];
        @try
        {
            int code = sqlite3_step(stmt);
            if (code == SQLITE_DONE)
            {
                rc = YES;
            }
            else
            {
                [gSingleton.dbController showSQLiteError:@"Delete Photo Error (Exec)" code:NUMINT(code)];
                rc = NO;
            }
        }
        @catch (NSException *e)
        {
            NSLog(@"Caught exception in deleteDatabaseEntry %@: %@", e.name, e.reason);
        }
        @finally
        {
            sqlite3_finalize(stmt);
            [gSingleton.dbController close];
        }
    }
    return rc;
}

-(BOOL)updateRequired
{
    BOOL rc = NO;
    
    if ([self name] != nil)
    {
        // Create insert statement for the person
        if ([self name] != nil)
        {
            // Create insert statement for the person
            NSString *sql = @"UPDATE photos SET required = ? WHERE name = ?";
            
            sqlite3_stmt *stmt = [gSingleton.dbController execute:[NSArray arrayWithObjects:sql, NUMINT(self.required), self.name, nil]];
            @try
            {
                int code = sqlite3_step(stmt);
                if (code == SQLITE_DONE)
                {
                    rc = YES;
                }
                else
                {
                    [gSingleton.dbController showSQLiteError:@"Update Required Error (Exec)" code:NUMINT(code)];
                    rc = NO;
                }
            }
            @catch (NSException *e)
            {
                NSLog(@"Caught exception in updateRequired %@: %@", e.name, e.reason);
            }
            @finally
            {
                sqlite3_finalize(stmt);
                [gSingleton.dbController close];
            }
        }
    }
    return rc;
}

@end