//
//  TweetCell.h
//  TwitterSearch
//
//  Copyright (c) <2011> <Fahad Islam>
//

#import <UIKit/UIKit.h>


@interface TweetCell : UITableViewCell 
{
    UILabel* nameLabel;
    UILabel* postLabel;
    UILabel* timeLabel;
}
@property (retain, nonatomic) UILabel* nameLabel;
@property (retain, nonatomic) UILabel* postLabel;
@property (retain, nonatomic) UILabel* timeLabel;

@end
