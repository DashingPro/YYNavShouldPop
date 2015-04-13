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
/**
 *  重载父类的方法
 *  是否要pop
 */
- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item
{
    UIViewController *vc = self.topViewController;
    
    if (item != vc.navigationItem) { // 这个条件成立的话，则是代码写的pop语句
        // return [super navigationBar:navigationBar shouldPopItem:item];
        return YES; // 本来应该像上一句一样返回默认实现的，但是如果返回NO，crash，所以直接返回YES。
    }
    
    if ([vc conformsToProtocol:@protocol(YYNavigationControllerShouldPop)]) { // 看看vc有没有意愿
        if (![(id<YYNavigationControllerShouldPop>)vc yy_navigationController:self shouldPopItemWhenBackBarButtonItemClick:item]) { // 返回NO,表示不希望pop
            return NO;
        }
    }
    // 否则返回默认实现
    return [super navigationBar:navigationBar shouldPopItem:item];
    
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

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if (gestureRecognizer == self.interactivePopGestureRecognizer) {
        id<UIGestureRecognizerDelegate> originDelegate = objc_getAssociatedObject(self, kSaveOriginDelegateKey);
        return [originDelegate gestureRecognizer:gestureRecognizer shouldReceiveTouch:touch];
    }
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    if (gestureRecognizer == self.interactivePopGestureRecognizer) {
        id<UIGestureRecognizerDelegate> originDelegate = objc_getAssociatedObject(self, kSaveOriginDelegateKey);
        return [originDelegate gestureRecognizer:gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:otherGestureRecognizer];
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
