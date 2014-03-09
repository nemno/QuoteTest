//
//  QTAddQuoteViewController.m
//  QuoteTest
//
//  Created by Nemes Norbert on 3/8/14.
//  Copyright (c) 2014 Norbert Nemes. All rights reserved.
//

#import "QTAddQuoteViewController.h"

@interface QTAddQuoteViewController ()

@end

@implementation QTAddQuoteViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Add quote";
        self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Cacnel" style:UIBarButtonItemStylePlain target:self action:@selector(cancelButtonTouched)] autorelease];
        self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Add" style:UIBarButtonItemStyleDone target:self action:@selector(addButtonTouched)] autorelease];
    }
    return self;
}

- (void)dealloc
{
    [authorNameTextField release];
    [quoteTextView release];
    [authorPlaceholderLabel release];
    [quotePlaceholderLabel release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.dfdf
    
    self.view.backgroundColor = [UIColor whiteColor];
        
    UIView *textFieldBackground = [[[UIView alloc] initWithFrame:CGRectMake(0.0f, kFloor + 20.0f, kScreenWidth, 44.0f)] autorelease];
    textFieldBackground.backgroundColor = [UIColor lightGrayColor];
    textFieldBackground.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:textFieldBackground];
    
    authorPlaceholderLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 0.0f, 100.0f, CGRectGetHeight(textFieldBackground.frame))];
    authorPlaceholderLabel.textColor = [UIColor colorWithWhite:255.0f / 255.0f alpha:0.6f];
    authorPlaceholderLabel.backgroundColor = [UIColor clearColor];
    authorPlaceholderLabel.text = @"Author";
    [textFieldBackground addSubview:authorPlaceholderLabel];
    
    authorNameTextField = [[UITextField alloc] initWithFrame: CGRectMake(10.0f, 0.0f, CGRectGetWidth(textFieldBackground.frame) - 20.0f, CGRectGetHeight(textFieldBackground.frame))];
    authorNameTextField.backgroundColor = [UIColor clearColor];
    authorNameTextField.textColor = [UIColor whiteColor];
    authorNameTextField.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    authorNameTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    authorNameTextField.delegate = self;
    [textFieldBackground addSubview:authorNameTextField];
    
    UIView *textViewBackground = [[[UIView alloc] initWithFrame:CGRectMake(0.0f, CGRectGetMaxY(textFieldBackground.frame) + 40.0f, kScreenWidth, 96.0f)] autorelease];
    textViewBackground.backgroundColor = [UIColor lightGrayColor];
    textViewBackground.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:textViewBackground];
    
    quotePlaceholderLabel = [[UILabel alloc] initWithFrame:CGRectMake(15.0f, 0.0f, 100.0f, 38.0f)];
    quotePlaceholderLabel.textColor = [UIColor colorWithWhite:255.0f / 255.0f alpha:0.6f];
    quotePlaceholderLabel.text = @"Quote";
    quotePlaceholderLabel.backgroundColor = [UIColor clearColor];
    [textViewBackground addSubview:quotePlaceholderLabel];
    
    quoteTextView = [[UITextView alloc] initWithFrame:CGRectMake(10.0f, 0.0f, CGRectGetWidth(textViewBackground.frame) - 20.0f, CGRectGetHeight(textViewBackground.frame))];
    quoteTextView.backgroundColor = [UIColor clearColor];
    quoteTextView.font = quotePlaceholderLabel.font;
    quoteTextView.textColor = [UIColor whiteColor];
    quoteTextView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    quoteTextView.delegate = self;
    [textViewBackground addSubview: quoteTextView];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)cancelButtonTouched
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)addButtonTouched
{
//    [self dismissViewControllerAnimated:YES completion:nil];
    if (![self validate]) {
        return;
    }
    
    QTQuote *tempQuote = [[[QTQuote alloc] init] autorelease];
    QTAuthor *tempAuthor = [[[QTAuthor alloc] init] autorelease];
    tempAuthor.name = authorNameTextField.text;
    tempQuote.quoteText = quoteTextView.text;
    tempQuote.author = tempAuthor;
    
    [kDataHandler addQuoteToDataBase:tempQuote];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kQouteAddedNotification object:nil];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
//    [self.tableView reloadData];
}

-(BOOL)validate
{
    if (authorNameTextField.text.length == 0) {
        [[[[UIAlertView alloc] initWithTitle:@"Empty author" message:@"Please add the name of the author!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil] autorelease] show];
        return NO;
    }
    
    if (quoteTextView.text.length == 0) {
        [[[[UIAlertView alloc] initWithTitle:@"Empty quote text" message:@"Please add the text of the quote!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil] autorelease] show];
        return NO;
    }
    
    return YES;
}

#pragma mark - UITextFieldDelegate methods

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *newText = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if (newText.length > 0) {
        authorPlaceholderLabel.alpha = 0.0f;
    } else {
        authorPlaceholderLabel.alpha = 1.0f;
    }
    
    return YES;
}

#pragma mark - UITextViewDelegate methods

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    NSString *newText = [textView.text stringByReplacingCharactersInRange:range withString:text];
    
    if (newText.length > 0) {
        quotePlaceholderLabel.alpha = 0.0f;
    } else {
        quotePlaceholderLabel.alpha = 1.0f;
    }
    
    return YES;
}

@end
