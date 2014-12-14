//
//  RootViewController.m
//  TwitterSearch
//
//  Copyright (c) <2011> <Fahad Islam>
//

#import "RootViewController.h"
#import "TwitterSearchAppDelegate.h"
#import "TweetCell.h"
#import "UserTable.h"
#define kUniqueTag 19420
#define kSearchPrefix @"http://search.twitter.com/search.json?q="

@implementation RootViewController
@synthesize results, loadCell, nextPage, loading, query, searchResults;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Build single load-more cell
    self.loadCell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil] autorelease];
    loadCell.textLabel.text = @"Search for twitter posts in";
    loadCell.detailTextLabel.text = [NSString stringWithFormat:@"the search bar above"];
    self.searchResults = [NSMutableArray new];
    query = @"science";
    [NSThread detachNewThreadSelector:@selector(loadPosts) toTarget:self withObject:nil];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.loading = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    loading.frame = CGRectMake(self.tableView.frame.size.width/2 - 22.0f, 
                               self.tableView.frame.size.height/2 - 22.0f + 44.0f, 
                               22.0f, 22.0f);
    
    [self.tableView.window addSubview:loading];
    
    loadCell.accessoryView = loading;
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations.
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

#pragma mark - table definition methods

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (tableView == self.tableView) 
    {
        // old logic for main tableview
        return [results count]+1; //to fit the load 15 more tweets cell
    }
    else 
    {
        // new logic for temp search table
        return 1;
    }
    
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    if (tableView == self.tableView)
    {
        if (indexPath.row == [results count])
        {
            return loadCell;
        }
        else
        {
            TweetCell *cell = (TweetCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
            if (cell == nil) 
            {
                //creating the cell
                cell = [[[TweetCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
            }
            // Configure the cell.    
            NSString* post = [[results objectAtIndex:indexPath.row] objectForKey:@"text"];
            NSString* user = [[results objectAtIndex:indexPath.row] objectForKey:@"from_user"];
            NSString* date = [[results objectAtIndex:indexPath.row] objectForKey:@"created_at"];
            date = [date substringToIndex:([date length] - 6)]; //removing the +0000 part at end
            //NSLog(@"%@: %@", user, post);
            
            //cell.textLabel.text = user;
            cell.nameLabel.text = user;
            cell.postLabel.text = post;
            cell.timeLabel.text = date;
            
            return cell;
        }
    }
    else
    {
        UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil) 
        {
            //creating the cell
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        }
        
        cell.textLabel.text = [[searchResults objectAtIndex:indexPath.row] objectForKey:@"text"];
        
        return cell;
    }
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == [results count])
    {
        return 60.0f;
    }
    else
    {
        return 100.0f;
    }
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
 if (editingStyle == UITableViewCellEditingStyleDelete)
 {
 // Delete the row from the data source.
 [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert)
 {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == [results count])
    {
        //do the reload thingy but from next page
        loadCell.textLabel.text = @"Loading Tweets ...";
        [loading startAnimating];
        
        [NSThread detachNewThreadSelector:@selector(loadMore) toTarget:self withObject:nil];
    }
    else
    {
        UserTable *detailViewController = [[UserTable alloc] initWithNibName:@"UserTable" bundle:nil];

        
        // Pass the selected object to the new view controller.
        [self.navigationController pushViewController:detailViewController animated:YES];
        [detailViewController release];
        
    }
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}

- (void)dealloc
{
    [super dealloc];
    [results release];
    [loadCell release];
    [nextPage release];
    [loading release];
    [query release];
}

#pragma mark - Posts search and loading methods

-(void) loadPosts
{
    NSLog(@"loading!");
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    NSString* urlString = [kSearchPrefix stringByAppendingString:query];
    
    NSURL* url = [NSURL URLWithString:urlString];
    NSError* err = nil;
    NSString* string = [NSString stringWithContentsOfURL:url 
                                                encoding:NSUTF8StringEncoding 
                                                   error:&err];
    
    id var = [[JSONDecoder decoder] objectWithUTF8String:(const unsigned char*)[string UTF8String] length:string.length];
    //NSLog(@"var: %@", var);
    self.results = [[var objectForKey:@"results"] mutableCopy];
    self.nextPage = [var objectForKey:@"next_page"];
    //NSLog(@"The Results: %@", results);
    //NSLog(@"The Results count: %d", [results count]);
    
    [self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:self waitUntilDone:NO];
    
    loadCell.textLabel.text = @"Load 15 More tweets...";
    loadCell.detailTextLabel.text = [NSString stringWithFormat:@"%d tweets loaded",[results count]];
    
    [loading stopAnimating];
    
    [pool drain];
}

-(void) loadMore
{
    [loading startAnimating];
    
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    NSString* nextPageSearch = @"http://search.twitter.com/search.json";
    NSURL* url = [NSURL URLWithString:[nextPageSearch stringByAppendingString:nextPage]];
    NSError* err = nil;
    NSString* string = [NSString stringWithContentsOfURL:url 
                                                encoding:NSUTF8StringEncoding 
                                                   error:&err];
    
    id var = [[JSONDecoder decoder] objectWithUTF8String:(const unsigned char*)[string UTF8String] 
                                                  length:string.length];
    //NSLog(@"var: %@", var);
    NSArray* nextResults = [var objectForKey:@"results"];
    [results addObjectsFromArray:nextResults];
    self.nextPage = [var objectForKey:@"next_page"];
    //NSLog(@"The Results: %@", results);
    //NSLog(@"The Results count: %d", [results count]);
    
    [self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:self waitUntilDone:NO];
    
    
    loadCell.textLabel.text = @"Load 15 More tweets...";
    loadCell.detailTextLabel.text = [NSString stringWithFormat:@"%d tweets loaded",[results count]];
    [loading stopAnimating];
    
    [pool drain];
}

-(void) searchPosts
{
    NSString* postText;
    NSLog(@"searching");

    [searchResults removeAllObjects];
    
    for (int i=0;i<[results count];i++)
    {
        postText = [[results objectAtIndex:i] objectForKey:@"text"];
        NSRange range =  [postText rangeOfString:query];
        if (range.location != NSNotFound)
        {
            [searchResults addObject:[results objectAtIndex:i]];
        }
    }
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText 
{
    self.query = searchText;
    NSLog(@"search text is : %@", query);
    
    [self searchPosts];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar 
{
    self.query = searchBar.text;
    NSLog(@"search text is : %@", query);
        
    [self searchPosts];
    
}

@end
