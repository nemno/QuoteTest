//
//  QTDataHandler.h
//  QuoteTest
//
//  Created by Nemes Norbert on 3/7/14.
//  Copyright (c) 2014 Norbert Nemes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "QTAuthor.h"
#import "QTQuote.h"

@interface QTDataHandler : NSObject

@property (nonatomic, retain) FMDatabase *dataBase;

+(QTDataHandler*)getInstance;
-(NSArray*)getAllQuotes;
-(NSArray*)getQuotesForSearchText: (NSString*) text;
-(void)addQuoteToDataBase: (QTQuote*) quote;
-(void)removeQuoteFromDataBase: (QTQuote*) quote;

@end
