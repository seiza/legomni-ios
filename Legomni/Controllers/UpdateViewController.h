//
//  UpdateViewController.h
//  Legomni
//
//  Created by Jacques COUVREUR on 03.06.12.
//  Copyright (c) 2012 me.couvreur. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Legomni.h"

@interface UpdateViewController : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) Legomni* legomni;

@property (weak, nonatomic) IBOutlet UITextField *userTextField;
@property (weak, nonatomic) IBOutlet UITextField *serverTextField;
@property (weak, nonatomic) IBOutlet UITextView *receptionTextView;

- (IBAction)updateClicked:(id)sender;

@end
