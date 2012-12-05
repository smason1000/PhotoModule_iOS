//
//  Photo.h
//  PhotoHub
//
//  Created by Scott Mason on 11/27/12.
//  Copyright (c) 2012 Apex-net srl. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
from schema.js
 
var photosObj = {
 order_id:i,
 question_row:i,
 path:t,
 name:t,
 label:t,
 description:t,
 upload_status:i,
 date_sent: t,
 user_id:t,
 photo_data:t,
 thumb_data:t,
 required:i,
 question_id:t,
 possible_labels:t
};
*/

@interface WorkOrder : NSObject
{
    NSInteger   order_id;
    NSString    *user_id;
}

@property (nonatomic) NSString *order_id;
@property (nonatomic, strong) NSString* user_id;
@property (nonatomic) NSInteger status_id;

-(id)initWithOrderId:(NSString *)anOrderId
           andUserId:(NSString*)aUserId;

+(WorkOrder *)getWorkOrder:(NSString *)withOrderId andUserId:(NSString *)aUserId;

@end
