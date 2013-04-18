//
//  PhotoLabel.h
//  PhotoHub
//
//  Created by Scott Mason on 3/31/13.
//  Copyright (c) 2013 Apex-net srl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PhotoLabel : NSObject
{
    NSString    *_label;
    NSString    *_prefix;
    NSString    *_question_id;
    NSString    *_category;
    NSInteger   _required;
    NSInteger   _count;
}

@property (nonatomic, strong) NSString *label;
@property (nonatomic, strong) NSString* prefix;
@property (nonatomic, strong) NSString* question_id;
@property (nonatomic, strong) NSString* category;
@property (nonatomic) NSInteger required;
@property (nonatomic) NSInteger count;

-(id)initWithDictionaryItem:(NSDictionary *)item;

-(id)initWithLabel:(NSString*)aLabel
         andPrefix:(NSString*)aPrefix
     andQuestionId:(NSString*)aQuestionId
       andCategory:(NSString *)aCategory
     andIsRequired:(NSInteger)isRequired
          andCount:(NSInteger)aCount;

-(NSString *)getDisplayText;
-(NSString *)getLabelerText;

@end
