//
//  UITableView+Empty.h
//  Sheng
//
//  Created by High on 2021/4/7.
//  Copyright © 2021 First Cloud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (Empty)

///是否使用默认空视图
@property (nonatomic, assign) bool isUseDefaultEmpty;

///文字显示位置是否在图片上面
@property (nonatomic, assign) bool isTextPositionTop;

///接收外部传入图片
@property (nonatomic, strong) UIImage *emptyImage;

///接收外部传入标题描述
@property (nonatomic, strong) NSString *emptyTitle;

///接收外部传入标题颜色
@property (nonatomic, strong) UIColor *emptyTitleColor;

@end

NS_ASSUME_NONNULL_END
