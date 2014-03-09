//
//  QTQuoteListTableDelegate.h
//  QuoteTest
//
//  Created by Nemes Norbert on 3/7/14.
//  Copyright (c) 2014 Norbert Nemes. All rights reserved.
//

#import <Foundation/Foundation.h>

@class QTQutoteListViewController;

@interface QTQuoteListTableDelegate : NSObject <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@property (nonatomic, retain) NSArray *quotes;
@property (nonatomic, assign) QTQutoteListViewController *listViewController;

@end
