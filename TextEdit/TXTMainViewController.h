//
//  TXTMainViewController.h
//  TextEdit
//
//  Created by Rahath Cherukuri on 10/01/14.
//  CSE651
//  HOMEWORK-3
//  Copyright (c) 2014 Rahath Cherukuri. All rights reserved.
//


#import "TXTFlipsideViewController.h"

@interface TXTMainViewController : UIViewController <TXTFlipsideViewControllerDelegate,UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *text;

- (IBAction)hideKeyboard:(id)sender;
- (IBAction)openFile:(id)sender;
- (IBAction)saveFile:(id)sender;
- (IBAction)saveAsFile:(id)sender;
- (IBAction)insertFile:(id)sender;

@end
