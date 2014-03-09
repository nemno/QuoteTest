//
//  QTQuote.h
//  QuoteTest
//
//  Created by Nemes Norbert on 3/7/14.
//  Copyright (c) 2014 Norbert Nemes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QTAuthor.h"

@interface QTQuote : NSObject
@property (nonatomic) NSInteger quoteId;
@property (nonatomic, retain) NSString *quoteText;
@property (nonatomic, retain) QTAuthor *author;

@end
