//
//  YYNavigationControllerShouldPopProtocol.h
//  DongHuaJi
//
//  Created by Dashing on 15/4/1.
//  Copyright (c) 2015年 Dashing. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  如果要截获返回按钮的点击事件 及 右滑手势事件 必须遵守该协议
 *  我们可以在这两个方法返回NO之前做一些操作
 */
@protocol YYNavigationControllerShouldPop <NSObject>
/**
 *  在系统的返回按钮被点击的时候 我们是否要让这个viewController pop
 *  可以在这个方法里面直接写popToRootViewController  具体过程不详，但是不蹦
 *
 *  @param navigationController 就是navigationController
 *  @param item                 navigationController最上层的vc所拥有的navigationItem
 *
 *  @return 返回YES执行 pop 最上面的vc，返回NO什么都不做
 */
- (BOOL)yy_navigationController:(UINavigationController *)navigationController shouldPopItemWhenBackBarButtonItemClick:(UINavigationItem *)item;
/**
 *  导航控制器识别了从屏幕左边边缘右滑的手势，这个手势是否要开始
 *
 *  @param navigationController 就是navigationController
 *
 *  @return 返回YES开始手势 返回NO忽略这个手势。
 */
- (BOOL)yy_navigationControllerShouldStartInteractivePopGestureRecognizer:(UINavigationController *)navigationController;

@end

