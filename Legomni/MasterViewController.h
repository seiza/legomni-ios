//
//  MasterViewController.h
//  Legomni
//
//  Created by Jacques COUVREUR on 23.05.12.
//  Copyright (c) 2012 me.couvreur.jacques. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Legomni.h"
#import "DetailViewController.h"

//@class DetailViewController;

@interface MasterViewController : UITableViewController <DetailUpdateDelegate>

@property (strong, nonatomic) DetailViewController *detailViewController;
@property (strong, nonatomic) Legomni *legomni;

@end
