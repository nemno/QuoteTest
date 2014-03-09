//
//  QTDataHandler.m
//  QuoteTest
//
//  Created by Nemes Norbert on 3/7/14.
//  Copyright (c) 2014 Norbert Nemes. All rights reserved.
//

#import "QTDataHandler.h"

@implementation QTDataHandler
@synthesize dataBase;

static QTDataHandler *sharedSingleton = nil;

+(QTDataHandler*)getInstance
{
    if (!sharedSingleton) {
        sharedSingleton = [[super allocWithZone:NULL] init];
    }
    
    return sharedSingleton;

}

- (id)init
{
    self = [super init];
    
    if (self) {
        
        self.dataBase = [self createDataBase];
        
    }
    return self;
}

- (void)dealloc
{
    [sharedSingleton release];
    [super dealloc];
}

- (FMDatabase *)createDataBase
{
    NSFileManager *fm = [NSFileManager defaultManager];
    NSString *documents_dir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *db_path = [documents_dir stringByAppendingPathComponent:[NSString stringWithFormat:@"quotes.sqlite"]];
    NSString *template_path = [[NSBundle mainBundle] pathForResource:@"quotes" ofType:@"sqlite"];
    
    if (![fm fileExistsAtPath:db_path])
        [fm copyItemAtPath:template_path toPath:db_path error:nil];
    FMDatabase *db = [FMDatabase databaseWithPath:db_path];

    return db;
}

#pragma mark - Queries

-(NSArray*)getAllQuotes
{
    NSMutableArray *mutableArray = [NSMutableArray array];

    if ([self.dataBase open]) {
        FMResultSet *set = [self.dataBase executeQuery:@"SELECT * FROM quote"];
        
        while ([set next]) {
            
            QTQuote *quote = [[[QTQuote alloc] init] autorelease];
            quote.quoteText = [set stringForColumn:@"quote_text"];
            quote.quoteId = [set intForColumn:@"id"];
            quote.author = [self getAuthorForID:[set intForColumn:@"author_id"]];
            [mutableArray addObject: quote];
        }
        
        [set close];
        
        [self.dataBase close];
    }
    
    return [NSArray arrayWithArray:mutableArray];
}

-(NSArray*)getQuotesForSearchText: (NSString*) text
{
    if (!text || text.length == 0) {
        return [self getAllQuotes];
    }
    
    NSMutableArray *mutableArray = [NSMutableArray array];
    
    if ([self.dataBase open]) {
        FMResultSet *set = [self.dataBase executeQuery:[NSString stringWithFormat: @"SELECT * FROM quote WHERE quote_text LIKE '%%%@%%'", text]];
        
        while ([set next]) {
            QTQuote *quote = [[[QTQuote alloc] init] autorelease];
            quote.quoteText = [set stringForColumn:@"quote_text"];
            quote.author = [self getAuthorForID:[set intForColumn:@"author_id"]];
            [mutableArray addObject: quote];
        }
        
        [set close];

        [self.dataBase close];
    }
    
    return [NSArray arrayWithArray:mutableArray];
}

-(QTAuthor*)getAuthorForID: (NSInteger) authorId
{
    QTAuthor *author = nil;

    FMResultSet *set = [self.dataBase executeQuery:[NSString stringWithFormat: @"SELECT * FROM author WHERE id = %d", authorId]];
    
    if ([set next]) {
        author = [[[QTAuthor alloc] init] autorelease];
        author.authorId = [set intForColumn:@"id"];
        author.name = [set stringForColumn:@"name"];
    }

    [set close];
    
    return author;
}

-(NSInteger)getAuthorIDForName: (NSString*) authorName
{
    
    FMResultSet *set = [self.dataBase executeQuery:[NSString stringWithFormat: @"SELECT id FROM author WHERE name LIKE '%@'", authorName]];
    
    if ([set next]) {
        
        NSInteger rowID = [set intForColumn:@"id"];
        [set close];
        return rowID;
    }
    
    return 0;
}

#pragma mark - Modifications

-(void)addQuoteToDataBase: (QTQuote*) quote
{
    if ([self.dataBase open]) {
        
        NSInteger recentAuthorId = [self getAuthorIDForName:quote.author.name];
        
        if (recentAuthorId == 0) {
            [self.dataBase beginTransaction];
            [self.dataBase executeUpdate: [NSString stringWithFormat:@"INSERT INTO author (name) VALUES ('%@')", quote.author.name]];
            [self.dataBase commit];

            [self.dataBase beginTransaction];
            recentAuthorId = [self getAuthorIDForName:quote.author.name];
            [self.dataBase executeUpdate: [NSString stringWithFormat:@"INSERT INTO quote (quote_text,author_id) VALUES ('%@', %d)", quote.quoteText, recentAuthorId]];

            [self.dataBase commit];
            
        } else {
            
            [self.dataBase beginTransaction];
            [self.dataBase executeUpdate: [NSString stringWithFormat:@"INSERT INTO quote (quote_text,author_id) VALUES ('%@', %d)", quote.quoteText, recentAuthorId]];
            [self.dataBase commit];
        }
        
        [self.dataBase close];

    }
}

-(void)addAuthorToDataBase: (QTAuthor*) author
{
    if ([self.dataBase open]) {
        
        if ([self getAuthorIDForName:author.name] == 0) {
            [self.dataBase beginTransaction];
            [self.dataBase executeUpdate: [NSString stringWithFormat:@"INSERT INTO author (name) VALUES ('%@')", author.name]];
            [self.dataBase commit];
        }
        
        [self.dataBase close];
        
    }
}

-(void)removeQuoteFromDataBase: (QTQuote*) quote
{
    if ([self.dataBase open]) {
        
            [self.dataBase beginTransaction];
            [self.dataBase executeUpdate: [NSString stringWithFormat:@"DELETE FROM quote WHERE id = %d", quote.quoteId]];
            [self.dataBase commit];
        
        if ([self numberOfQuotesForAuthor: quote.author] == 0) {
            [self.dataBase beginTransaction];
            [self.dataBase executeUpdate: [NSString stringWithFormat:@"DELETE FROM author WHERE id = %d", quote.author.authorId]];
            [self.dataBase commit];

        }
        
        [self.dataBase close];
        
    }
}

-(NSInteger)numberOfQuotesForAuthor: (QTAuthor*) author
{
    FMResultSet *set = [self.dataBase executeQuery:[NSString stringWithFormat: @"SELECT * FROM quote WHERE author_id = %d", author.authorId]];
    
    if ([set next]) {
        
        [set close];
        return 1;
    }
    
    return 0;
}

@end
