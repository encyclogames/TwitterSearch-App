//
//  RootViewController.h
//  TwitterSearch
//
//  Copyright (c) <2011> <Fahad Islam>
//

#import <UIKit/UIKit.h>

@interface RootViewController : UITableViewController 
{
    
}
@property (retain) NSMutableArray* results;
@property (retain) NSMutableArray* searchResults;
@property (retain) NSString* nextPage;
@property (retain) NSString* query;
@property (retain, nonatomic) UITableViewCell* loadCell;
@property (retain,nonatomic) UIActivityIndicatorView* loading;

@end
