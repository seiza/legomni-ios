//
//  UpdateViewController.m
//  Legomni
//
//  Created by Jacques COUVREUR on 03.06.12.
//  Copyright (c) 2012 me.couvreur. All rights reserved.
//

#import "UpdateViewController.h"
#import "Serie.h"
#import "Figure.h"

@interface UpdateViewController ()
@end


@implementation UpdateViewController

@synthesize legomni;
@synthesize userTextField;
@synthesize serverTextField;
@synthesize receptionTextView;




- (void)createOnServer:(NSString*)server {

    NSArray* figures = [legomni figuresToPush];

    if (figures.count  > 0) {
        Figure* figure = figures.lastObject;

        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/user_figures/", server]];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
        [request setHTTPMethod:@"POST"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request setValue:@"json" forHTTPHeaderField:@"Data-Type"];
        
        NSLog(@">>>>> isValid = %d", [NSJSONSerialization isValidJSONObject:figure.toJSON]);
        
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:figure.toJSON options:kNilOptions error:nil];
        [request setValue:[NSString stringWithFormat:@"%d", [jsonData length]] forHTTPHeaderField:@"Content-Length"];
        [request setHTTPBody: jsonData];
        
        NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse: nil error: nil ];
        NSString *returnString = [[NSString alloc] initWithData:returnData encoding: NSUTF8StringEncoding];
        NSLog(@"returnData: %@", returnString);
    }
    
}




- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
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
    if (server.length == 0) server = @"http://localhost:3000";
//    NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/users/%@/user_figures.json", server, userID]];
//    NSData* data = [NSData dataWithContentsOfURL:url];
//    NSError* error;
//    NSArray* json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions  error:&error];
//    NSLog(@"json: %@", [[json objectAtIndex:0] class]);
//
//    NSString* result = @"";
//    for (NSDictionary* figure in json) {
//        for (NSString* key in [figure allKeys]) {
//            result = [NSString stringWithFormat:@"%@\n%@ = %@", result, key, [figure objectForKey:key]];
//        }
//    }
//    receptionTextView.text = result;
    
    [self createOnServer:server];
}


#pragma mark
#pragma mark UITextFieldDelegate Protocol Methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

@end
