//
//  TwitterSearchAppDelegate.m
//  TwitterSearch
//
//  Copyright (c) <2011> <Fahad Islam>
//

#import "TwitterSearchAppDelegate.h"

@implementation TwitterSearchAppDelegate


@synthesize window=_window;

@synthesize navigationController=_navigationController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    // Add the navigation controller's view to the window and display.
    self.window.rootViewController = self.navigationController;
    [self.window makeKeyAndVisible];
    
//    NSURL* url = [NSURL URLWithString:@"http://search.twitter.com/search.json?q=pakistan"];
//    NSError* err = nil;
//    NSString* string = [NSString stringWithContentsOfURL:url 
//                                                encoding:NSUTF8StringEncoding 
//                                                   error:&err];
//    
//    id var = [[JSONDecoder decoder] objectWithUTF8String:[string UTF8String] length:string.length];
//    //NSLog(@"var: %@", var);
//    NSArray* results = [var objectForKey:@"results"];
//    //NSLog(@"The Results: %@", results);
//    //NSLog(@"The Results count: %d", [results count]);
//    
//    NSString* post;
//    NSString* user;    
//    for (int i=0;i<[results count];i++)
//    {
//        post = [[results objectAtIndex:i] objectForKey:@"text"];
//        user = [[results objectAtIndex:i] objectForKey:@"from_user"];
//        NSLog(@"%@: %@", user, post);
//    }
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

- (void)dealloc
{
    [_window release];
    [_navigationController release];
    [super dealloc];
}

@end
