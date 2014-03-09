//
//  QTQuoteListTableDelegate.m
//  QuoteTest
//
//  Created by Nemes Norbert on 3/7/14.
//  Copyright (c) 2014 Norbert Nemes. All rights reserved.
//

#import "QTQuoteListTableDelegate.h"
#import "QTQutoteListViewController.h"
#import "QTQuoteDetailViewController.h"
#import "QTQuoteCell.h"

@implementation QTQuoteListTableDelegate
@synthesize quotes;
@synthesize listViewController;

- (void)dealloc
{
    [quotes release];
    [super dealloc];
}

-(CGFloat)tableView:(UITableView *)_tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [QTQuoteCell heightForQuote: [self.quotes objectAtIndex:indexPath.row]];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)_tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)_tableView numberOfRowsInSection:(NSInteger)section
{
    return self.quotes.count;
}

-(UITableViewCell *)tableView:(UITableView *)_tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QTQuoteCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"quoteCell"];
    
    if (!cell) {
        cell = [[[QTQuoteCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"quoteCell"] autorelease];
    }
    
    //Set quote for cell
//    cell.textLabel.text = ((QTQuote*)[quotes objectAtIndex:indexPath.row]).quoteText;
    cell.quote = [self.quotes objectAtIndex:indexPath.row];
    
    return cell;
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        [kDataHandler removeQuoteFromDataBase:[self.quotes objectAtIndex:indexPath.row]];
        self.quotes = [kDataHandler getQuotesForSearchText:listViewController.searchBar.text];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    QTQuoteDetailViewController *detailViewController = [[[QTQuoteDetailViewController alloc] init] autorelease];
    detailViewController.quote = [self.quotes objectAtIndex: indexPath.row];
    
    [self.listViewController.navigationController pushViewController:detailViewController animated:YES];
}

#pragma mark - UISearchBarDelegate methods

-(void)searchBarCancelButtonClicked:(UISearchBar *)_searchBar
{
    [_searchBar resignFirstResponder];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)_searchBar
{
    [_searchBar resignFirstResponder];
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    self.quotes = [kDataHandler getQuotesForSearchText:searchText];
    [self.listViewController.tableView reloadData];
    
}

@end
