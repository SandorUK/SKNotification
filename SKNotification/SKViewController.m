//
//  SKViewController.m
//  SKNotification
//
//  Created by Sandor Kolotenko on 02/07/2014.
//  Copyright (c) 2014 Sandor Kolotenko. All rights reserved.
//

#import "SKViewController.h"
#import "SKNotification.h"

@interface SKViewController ()

@end

@implementation SKViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self.view setBackgroundColor:[UIColor lightGrayColor]];
}

- (IBAction)showNotification:(id)sender{
    
    [[SKNotification centre] setImageWithName:@"alert" forType:SKNAlert];
    [[SKNotification centre] setImageWithName:@"success" forType:SKNSuccess];
    [[SKNotification centre] setImageWithName:@"failure" forType:SKNFailure];
    [[SKNotification centre] setImageWithName:@"info" forType:SKNInfo];
    [[SKNotification centre] setDisplayDuration:1.85f];
    [[SKNotification centre] shouldDropShadow:YES];
    [[SKNotification centre] setMessageFont:[UIFont fontWithName:@"Helvetica-Bold" size:10.0f]];
    
    [[SKNotification centre] show:SKNAlert
                      withMessage:@"It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. "
                               in:self withCompletion:^{
                                   NSLog(@"Completed 1");
                               }];
    
    
    [[SKNotification centre] show:SKNSuccess
                      withMessage:@"Alert, your location is too far from the actual address."
                               in:self withCompletion:^{
                                   NSLog(@"Completed 2");
                               }];
    
    [[SKNotification centre] show:SKNInfo
                      withMessage:@"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s"
                               in:self withCompletion:^{
                                   NSLog(@"Completed 3");
                               }];
    
    [[SKNotification centre] show:SKNFailure
                      withMessage:@"Your location accuracy is too low, please check your address."
                               in:self withCompletion:^{
                                   NSLog(@"Completed 4");
                               }];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
