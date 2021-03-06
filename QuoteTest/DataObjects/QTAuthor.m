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

- (NSArray *)keyPaths
{
    NSArray *result = [NSArray arrayWithObjects:
                       @"authorId",
                       @"name",
                       nil];
    
    return result;
}

- (NSString *)descriptionForKeyPaths
{
    NSMutableString *desc = [NSMutableString string];
    [desc appendString:@"\n\n"];
    [desc appendFormat:@"Class name: %@\n", NSStringFromClass([self class])];
    
    NSArray *keyPathsArray = [self keyPaths];
    for (NSString *keyPath in keyPathsArray) {
        [desc appendFormat: @"%@: %@\n", keyPath, [self valueForKey:keyPath]];
    }
    
    return [NSString stringWithString:desc];
}

-(NSString *)description
{
    return [self descriptionForKeyPaths];
}

@end
