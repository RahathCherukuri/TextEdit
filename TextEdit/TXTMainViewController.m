//
//  TXTMainViewController.m
//  TextEdit
//
//  Created by Rahath Cherukuri on 10/01/14.
//  CSE651
//  HOMEWORK-3
//  Copyright (c) 2014 Rahath Cherukuri. All rights reserved.
//

#import "TXTMainViewController.h"

@interface TXTMainViewController ()

@end
int flag=0;
int insertflag=0;
NSString* tempFileName;

@implementation TXTMainViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Based on the button clicks the actions are performed.
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    
    NSString *fileName=[alertView textFieldAtIndex:0].text;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *inserttemppath=[documentsDirectory stringByAppendingPathComponent:fileName];
    NSFileManager *manager = [NSFileManager defaultManager];
    
    if(alertView.tag==1)
    {
     if (buttonIndex == 0) {
         NSLog(@"Cancel Tapped.");
     }
     else if (buttonIndex == 1) {
         if([manager fileExistsAtPath:inserttemppath])
         {
          NSLog(@"FileOpening!");
          [self readFileWithName:fileName];
          tempFileName = fileName;
         }
         else
         {
             NSLog(@"File %@ doesn't exists", fileName);
             UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"File does not exist"
                                                             message:@"No such file found!!"
                                                            delegate:nil
                                                   cancelButtonTitle:@"OK"
                                                   otherButtonTitles:nil];
             [alert show];
         }
     }
    }
    
    if(alertView.tag==3)
    {
        if (buttonIndex == 0) {
            NSLog(@"Cancel Tapped.");
        }
        else if (buttonIndex == 1) {
            NSLog(@"FileSaving!");
            if(flag==0)
            {
              tempFileName=[alertView textFieldAtIndex:0].text;
              NSLog(@"temp file :%@",tempFileName);
                flag++;
            }
            [self writeString:_text.text toFile:fileName];
        }
    }
    
    if(alertView.tag==4)
    {
        //NSString *tempContents=_text.text;
        
         if (buttonIndex == 0) {
            NSLog(@"Cancel Tapped.");
         }
         else if (buttonIndex == 1) {
             if([manager fileExistsAtPath:inserttemppath])
             {
                 NSLog(@"FileInserting!");
                 NSError *error=nil;
                 NSString* contentOfFile = [NSString stringWithContentsOfFile:inserttemppath encoding:NSStringEncodingConversionAllowLossy error:&error];
                 //[self readFileWithName:fileName];
                 //_text.text=[NSString stringWithFormat:@"%@%@", tempContents, _text.text];
                 _text.text = [_text.text stringByAppendingString:contentOfFile];
             }
             else{
                 NSLog(@"File %@ doesn't exists", fileName);
                 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"File does not exist"
                                                                 message:@"No such file found!!"
                                                                delegate:nil
                                                       cancelButtonTitle:@"OK"
                                                       otherButtonTitles:nil];
                 [alert show];
             }
         }
    }
}

// The user to be prompted for the name of a text file from which to set the UITextView contents
- (IBAction)openFile:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"Open File?"
                          message:@""
                          delegate:self
                          cancelButtonTitle:@"Cancel"
                          otherButtonTitles:@"OK",nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alert show];
    alert.tag=1;
    
}

// It reades the file with a specific name.

- (void)readFileWithName:(NSString *)fileName
{
    // Fetch directory path of document for local application.
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    // Have the absolute path of file named fileName by joining the document path with fileName, separated by path separator.
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:fileName];
    
    // NSFileManager is the manager organize all the files on device.
    NSFileManager *manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]) {
        // Start to Read.
        NSError *error = nil;
        NSString *content = [NSString stringWithContentsOfFile:filePath encoding:NSStringEncodingConversionAllowLossy error:&error];
        NSLog(@"File Content: %@", content);
        _text.text=content;
        if (error) {
            NSLog(@"There is an Error with Reading: %@", error);
        }
    } else {
        NSLog(@"File %@ doesn't exists", fileName);
    }
}

// Creates a file.
- (void)createFileWithName:(NSString *)fileName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:fileName];
    
    NSFileManager *manager = [NSFileManager defaultManager];
    // 1st, This function could allow you to create a file with initial contents.
    // 2nd, You could specify the attributes of values for the owner, group, and permissions.
    // Here we use nil, which means we use default values for these attibutes.
    // 3rd, it will return YES if NSFileManager create it successfully or it exists already.
    if ([manager createFileAtPath:filePath contents:nil attributes:nil]) {
        NSLog(@"Created the File Successfully.");
    } else {
        NSLog(@"Failed to Create the File");
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    NSString *textValue = textField.text;
    NSLog(@"Value: %@", textValue);
}

// This causes the last file Open'ed to be overwritten with the current UITextView contents;  if no file has been opened, the user must be prompted for the name of a file to be overwritten with the current UITextView contents
- (IBAction)saveFile:(id)sender
{
    if(flag==0)
    {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"Save File?"
                              message:@""
                              delegate:self
                              cancelButtonTitle:@"Cancel"
                              otherButtonTitles:@"OK",nil];
        alert.alertViewStyle = UIAlertViewStylePlainTextInput;
        [alert show];
        alert.tag=3;
    }
    else
    {
        [self writeString:_text.text toFile:tempFileName];
        NSLog(@"temp file :%@",tempFileName);
    }
}

// This causes the user to be prompted for the name of a file to be overwritten with the current UITextView content.
- (IBAction)saveAsFile:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"Save File?"
                          message:@""
                          delegate:self
                          cancelButtonTitle:@"Cancel"
                          otherButtonTitles:@"OK",nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alert show];
    alert.tag=3;
}

- (void)writeString:(NSString *)content toFile:(NSString *)fileName
{
    // Fetch directory path of document for local application.
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    // Have the absolute path of file named fileName by joining the document path with fileName, separated by path separator.
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:fileName];
    
    // NSFileManager is the manager organize all the files on device.
    NSFileManager *manager = [NSFileManager defaultManager];
    // Check if the file named fileName exists.
    if ([manager fileExistsAtPath:filePath]) {
        NSError *error = nil;
        [content writeToFile:filePath atomically:YES encoding:NSStringEncodingConversionAllowLossy error:&error];
        // If error happens, log it.
        if (error) {
            NSLog(@"There is an Error with Writing: %@", error);
        }
    } else {
        // If the file doesn't exists, log it.
        //NSLog(@"File %@ doesn't exists", fileName);
        [self createFileWithName:fileName];
        [self writeString:content toFile:fileName];
    }
    
    // This function could also be written without NSFileManager checking on the existence of file,
    // since the system will atomatically create it for you if it doesn't exist.
}

//This causes the user to be prompted for the name of a file whose contents will be inserted into the last cursor position in the UITextView contents.
- (IBAction)insertFile:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"Insert File?"
                          message:@""
                          delegate:self
                          cancelButtonTitle:@"Cancel"
                          otherButtonTitles:@"OK",nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alert show];
    alert.tag=4;
}

#pragma mark - Flipside View

- (void)flipsideViewControllerDidFinish:(TXTFlipsideViewController *)controller
{
    self.text.textColor = [UIColor colorWithRed: controller.redIntensity.value
                                         green: controller.greenIntensity.value
                                          blue: controller.blueIntensity.value
                                         alpha: 1];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showAlternate"]) {
        NSLog(@"in prepareForSegue");
        [[segue destinationViewController] setDelegate:self];
    }
}

- (IBAction)hideKeyboard:(id)sender
{
    [self.text resignFirstResponder];
}


@end
