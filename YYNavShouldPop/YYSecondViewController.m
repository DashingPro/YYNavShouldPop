//
//  YYSecondViewController.m
//  DongHuaJi
//
//  Created by Dashing on 15/4/1.
//  Copyright (c) 2015年 Dashing. All rights reserved.
//

#import "YYSecondViewController.h"
#import "YYNavigationControllerShouldPop.h"

#import "YYThirdViewController.h"
#import "UINavigationController+YYShouldPopExtention.h"


@interface YYSecondViewController () <YYNavigationControllerShouldPop>

@end

@implementation YYSecondViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"Second";
        UIBarButtonItem *rightBarBtnItem = [[UIBarButtonItem alloc] initWithTitle:@"Push" style:UIBarButtonItemStylePlain target:self action:@selector(pushToThirdViewController)];
        self.navigationItem.rightBarButtonItem = rightBarBtnItem;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithRed:1.000 green:0.626 blue:0.694 alpha:1.000];
    NSLog(@"%@", self.navigationController.delegate);

   
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
    }
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 999) {
        if (buttonIndex) {
            // 放弃编辑
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer == self.navigationController.interactivePopGestureRecognizer) {
        
        return NO;
    }
    return YES;
}

- (void)pushToThirdViewController
{
    YYThirdViewController *vc = [[YYThirdViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
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
