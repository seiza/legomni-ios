//
//  UpdateViewController.m
//  Legomni
//
//  Created by Jacques COUVREUR on 03.06.12.
//  Copyright (c) 2012 me.couvreur. All rights reserved.
//

#import "UpdateViewController.h"

@interface UpdateViewController ()

@end

@implementation UpdateViewController
@synthesize userTextField;
@synthesize serverTextField;
@synthesize receptionTextView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Update", @"Update");
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [self setUserTextField:nil];
    [self setServerTextField:nil];
    [self setReceptionTextView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)updateClicked:(id)sender {
    NSString* userID = userTextField.text;
    NSString* server = serverTextField.text;
    NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/users/%@/user_figures.json", server, userID]];
    NSData* data = [NSData dataWithContentsOfURL:url];
    NSError* error;
    NSArray* json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions  error:&error];
    NSLog(@"json: %@", [[json objectAtIndex:0] class]);

    NSString* result = @"";
    for (NSDictionary* figure in json) {
        for (NSString* key in [figure allKeys]) {
            result = [NSString stringWithFormat:@"%@\n%@ = %@", result, key, [figure objectForKey:key]];
        }
    }
    receptionTextView.text = result;
}

@end
