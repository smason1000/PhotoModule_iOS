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

@interface DBPhoto : NSObject
{
    NSInteger   order_id;
    NSInteger   question_row;
    NSString    *path;
    NSString    *name;
    NSString    *label;
    NSString    *description;
    NSInteger   upload_status;
    NSString    *date_sent;
    NSString    *user_id;
    NSString    *photo_data;
    NSString    *thumb_data;
    NSInteger   *required;
    NSString    *question_id;
    NSString    *possible_labels;
}

@property (nonatomic) NSInteger order_id;
@property (nonatomic) NSInteger question_row;
@property (nonatomic, strong) NSString* path;
@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NSString* label;
@property (nonatomic, strong) NSString* description;
@property (nonatomic) NSInteger upload_status;
@property (nonatomic, strong) NSString* date_sent;
@property (nonatomic, strong) NSString* user_id;
@property (nonatomic, strong) NSString* photo_data;
@property (nonatomic, strong) NSString* thumb_data;
@property (nonatomic) NSInteger required;
@property (nonatomic, strong) NSString* question_id;
@property (nonatomic, strong) NSString* possible_labels;

-(id)initWithOrderId:(NSInteger)anOrderId
            andQuestionRow:(NSInteger)aQuestionRow
            andPath:(NSString*)aPath
            andName:(NSString*)aName
            andLabel:(NSString*)aLabel
            andDescription:(NSString*)aDescription
            andUploadStatus:(NSInteger)anUploadStatus
            andDateSent:(NSString*)aDateSent
            andUserId:(NSString*)aUserId
            andPhotoData:(NSString*)aPhotoData
            andThumbData:(NSString*)aThumbData
            andRequired:(NSInteger)aRequired
            andQuestionId:(NSString*)aQuestionId
            andPossibleLabels:(NSString*)aPossibleLabels;

@end
