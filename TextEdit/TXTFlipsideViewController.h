//
//  TXTFlipsideViewController.h
//  TextEdit
//
//  Created by Rahath Cherukuri on 10/01/14.
//  CSE651
//  HOMEWORK-3
//  Copyright (c) 2014 Rahath Cherukuri. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TXTFlipsideViewController;

@protocol TXTFlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(TXTFlipsideViewController *)controller;
@end

@interface TXTFlipsideViewController : UIViewController

@property (weak, nonatomic) id <TXTFlipsideViewControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UISlider *redIntensity;
@property (weak, nonatomic) IBOutlet UISlider *greenIntensity;
@property (weak, nonatomic) IBOutlet UISlider *blueIntensity;
@property (weak, nonatomic) IBOutlet UITextField *preview;

- (IBAction)done:(id)sender;
- (IBAction)previewColor:(id)sender;

@end
