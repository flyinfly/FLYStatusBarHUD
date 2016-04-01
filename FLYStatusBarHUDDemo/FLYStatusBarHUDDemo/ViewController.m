//
//  ViewController.m
//  FLYStatusBarHUDDemo
//
//  Created by houzhifei on 16/4/1.
//  Copyright © 2016年 FLY. All rights reserved.
//

#import "ViewController.h"
#import "FLYStatusBarHUD.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)success:(id)sender {
    [FLYStatusBarHUD showSuccess:@"success"];
}

- (IBAction)error:(id)sender {
    [FLYStatusBarHUD showSuccess:@"error"];
}

- (IBAction)load:(id)sender {
    [FLYStatusBarHUD showLoading:@"loading"];
}

- (IBAction)hide:(id)sender {
    [FLYStatusBarHUD hide];
}

- (IBAction)normal:(id)sender {
    [FLYStatusBarHUD showMessage:@"right" image:[UIImage imageNamed:@"check"]];
}

@end
