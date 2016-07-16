//
//  ViewController.m
//  MyScrollView
//
//  Created by Jennifier on 16/7/16.
//  Copyright © 2016年 xiuping xie. All rights reserved.
//

#import "ViewController.h"
#import "MyScrollView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    MyScrollView *scrollView = [[MyScrollView alloc] initWithFrame:CGRectMake(0, 200, [UIScreen mainScreen].bounds.size.width, 200)];
    scrollView.imageNames = @[@"01",@"02",@"03",@"04",@"05"];
    
    [self.view addSubview:scrollView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
