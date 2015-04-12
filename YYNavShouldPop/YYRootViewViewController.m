//
//  YYRootViewViewController.m
//  DongHuaJi
//
//  Created by Dashing on 15/4/1.
//  Copyright (c) 2015年 Dashing. All rights reserved.
//

#import "YYRootViewViewController.h"
#import "YYSecondViewController.h"

@interface YYRootViewViewController () <UINavigationControllerDelegate>

@end

@implementation YYRootViewViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"Root";
        
        UIBarButtonItem *rightBarBtnItem = [[UIBarButtonItem alloc] initWithTitle:@"Push" style:UIBarButtonItemStylePlain target:self action:@selector(pushToSecondViewController)];
        self.navigationItem.rightBarButtonItem = rightBarBtnItem;
        
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //self.navigationController.delegate = self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithRed:0.959 green:1.000 blue:0.680 alpha:1.000];
}

- (void)pushToSecondViewController
{
    YYSecondViewController *secondViewController = [[YYSecondViewController alloc] init];
    [self.navigationController pushViewController:secondViewController animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
