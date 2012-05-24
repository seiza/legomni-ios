//
//  DetailViewController.m
//  Legomni
//
//  Created by Jacques COUVREUR on 23.05.12.
//  Copyright (c) 2012 me.couvreur.jacques. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
- (void)configureView;
@end

@implementation DetailViewController

@synthesize detailItem = _detailItem;
@synthesize detailDescriptionLabel = _detailDescriptionLabel;
@synthesize masterPopoverController = _masterPopoverController;
@synthesize imageView, nameLabel, strengthLabel, creativityLabel, speedLabel, quantityLabel, sloganLabel, detailTextView, quantityStepper;
@synthesize detailIndexPath, detailUpdateDelegate;


#pragma mark - Managing the detail item

- (void) setQuantity {
    self.quantityLabel.text = [NSString stringWithFormat:@"%@ = %d", (NSLocalizedString(@"Quantity", @"Quantity")), self.detailItem.quantity];
}

- (void)setDetailItem:(id)newDetailItem {
    quantityStepper.value = ((Figure*)newDetailItem).quantity;
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        [self configureView];
    }
    if (self.masterPopoverController != nil) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }        
}

- (void)configureView {
    if (self.detailItem) {
        self.title = [NSString stringWithFormat:@"%@", self.detailItem.name];

        self.imageView.image = [UIImage imageNamed:[self.detailItem photoName]];
        self.nameLabel.text = [NSString stringWithFormat:@"%@ %d  -  No %d", (NSLocalizedString(@"Série", @"Série")), self.detailItem.serie, self.detailItem.index];
        self.strengthLabel.text = [NSString stringWithFormat:@"%@ = %d", (NSLocalizedString(@"Strength", @"Strength")), self.detailItem.strength];
        self.creativityLabel.text = [NSString stringWithFormat:@"%@ = %d", (NSLocalizedString(@"Creativity", @"Creativity")), self.detailItem.creativity];
        self.speedLabel.text = [NSString stringWithFormat:@"%@ = %d", (NSLocalizedString(@"Speed", @"Speed")), self.detailItem.speed];
        self.sloganLabel.text = [NSString stringWithFormat:@"« %@ »", self.detailItem.slogan];
        self.detailDescriptionLabel.text = self.detailItem.detail;
        self.detailTextView.text = self.detailItem.detail;
        [self setQuantity];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
//    self.navigationController.navigationBar.alpha = 0.7f;
    self.navigationController.navigationBar.translucent = NO;
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated {
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
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Detail", @"Detail");
    }
    return self;
}
							
#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"Séries", @"Séries");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}


- (IBAction)quantityChange:(id)sender {
    UIStepper* stepper = sender;
    self.detailItem.quantity = stepper.value;
    [self setQuantity];
    [self.detailUpdateDelegate detailUpdatedForIndexPath:detailIndexPath];
}

@end
