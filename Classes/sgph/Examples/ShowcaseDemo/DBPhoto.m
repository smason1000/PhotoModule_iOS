//
//  Photo.m
//  PhotoHub
//
//  Created by Scott Mason on 11/27/12.
//  Copyright (c) 2012 Apex-net srl. All rights reserved.
//

#import "DBPhoto.h"

@implementation DBPhoto

@synthesize order_id = _order_id;
@synthesize question_row = _question_row;
@synthesize path = _path;
@synthesize name = _name;
@synthesize label = _label;
@synthesize description = _description;
@synthesize upload_status = _upload_status;
@synthesize date_sent = _date_sent;
@synthesize user_id = _user_id;
@synthesize photo_data = _photo_data;
@synthesize thumb_data = _thumb_data;
@synthesize required = _required;
@synthesize question_id = _question_id;
@synthesize possible_labels = _possible_labels;

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
   andPossibleLabels:(NSString*)aPossibleLabels
{
    self = [super init];
    if (self)
    {
        //self.streetName = aStreetName;
        //self.streetNumber = aStreetNumber;
    }
    return self;
}

@end
