//
//  YYNavigationControllerShouldPopProtocol.h
//  DongHuaJi
//
//  Created by Dashing on 15/4/1.
//  Copyright (c) 2015年 Dashing. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol YYNavigationControllerShouldPop <NSObject>

- (BOOL)yy_navigationController:(UINavigationController *)navigationController shouldPopItemWhenBackBarButtonItemClick:(UINavigationItem *)item;
- (BOOL)yy_navigationControllerShouldStartInteractivePopGestureRecognizer:(UINavigationController *)navigationController;

@end

