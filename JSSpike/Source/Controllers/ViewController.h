//
//  ViewController.h
//  JSSpike
//
//  Created by BlitSoftware on 02/02/15.
//  Copyright (c) 2015 Blitsoftware. All rights reserved.
//


#import <UIKit/UIKit.h>


@interface ViewController : UIViewController

@property(weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property(weak, nonatomic) IBOutlet UITextField *userTextField;
@property(weak, nonatomic) IBOutlet UIButton *loginButton;

- (IBAction)onLoginButtonClick:(id)sender;

@end
