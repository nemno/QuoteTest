//
//  QTQuoteCell.h
//  QuoteTest
//
//  Created by Nemes Norbert on 3/8/14.
//  Copyright (c) 2014 Norbert Nemes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QTQuoteCell : UITableViewCell
{
    UILabel *quoteLabel;
    UILabel *authorLabel;
}

@property (nonatomic, retain) QTQuote *quote;

+(CGFloat)heightForQuote: (QTQuote*) quote;

@end
