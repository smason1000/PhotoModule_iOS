//
//  Photo.h
//  PhotoHub
//
//  Created by Scott Mason on 11/27/12.
//  Copyright (c) 2012 Apex-net srl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PTShowcase.h"
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

@interface Photo : NSObject
{
    NSString    *_order_id;
    NSInteger   _question_row;
    NSString    *_path;
    NSString    *_name;
    NSString    *_label;
    NSString    *_description;
    NSInteger   _upload_status;
    NSString    *_date_sent;
    NSString    *_user_id;
    NSString    *_photo_data;
    NSString    *_thumb_data;
    NSInteger   _required;
    NSString    *_question_id;
    NSString    *_possible_labels;
    PTItemOrientation _orientation;
    BOOL        _selected;
}

@property (nonatomic) NSString *order_id;
@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NSString* label;
@property (nonatomic, strong) NSString* description;
@property (nonatomic) NSInteger upload_status;
@property (nonatomic, strong) NSString* user_id;
@property (nonatomic, strong) NSString* photo_data;
@property (nonatomic, strong) NSString* thumb_data;
@property (nonatomic) NSInteger question_row;
@property (nonatomic) NSInteger required;
@property (nonatomic) PTItemOrientation orientation;
@property (nonatomic) BOOL selected;

-(id)initWithOrderId:(NSString *)anOrderId
             andName:(NSString*)aName
            andLabel:(NSString*)aLabel
      andDescription:(NSString*)aDescription
     andUploadStatus:(NSNumber*)anUploadStatus
           andUserId:(NSString*)aUserId
        andPhotoData:(NSString*)aPhotoData
        andThumbData:(NSString*)aThumbData
         andRequired:(NSNumber*)aRequired;

-(id)initWithOrderId:(NSString *)anOrderId
             andName:(NSString*)aName
           andUserId:(NSString*)aUserId;

+(NSMutableArray *)getPhotos:(NSString *)withOrderId andUserId:(NSString *)aUserId;
+(Photo *)getPhoto:(NSString *)withOrderId andUserId:(NSString *)aUserId andName:(NSString *)aName andCreateIfNotInDB:(BOOL)aCreateFlag;
-(NSString *)photoPath;
-(NSString *)thumbPath;

-(BOOL)updateDatabaseEntry;
-(BOOL)deleteDatabaseEntry;

@end