//
//  QTQuoteDetailViewController.m
//  QuoteTest
//
//  Created by Nemes Norbert on 3/8/14.
//  Copyright (c) 2014 Norbert Nemes. All rights reserved.
//

#import "QTQuoteDetailViewController.h"

@interface QTQuoteDetailViewController ()

@end

@implementation QTQuoteDetailViewController
@synthesize quote;

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
        self.quote = nil;
    }
    return self;
}

- (void)dealloc
{
    [authorLabel release];
    [quoteTextView release];
    [quote release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    authorLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, kFloor + 20.0f, kScreenWidth, 44.0f)];
    authorLabel.textAlignment = NSTextAlignmentCenter;
    authorLabel.textColor = [UIColor blackColor];
    authorLabel.numberOfLines = 0;
    authorLabel.lineBreakMode = NSLineBreakByWordWrapping;
    authorLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:authorLabel];
    
    if (self.quote) {
        authorLabel.text = self.quote.author.name;
    }
    
    [authorLabel sizeToFit];
    authorLabel.frame = CGRectMake(0.0f, kFloor + 20.0f, kScreenWidth, CGRectGetHeight(authorLabel.frame));
    
    quoteTextView = [[UITextView alloc] initWithFrame:CGRectMake(10.0f, CGRectGetMaxY(authorLabel.frame) + 20.0f, kScreenWidth - 20.0f, kScreenHeight - CGRectGetMaxY(authorLabel.frame) - 20.0f)];
    quoteTextView.backgroundColor = [UIColor clearColor];
    quoteTextView.textColor = [UIColor grayColor];
    quoteTextView.editable = NO;
    quoteTextView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:quoteTextView];
    
    if (self.quote) {
        quoteTextView.text = self.quote.quoteText;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
