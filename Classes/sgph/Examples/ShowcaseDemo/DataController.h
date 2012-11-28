//
//  DataController.h
//  PhotoHub
//
//  Created by Scott Mason on 11/27/12.
//  Copyright (c) 2012 Apex-net srl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface DataController : NSObject
{
    sqlite3 *databaseHandle;
}

-(NSString*)dbPath:(NSString*)name;

@end