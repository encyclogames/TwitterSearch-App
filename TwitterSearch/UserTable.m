//
//  UserTable.m
//  TwitterSearch
//
//  Copyright (c) <2011> <Fahad Islam>
//

#import "UserTable.h"
#import "TweetCell.h"
#define kUserSearchPrefix @"http://twitter.com/status/user_timeline/"

@implementation UserTable
@synthesize results, nextPage, query, header, userImage, screenName, location, realName, numberOfTweets;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
    [header release];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 90)];
    header.backgroundColor = [UIColor grayColor];
    self.tableView.tableHeaderView = header;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    query = @"yfrancis";
    [NSThread detachNewThreadSelector:@selector(loadUserPosts) toTarget:self withObject:nil];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [results count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    TweetCell *cell = (TweetCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) 
    {
        cell = [[[TweetCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell.    
    NSString* post = [[results objectAtIndex:indexPath.row] objectForKey:@"text"];
    //NSString* user = [[results objectAtIndex:indexPath.row] objectForKey:@"from_user"];
    NSString* date = [[results objectAtIndex:indexPath.row] objectForKey:@"created_at"];
    //date = [date substringToIndex:([date length] - 6)]; //removing the +0000 part at end
    
    //NSLog(@"%@: %@", user, post);
    //cell.textLabel.text = user;
    cell.nameLabel.text = query;
    cell.postLabel.text = post;
    cell.timeLabel.text = date;
    
    
    
    return cell;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100.0f;
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }   
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }   
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}

-(void) loadUserPosts
{
    NSLog(@"loading! user posts");
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    NSString* urlString = [kUserSearchPrefix stringByAppendingFormat:@"%@.json",query];
    NSLog(@"%@",urlString);
    
    NSURL* url = [NSURL URLWithString:urlString];
    NSError* err = nil;
    NSString* string = [NSString stringWithContentsOfURL:url 
                                                encoding:NSUTF8StringEncoding 
                                                   error:&err];
    
    //NSLog(@"string='%@'", string);
    
    id var = [[JSONDecoder decoder] objectWithUTF8String:(const unsigned char*)[string UTF8String] length:string.length];
    //NSLog(@"var: %@", var);
    self.results = [var mutableCopy];
    
    NSDictionary* userDetail = [[var objectAtIndex:0] objectForKey:@"user"];
    NSLog(@"%@",userDetail);
    NSData* data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[userDetail objectForKey:@"profile_image_url"]]];
    self.userImage =  [UIImage imageWithData:data];

    [self fillHeader];
    self.location.text = [userDetail objectForKey:@"location"];
    self.realName.text = [userDetail objectForKey:@"name"];
    self.screenName.text = [userDetail objectForKey:@"screen_name"];
    self.numberOfTweets.text = [[userDetail objectForKey:@"statuses_count"] stringValue];
    
    //NSLog(@"The Results: %@", results);
    //NSLog(@"The Results count: %d", [results count]);
    NSLog(@"loc : %@, rn: %@, sn: %@, number: %@",[userDetail objectForKey:@"location"], realName.text, screenName.text, numberOfTweets.text);

    NSLog(@"loc : %@, rn: %@, sn: %@, number: %@",location.text, realName.text, screenName.text, numberOfTweets.text);
    
    [self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:self waitUntilDone:NO];
    
    //    loadCell.textLabel.text = @"Load 15 More tweets...";
    //    loadCell.detailTextLabel.text = [NSString stringWithFormat:@"%d tweets loaded",[results count]];
    //    
    //    [loading stopAnimating];
    
    [pool drain];
}

-(void) fillHeader
{
    UIImageView* imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 48, 48)];
    //NSLog(@"IMAGE: %@", userImage);
    imgView.image = userImage;

    self.realName = [[UILabel alloc] initWithFrame:CGRectMake(70, 10, 250, 15)];
    self.screenName = [[UILabel alloc] initWithFrame:CGRectMake(70, 30, 150, 15)];
    self.location = [[UILabel alloc] initWithFrame:CGRectMake(70, 50, 200, 15)];
    self.numberOfTweets  = [[UILabel alloc ] initWithFrame:CGRectMake(70, 70, 100, 15)];
    
    [header addSubview:imgView];
    [header addSubview:screenName];
    [header addSubview:realName];
    [header addSubview:location];
    [header addSubview:numberOfTweets];

}





@end
