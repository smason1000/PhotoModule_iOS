//
//  DataController.h
//  PhotoHub
//
//  Created by Scott Mason on 11/27/12.
//  Copyright (c) 2012 Apex-net srl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

#define CODELOCATION	[NSString stringWithFormat:@" in %s (%@:%d)",__FUNCTION__,[[NSString stringWithFormat:@"%s",__FILE__] lastPathComponent],__LINE__]
#define NUMINT(x)       [NSNumber numberWithInt:x]

@interface DataController : NSObject
{
    sqlite3 *databaseHandle;
}

-(NSString*)dbPath:(NSString*)name;
-(void)open;
-(void)close;
-(sqlite3_stmt *)execute:(id)args;
-(void)showSQLiteError:(NSString *)title code:(NSNumber *)aSQLiteErrorCode;

@end