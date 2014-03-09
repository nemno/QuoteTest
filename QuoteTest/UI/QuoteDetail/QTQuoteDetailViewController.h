//
//  QTQuoteDetailViewController.h
//  QuoteTest
//
//  Created by Nemes Norbert on 3/8/14.
//  Copyright (c) 2014 Norbert Nemes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QTQuoteDetailViewController : UIViewController
{
    UILabel *authorLabel;
    UITextView *quoteTextView;
}

@property (nonatomic, retain) QTQuote *quote;

@end
