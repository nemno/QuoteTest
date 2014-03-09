//
//  QTQutoteListViewController.m
//  QuoteTest
//
//  Created by Nemes Norbert on 3/7/14.
//  Copyright (c) 2014 Norbert Nemes. All rights reserved.
//

#import "QTQutoteListViewController.h"
#import "QTAddQuoteViewController.h"

@interface QTQutoteListViewController ()

@end

@implementation QTQutoteListViewController
@synthesize tableView;
@synthesize searchBar;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.title = @"Quotes";
        
        if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        
        self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(editButtonTouched)] autorelease];
        self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Add" style:UIBarButtonItemStylePlain target:self action:@selector(addButtonTouched)] autorelease];

    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [tableView release];
    [tableDelegate release];
    [searchBar release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    tableDelegate = [[QTQuoteListTableDelegate alloc] init];
    tableDelegate.quotes = [kDataHandler getAllQuotes];
    tableDelegate.listViewController = self;
    
    self.searchBar = [[[UISearchBar alloc] initWithFrame:CGRectMake(0.0f, kFloor, kScreenWidth, 44.0f)] autorelease];
    self.searchBar.showsCancelButton = YES;
    self.searchBar.delegate = tableDelegate;
    self.searchBar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:self.searchBar];
    
    self.tableView = [[[UITableView alloc] initWithFrame:CGRectMake(0.0f, CGRectGetMaxY(self.searchBar.frame), kScreenWidth, kScreenHeight - CGRectGetMaxY(self.searchBar.frame) - kStatusBarHeight) style:UITableViewStylePlain] autorelease];
    self.tableView.dataSource = tableDelegate;
    self.tableView.delegate = tableDelegate;
    self.tableView.tableFooterView = [[UIView new] autorelease];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

    [self.view addSubview:self.tableView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshData) name:kQouteAddedNotification object:nil];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)editButtonTouched
{
    [self.tableView setEditing:!self.tableView.editing animated:YES];
}

-(void)addButtonTouched
{
    
    QTAddQuoteViewController *addViewController = [[[QTAddQuoteViewController alloc] init] autorelease];
    UINavigationController *addNavigationController = [[[UINavigationController alloc] initWithRootViewController:addViewController] autorelease];
    
    [self.navigationController presentViewController:addNavigationController animated:YES completion:nil];
    
}

-(void)refreshData
{
    tableDelegate.quotes = [kDataHandler getAllQuotes];
    [self.tableView reloadData];
}


@end
