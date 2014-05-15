//
//  ViewController.m
//  arc
//
//  Created by tarena on 14-5-15.
//  Copyright (c) 2014年 tarena. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property(nonatomic,strong)ZFArcView *arcView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.arcView = [[ZFArcView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:self.arcView];
    [self.view sendSubviewToBack:self.arcView];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)drawNextArc:(id)sender {
    self.arcView.myArc.centerIsExist = NO;
    self.arcView.myArc.arcIsExist = NO;
}
@end
