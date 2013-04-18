//
//  PhotoLabel.m
//  PhotoHub
//
//  Created by Scott Mason on 3/31/13.
//  Copyright (c) 2013 Apex-net srl. All rights reserved.
//

#import "PhotoLabel.h"

@implementation PhotoLabel

@synthesize label = _label;
@synthesize prefix = _prefix;
@synthesize question_id = _question_id;
@synthesize category = _category;
@synthesize required = _required;
@synthesize count = _count;

#pragma mark Initialization Methods

-(id)initWithDictionaryItem:(NSDictionary *)item
{
    self = [super init];
    if (self)
    {
        NSNumber *aNumber;
        
        self.label = [item objectForKey:@"label"];
        self.prefix = [item objectForKey:@"prefix"];
        self.question_id = [item objectForKey:@"questionId"];
        self.category = [item objectForKey:@"category"];
        aNumber = [item objectForKey:@"required"];
        if (aNumber != nil)
            self.required = [aNumber integerValue];
        else
            self.count = 0;
        aNumber = [item objectForKey:@"count"];
        if (aNumber != nil)
            self.count = [aNumber integerValue];
        else
            self.count = 1;
    }
    return self;
}

-(id)initWithLabel:(NSString*)aLabel
            andPrefix:(NSString*)aPrefix
            andQuestionId:(NSString*)aQuestionId
            andCategory:(NSString *)aCategory
            andIsRequired:(NSInteger)isRequired
            andCount:(NSInteger)aCount
{
    self = [super init];
    if (self)
    {
        self.label = aLabel;
        self.prefix = aPrefix;
        self.question_id = aQuestionId;
        self.category = aCategory;
        self.required = isRequired;
        self.count = aCount;
    }
    return self;
}

#pragma mark Internal Methods

-(NSString *)getDisplayText
{
    if ([self.prefix length] > 0)
    {
        return ([NSString stringWithFormat:@"%@ - %@", self.label, self.prefix]);
    }
    else
    {
        return self.label;
    }
}

-(NSString *)getLabelerText
{
    NSString *text = [self.label copy];
    
    if ([self.prefix length] > 0)
    {
        text = [NSString stringWithFormat:@"%@ - %@", self.label, self.prefix];
    }
    if (self.count > 1)
    {
        text = [NSString stringWithFormat:@"%@ (x%d)", text, self.count];
    }
    return text;
}

@end
