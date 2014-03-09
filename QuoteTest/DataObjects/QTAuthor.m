//
//  QTAuthor.m
//  QuoteTest
//
//  Created by Nemes Norbert on 3/7/14.
//  Copyright (c) 2014 Norbert Nemes. All rights reserved.
//

#import "QTAuthor.h"

@implementation QTAuthor
@synthesize authorId;
@synthesize name;

- (void)dealloc
{
    [name release];
    [super dealloc];
}

@end
