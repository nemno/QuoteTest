//
//  QTQutoteListViewController.h
//  QuoteTest
//
//  Created by Nemes Norbert on 3/7/14.
//  Copyright (c) 2014 Norbert Nemes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QTQuoteListTableDelegate.h"

@interface QTQutoteListViewController : UIViewController
{
    QTQuoteListTableDelegate *tableDelegate;
}

@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) UISearchBar *searchBar;

@end
