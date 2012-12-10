//
//  Photo.m
//  PhotoHub
//
//  Created by Scott Mason on 11/27/12.
//  Copyright (c) 2012 Apex-net srl. All rights reserved.
//

#import "WorkOrder.h"
#import "DataController.h"

@implementation WorkOrder

@synthesize order_id = _order_id;
@synthesize user_id = _user_id;
@synthesize status_id = _status_id;

#pragma mark Initialization Methods

/*
var workOrdersObj = {
 order_id:t,
 status_id:i,
 loan_number:t,
 user_id:t,
 vacant:t,
 rush:t,
 zip_code:i,
 street_number:i,
 street_name:t,
 address:t,
 city:t,
 fname:t,
 lname:t,
 is_2535:t,
 photoRequired:t,
 photosRequired:tnn,
 due_date:i,
 client:t,
 displayclient:t,
 status:i,
 followup_spitext:t,
 followup_spiid:i,
 followup_response:t,
 followup_response_date:t,
 followup_status:i,
 transmit_date:t,
 download_date:i,
 deletePending:i,
 start_date:i,
 details:t,
 results:t,
 savedStateData:t,
 discrepancy_text:t,
 previouscontactresults:tnn,
 previousoccstat: tnn,
 lat:r,
 lng:r,
preFillData:tnn
};
*/

-(id)initWithOrderId:(NSString*)anOrderId
           andUserId:(NSString*)aUserId
{
    self = [super init];
    if (self)
    {
        self.order_id = anOrderId;
        self.user_id = aUserId;
        self.status_id = -1;
    }
    return self;
}

#pragma mark Internal Methods

#pragma mark Public Methods

+(WorkOrder *)getWorkOrder:(NSString *)withOrderId andUserId:(NSString *)aUserId
{
    WorkOrder *aWorkOrder = nil;
    @try
    {
        NSString *sql = @"SELECT order_id, user_id, status_id FROM work_orders WHERE order_id = ? and user_id = ?";
        
        sqlite3_stmt *stmt = [gSingleton.dbController execute:[NSArray arrayWithObjects:sql, withOrderId, aUserId, nil]];
        @try
        {
            // get the rows and put them in the return array
            if (sqlite3_step(stmt) == SQLITE_ROW)
            {
                aWorkOrder = [[WorkOrder alloc] init];
                
                int i = 0;
                
                // order_id
                char *text = (char *) sqlite3_column_text(stmt,i++);
                aWorkOrder.order_id = text != NULL ? [NSString stringWithUTF8String:text] : [NSNull null];
                // user_id
                text = (char *) sqlite3_column_text(stmt,i++);
                aWorkOrder.user_id = text != NULL ? [NSString stringWithUTF8String:text] : [NSNull null];
                // status_id
                aWorkOrder.status_id = sqlite3_column_int(stmt,i++);
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
    @catch (NSException *exception)
    {
        NSLog(@"An exception occured: %@", [exception reason]);
    }
    @finally
    {
        return aWorkOrder;
    }
}

@end