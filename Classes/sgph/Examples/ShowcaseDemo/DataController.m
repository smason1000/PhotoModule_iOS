//
//  DataController.m
//  PhotoHub
//
//  Created by Scott Mason on 11/27/12.
//  Copyright (c) 2012 Apex-net srl. All rights reserved.
//

#import "DataController.h"

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

-(void)open
{
    if (databaseHandle != nil)
    {
        NSLog(@"Database was left open - closing before opening again");
        [self close];
    }
    
	NSString *databasePath = [gSingleton dbPath];
	if (databasePath != nil)
    {
        // Check to see if the database file already exists
        bool databaseAlreadyExists = [[NSFileManager defaultManager] fileExistsAtPath:databasePath];
        if (databaseAlreadyExists)
        {
            // Open the database and store the handle as a data member
            int code = sqlite3_open([databasePath UTF8String], &databaseHandle);
            if (code != SQLITE_OK)
            {
                [self showSQLiteError:@"Database Open" code:NUMINT(code)];
                databaseHandle = nil;
            }
        }
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
    {
        [self showSQLiteError:@"Database Close" code:NUMINT(err)];
        NSLog(@"[WARN] Unexpected error closing SQLite database at '%@': %s", self, sqlite3_errmsg(databaseHandle));
    }
    
    /* Reset the variable. If any of the above failed, it is programmer error. */
    databaseHandle = nil;
}

-(void)showSQLiteError:(NSString *)title code:(NSNumber *)aSQLiteErrorCode
{
    NSString *sqliteErrorMessage;

    switch ([aSQLiteErrorCode intValue])
    {
        case SQLITE_OK:
            return;
            
        case SQLITE_ERROR:
            sqliteErrorMessage = @"SQL Error or missing database";
            break;
        case SQLITE_INTERNAL:
            sqliteErrorMessage = @"Internal logic error";
            break;
        case SQLITE_PERM:
            sqliteErrorMessage = @"Access Permission denied";
            break;
        case SQLITE_ABORT:
            sqliteErrorMessage = @"Callback routine requested an abort";
            break;
        case SQLITE_BUSY:
            sqliteErrorMessage = @"The database file is locked";
            break;
        case SQLITE_LOCKED:
            sqliteErrorMessage = @"A table in the database is locked";
            break;
        case SQLITE_NOMEM:
            sqliteErrorMessage = @"Memory allocation failed";
            break;
        case SQLITE_READONLY:
            sqliteErrorMessage = @"Attempt to write a readonly database";
            break;
        case SQLITE_INTERRUPT:
            sqliteErrorMessage = @"Operation terminated by database interrupt";
            break;
        case SQLITE_IOERR:
            sqliteErrorMessage = @"An I/O error occurred";
            break;
        case SQLITE_CORRUPT:
            sqliteErrorMessage = @"The database files is corrupt";
            break;
        case SQLITE_NOTFOUND:
            sqliteErrorMessage = @"Unknown operation in database code";
            break;
        case SQLITE_FULL:
            sqliteErrorMessage = @"Insert failed because the database is full";
            break;
        case SQLITE_CANTOPEN:
            sqliteErrorMessage = @"Unable to open the database file";
            break;
        case SQLITE_PROTOCOL:
            sqliteErrorMessage = @"Database lock protocol error";
            break;
        case SQLITE_EMPTY:
            sqliteErrorMessage = @"The database is empty";
            break;
        case SQLITE_SCHEMA:
            sqliteErrorMessage = @"The database schema changed";
            break;
        case SQLITE_TOOBIG:
            sqliteErrorMessage = @"String or BLOB exceeds size limit";
            break;
        case SQLITE_CONSTRAINT:
            sqliteErrorMessage = @"Abort due to constraint violation";
            break;
        case SQLITE_MISMATCH:
            sqliteErrorMessage = @"Data type mismatch";
            break;
        case SQLITE_MISUSE:
            sqliteErrorMessage = @"Database Library being used incorrectly";
            break;
        case SQLITE_NOLFS:
            sqliteErrorMessage = @"Attempt to use unsupported OS feature";
            break;
        case SQLITE_AUTH:
            sqliteErrorMessage = @"Authorization failed";
            break;
        case SQLITE_FORMAT:
            sqliteErrorMessage = @"Database format error";
            break;
        case SQLITE_RANGE:
            sqliteErrorMessage = @"Parameter was out of range";
            break;
        case SQLITE_NOTADB:
            sqliteErrorMessage = @"File opened was not a supported database file";
            break;
        default:
            sqliteErrorMessage = [NSString stringWithFormat:@"Unknown error - code: %@", aSQLiteErrorCode];
            break;
    }    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                  message:sqliteErrorMessage
                                                  delegate:nil
                                                  cancelButtonTitle:NSLocalizedString(@"OK", @"OK button title")
                                                  otherButtonTitles:nil];
    [alertView show];
}

/**
 * @internal
 * Bind a value to a statement parameter, returning the SQLite bind result value.
 *
 * @param parameterIndex Index of parameter to be bound.
 * @param value Objective-C object to use as the value.
 */
- (int)bindValueForParameter: (int)parameterIndex withValue: (id)value forStatement:(sqlite3_stmt *)stmt
{
    /* NULL */
    if (value == nil || value == [NSNull null])
    {
        return sqlite3_bind_null(stmt, parameterIndex);
    }
    
    if ([value isKindOfClass: [NSString class]])
    {
        return sqlite3_bind_text(stmt, parameterIndex, [value UTF8String], -1, SQLITE_TRANSIENT);
    }

	/* Image handling */
	if ([value isKindOfClass:[UIImage class]])
    {
		value = UIImageJPEGRepresentation(value, 1.0);
	}
	
    /* Data */
	if ([value isKindOfClass: [NSData class]])
    {
        return sqlite3_bind_blob(stmt, parameterIndex, [value bytes], [value length], SQLITE_TRANSIENT);
    }
    
    /* Date */
    else if ([value isKindOfClass: [NSDate class]])
    {
        return sqlite3_bind_double(stmt, parameterIndex, [value timeIntervalSince1970]);
    }
    
    /* Number */
    else if ([value isKindOfClass: [NSNumber class]])
    {
        const char *objcType = [value objCType];
        int64_t number = [value longLongValue];
        
        /* Handle floats and doubles */
        if (strcmp(objcType, @encode(float)) == 0 || strcmp(objcType, @encode(double)) == 0)
        {
            return sqlite3_bind_double(stmt, parameterIndex, [value doubleValue]);
        }
        
        /* If the value can fit into a 32-bit value, use that bind type. */
        else if (number <= INT32_MAX)
        {
            return sqlite3_bind_int(stmt, parameterIndex, number);
            
            /* Otherwise use the 64-bit bind. */
        }
        else
        {
            return sqlite3_bind_int64(stmt, parameterIndex, number);
        }
    }

    /* Not a known type */
    NSString *message = [NSString stringWithFormat:@"Error binding unknown parameter type '%@'. Value: '%@'", [value class], value];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Bind Error"
                                                  message:message
                                                  delegate:nil
                                                  cancelButtonTitle:NSLocalizedString(@"OK", @"OK button title")
                                                  otherButtonTitles:nil];
    [alertView show];
    return SQLITE_ABORT;
}

-(sqlite3_stmt *)execute:(id)args
{
    if ([args isKindOfClass:[NSArray class]])
    {
        if (databaseHandle == nil)
            [self open];
        
        sqlite3_stmt *stmt;

        NSString *sql = [[args objectAtIndex:0] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
	
        NSLog(@"sqlite3 execute (%d) %@", [args count] - 1, sql);
        
        // prepare the statement
        int code = sqlite3_prepare_v2(databaseHandle, [sql UTF8String], -1, &stmt, NULL);
        if (code != SQLITE_OK)
        {
            [self close];
            [self showSQLiteError:@"Database Error (Prep)" code:NUMINT(code)];
            return nil;
        }
	
        if ([args count] > 1)
        {
            NSArray *params = [args objectAtIndex:1];
            if(![params isKindOfClass:[NSArray class]])
            {
                params = [args subarrayWithRange:NSMakeRange(1, [args count]-1)];
            }
            // bind parameters
            for (int i = 0; i < [params count]; i++)
            {
                code = [self bindValueForParameter:i+1 withValue:[params objectAtIndex:i] forStatement:stmt];
                if (code != SQLITE_OK)
                {
                    [self close];
                    [self showSQLiteError:[NSString stringWithFormat:@"Database Error (B%d)", i] code:NUMINT(code)];
                    return nil;
                }
            }
        }
	
        // return the statement ready to get the result set
        return stmt;
    }
    return nil;
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