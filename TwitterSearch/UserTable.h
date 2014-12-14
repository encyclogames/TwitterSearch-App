//
//  UserTable.h
//  TwitterSearch
//
//  Copyright (c) <2011> <Fahad Islam>
//

#import <UIKit/UIKit.h>
#import "JSONKit.h"


@interface UserTable : UITableViewController 
{
    
}
@property (retain) NSMutableArray* results;
@property (retain) NSString* nextPage;
@property (retain) NSString* query;
@property (retain, nonatomic) UIView* header;
@property (retain, nonatomic) UIImage* userImage;
@property (retain, nonatomic) UILabel* screenName;
@property (retain, nonatomic) UILabel* numberOfTweets;
@property (retain, nonatomic) UILabel* location;
@property (retain, nonatomic) UILabel* realName;

-(void) fillHeader;


@end
