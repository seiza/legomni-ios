//
//  DetailViewController.h
//  Legomni
//
//  Created by Jacques COUVREUR on 23.05.12.
//  Copyright (c) 2012 me.couvreur.jacques. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Figure.h"

@protocol DetailUpdateDelegate
    - (void) detailUpdatedForIndexPath:(NSIndexPath*)indexPath;
@end


@interface DetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) Figure* detailItem;

@property (strong, nonatomic) IBOutlet UIImageView* imageView;
@property (strong, nonatomic) IBOutlet UILabel* nameLabel;
@property (strong, nonatomic) IBOutlet UILabel* strengthLabel;
@property (strong, nonatomic) IBOutlet UILabel* creativityLabel;
@property (strong, nonatomic) IBOutlet UILabel* speedLabel;
@property (strong, nonatomic) IBOutlet UILabel* quantityLabel;
@property (strong, nonatomic) IBOutlet UILabel* sloganLabel;
@property (strong, nonatomic) IBOutlet UILabel* detailDescriptionLabel;
@property (strong, nonatomic) IBOutlet UITextView* detailTextView;
@property (strong, nonatomic) IBOutlet UIStepper* quantityStepper;

@property (strong, nonatomic) NSIndexPath* detailIndexPath;
@property (strong, nonatomic) id<DetailUpdateDelegate> detailUpdateDelegate;

- (IBAction)quantityChange:(id)sender;

@end
