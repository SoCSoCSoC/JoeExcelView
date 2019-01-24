//
//  ViewController.m
//  JoeExcelView
//
//  Created by Joe on 2016/12/9.
//  Copyright © 2016年 QQ. All rights reserved.
//

#import "ViewController.h"
#import "JoeExcelView.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    JoeExcelView *joeExcelView = [[JoeExcelView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:joeExcelView];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
