//
//  YYNavigationController.m
//  YYNavShouldPop
//
//  Created by Dashing on 15/4/12.
//  Copyright (c) 2015年 Dashing. All rights reserved.
//

#import "YYNavigationController.h"
#import <objc/runtime.h>
#import "YYNavigationControllerShouldPop.h"


static char *kSaveOriginDelegateKey;



@interface UINavigationController (YYShouldPop)
- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item;
@end

#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wincomplete-implementation"
@implementation UINavigationController (YYShouldPop)
@end
#pragma clang diagnostic pop

@interface YYNavigationController ()

@end

@implementation YYNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    objc_setAssociatedObject(self, kSaveOriginDelegateKey, self.interactivePopGestureRecognizer.delegate, OBJC_ASSOCIATION_ASSIGN);
    NSLog(@"%@", self.interactivePopGestureRecognizer.delegate);
    self.interactivePopGestureRecognizer.delegate = (id<UIGestureRecognizerDelegate>)self;
    
}

- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item
{
    UIViewController *vc = self.topViewController;
    
    if (item != vc.navigationItem) {
        return [super navigationBar:navigationBar shouldPopItem:item];
    }
    
    if ([vc conformsToProtocol:@protocol(YYNavigationControllerShouldPop)]) {
        if ([(id<YYNavigationControllerShouldPop>)vc yy_navigationController:self shouldPopItemWhenBackBarButtonItemClick:item]) {
            return [super navigationBar:navigationBar shouldPopItem:item];
        }
        else {
            return NO;
        }
    } else {
        return [super navigationBar:navigationBar shouldPopItem:item];
    }
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer == self.interactivePopGestureRecognizer) {
        
        UIViewController *vc = [self topViewController];
        if ([vc conformsToProtocol:@protocol(YYNavigationControllerShouldPop)]) {
            if (![(id<YYNavigationControllerShouldPop>)vc yy_navigationControllerShouldStartInteractivePopGestureRecognizer:self]) {
                return NO;
            }
        }
        id<UIGestureRecognizerDelegate> originDelegate = objc_getAssociatedObject(self, kSaveOriginDelegateKey);
        return [originDelegate gestureRecognizerShouldBegin:gestureRecognizer];
    }
    return YES;
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
