//
//  QTQuoteCell.m
//  QuoteTest
//
//  Created by Nemes Norbert on 3/8/14.
//  Copyright (c) 2014 Norbert Nemes. All rights reserved.
//

#import "QTQuoteCell.h"

@implementation QTQuoteCell
@synthesize quote;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        quoteLabel = [[UILabel alloc] init];
        quoteLabel.backgroundColor = [UIColor clearColor];
        quoteLabel.textAlignment = NSTextAlignmentLeft;
        quoteLabel.textColor = [UIColor blackColor];
        quoteLabel.font = [UIFont systemFontOfSize:14.0f];
        quoteLabel.numberOfLines = 0;
        quoteLabel.lineBreakMode = NSLineBreakByWordWrapping;
        quoteLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [self.contentView addSubview:quoteLabel];
        
        authorLabel = [[UILabel alloc] init];
        authorLabel.backgroundColor = [UIColor clearColor];
        authorLabel.textColor = [UIColor grayColor];
        authorLabel.font = [UIFont systemFontOfSize:12.0f];
        authorLabel.textAlignment = NSTextAlignmentRight;
        authorLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [self.contentView addSubview:authorLabel];
        
    }
    return self;
}

- (void)dealloc
{
    [quoteLabel release];
    [authorLabel release];
    [quote release];
    [super dealloc];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)layoutSubviews
{
    [super layoutSubviews];
}

-(void)setQuote:(QTQuote *)_quote
{
    [_quote retain];
    [quote release];
    
    quote = _quote;
    
    quoteLabel.frame = CGRectMake(10.0f, 10.0f, CGRectGetWidth(self.contentView.frame) - 20.0f, [QTQuoteCell heightForQuote:self.quote] - 40.0f);
    authorLabel.frame = CGRectMake(10.0f, CGRectGetMaxY(quoteLabel.frame) + 10, CGRectGetWidth(self.contentView.frame) - 20.0f, 20.0f);
    authorLabel.text = self.quote.author.name;
    quoteLabel.text = self.quote.quoteText;
    
}

+(CGFloat)heightForQuote: (QTQuote*) quote
{
    CGSize cellSize = [quote.quoteText sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(kScreenWidth - 20.0f, 140.0f) lineBreakMode:NSLineBreakByWordWrapping];
    
    return cellSize.height + 40.0f;
}

@end
