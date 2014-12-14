//
//  TweetCell.m
//  TwitterSearch
//
//  Copyright (c) <2011> <Fahad Islam>
//

#import "TweetCell.h"

@implementation TweetCell
@synthesize nameLabel, postLabel, timeLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) 
    {
        // Initialization code
        //creating the cell
        //cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier] autorelease];
        
        //creating the label for the post text
        self.postLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, (self.frame.size.width-10), 80.0f)];
        postLabel.font = [UIFont systemFontOfSize:14.0f];
        postLabel.numberOfLines = 0;
        [self.contentView addSubview:postLabel];
        
        //creating the label for the user name
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 80.0f, self.frame.size.width/2, 20.0f)];
        nameLabel.font = [UIFont boldSystemFontOfSize:13.0f];
        [self.contentView addSubview:nameLabel];
        
        //creating the label for the time the post was submitted
        self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake((self.frame.size.width/2-45), 80.0f, (self.frame.size.width/2)+45, 20.0f)];
        timeLabel.font = [UIFont boldSystemFontOfSize:13.0f];
        [self.contentView addSubview:timeLabel];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc
{
    [super dealloc];
    [nameLabel release];
    [postLabel release];
    [timeLabel release];
}

@end
