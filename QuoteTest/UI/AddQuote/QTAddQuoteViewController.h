//
//  QTAddQuoteViewController.h
//  QuoteTest
//
//  Created by Nemes Norbert on 3/8/14.
//  Copyright (c) 2014 Norbert Nemes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QTAddQuoteViewController : UIViewController<UITextFieldDelegate, UITextViewDelegate>
{
    UILabel *authorPlaceholderLabel;
    UILabel *quotePlaceholderLabel;

    UITextField *authorNameTextField;
    UITextView *quoteTextView;
    
}

@end
