//
//  ViewController.m
//  PhotoDemo
//
//  Created by 贺文杰 on 2020/3/1.
//  Copyright © 2020 贺文杰. All rights reserved.
//

#import "ViewController.h"
#import "WJMainView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    WJMainView *mainV = [[WJMainView alloc] init];
    mainV.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    [self.view addSubview:mainV];
}


@end
