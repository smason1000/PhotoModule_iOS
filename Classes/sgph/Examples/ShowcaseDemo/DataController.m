//
//  DataController.m
//  PhotoHub
//
//  Created by Scott Mason on 11/27/12.
//  Copyright (c) 2012 Apex-net srl. All rights reserved.
//

#import "DataController.h"

#define CODELOCATION	[NSString stringWithFormat:@" in %s (%@:%d)",__FUNCTION__,[[NSString stringWithFormat:@"%s",__FILE__] lastPathComponent],__LINE__]
#define NUMINT(x)       [NSNumber numberWithInt:x]

@implementation DataController

#pragma mark Internal

-(NSString*)dbDir
{
    // See this apple tech note for why this changed: https://developer.apple.com/library/ios/#qa/qa1719/_index.html
    // Apparently following these guidelines is now required for app submission
    
	NSString *rootDir = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
	NSString *dbPath = [rootDir stringByAppendingPathComponent:@"Private Documents"];
	NSFileManager *fm = [NSFileManager defaultManager];
	
	BOOL isDirectory;
	BOOL exists = [fm fileExistsAtPath:dbPath isDirectory:&isDirectory];

    if (exists)
        return dbPath;
    else
        return nil;
}

-(NSString*)dbPath:(NSString*)name
{
	NSString *dbDir = [self dbDir];
    if (dbDir != nil)
        return [[dbDir stringByAppendingPathComponent:name] stringByAppendingPathExtension:@"sql"];
    else
        return nil;
}

-(sqlite3 *)open:(NSString*)name_
{
    databaseHandle = nil;
    
	NSString *databasePath = [self dbPath:name_];
	if (databasePath != nil)
    {
        // Check to see if the database file already exists
        bool databaseAlreadyExists = [[NSFileManager defaultManager] fileExistsAtPath:databasePath];
        if (databaseAlreadyExists)
        {
            // Open the database and store the handle as a data member
            if (sqlite3_open([databasePath UTF8String], &databaseHandle) == SQLITE_OK)
            {
                // database was opened
            }
            else
            {
                databaseHandle = nil;
            }
        }
    }
    return databaseHandle;
}

-(id)execute:(id)args
{
    if ([args isKindOfClass:[NSArray class]])
    {
        NSString *sql = [[args objectAtIndex:0] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
	
        NSError *error = nil;
        // prepare the statement
        //PLSqlitePreparedStatement * statement = (PLSqlitePreparedStatement *) [database prepareStatement:sql error:&error];
        if (error!=nil)
        {
            //[self throwException:@"invalid SQL statement" subreason:[error description] location:CODELOCATION];
        }
	
        if([args count] > 1)
        {
            NSArray *params = [args objectAtIndex:1];
        
            if(![params isKindOfClass:[NSArray class]])
            {
                params = [args subarrayWithRange:NSMakeRange(1, [args count]-1)];
            }
            // bind parameters
            //[statement bindParameters:params];
        }
	
        // get the result set
        //PLSqliteResultSet *result = (PLSqliteResultSet*) [statement executeQuery];
	
        //if ([[result fieldNames] count]==0)
        //{
        //    [result next]; // we need to do this to make sure lastInsertRowId and rowsAffected work
        //    [result close];
        //    return [NSNull null];
        //}
    }
}

-(void)close
{
    int err;
        
    if (databaseHandle == nil)
        return;
        
    /* Close the connection and release any sqlite resources (if open was ever called) */
    err = sqlite3_close(databaseHandle);
        
    if (err != SQLITE_OK)
        NSLog(@"[WARN] Unexpected error closing SQLite database at '%@': %s", self,sqlite3_errmsg(databaseHandle));
        
    /* Reset the variable. If any of the above failed, it is programmer error. */
    databaseHandle = nil;
}

-(NSNumber*)lastInsertRowId
{
	if (databaseHandle != nil)
	{
		return NUMINT(sqlite3_last_insert_rowid(databaseHandle));
	}
	return NUMINT(0);
}

-(NSNumber*)rowsAffected
{
	if (databaseHandle != nil)
	{
		return NUMINT(sqlite3_changes(databaseHandle));
	}
	return NUMINT(0);
}

@end