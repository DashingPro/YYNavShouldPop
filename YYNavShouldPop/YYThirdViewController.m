//
//  YYThirdViewController.m
//  DongHuaJi
//
//  Created by Dashing on 15/4/1.
//  Copyright (c) 2015年 Dashing. All rights reserved.
//

#import "YYThirdViewController.h"
#import "UINavigationController+YYShouldPopExtention.h"
#import "YYNavigationControllerShouldPop.h"

@interface YYThirdViewController () <YYNavigationControllerShouldPop>

@end

@implementation YYThirdViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"Third";
        
        //self.navigationController.delegate = self;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithRed:0.688 green:1.000 blue:0.753 alpha:1.000];
}

- (BOOL)yy_navigationController:(UINavigationController *)navigationController shouldPopItemWhenBackBarButtonItemClick:(UINavigationItem *)item
{
    UIAlertView *al = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您确认要放弃当前正在编辑的内容么？" delegate:self cancelButtonTitle:nil otherButtonTitles:@"留在此页", @"放弃编辑", nil];
    [al show];
    al.tag = 999;
    return NO;
}

- (BOOL)yy_navigationControllerShouldStartInteractivePopGestureRecognizer:(UINavigationController *)navigationController
{
    UIAlertView *al = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您确认要放弃当前正在编辑的内容么？" delegate:self cancelButtonTitle:nil otherButtonTitles:@"留在此页", @"放弃编辑", nil];
    [al show];
    al.tag = 999;
    return NO;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 999) {
        if (!buttonIndex) {
            [self.navigationItem setHidesBackButton:YES];
            [self.navigationItem setHidesBackButton:NO];
        }
        if (buttonIndex) {
            // 放弃编辑
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
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
