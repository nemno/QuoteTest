//
//  QTQuote.m
//  QuoteTest
//
//  Created by Nemes Norbert on 3/7/14.
//  Copyright (c) 2014 Norbert Nemes. All rights reserved.
//

#import "QTQuote.h"

@implementation QTQuote
@synthesize quoteId;
@synthesize quoteText;
@synthesize author;

- (void)dealloc
{
    [quoteText release];
    [author release];
    [super dealloc];
}

@end
