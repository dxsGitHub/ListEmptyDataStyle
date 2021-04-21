//
//  UITableView+Empty.m
//  Sheng
//
//  Created by High on 2021/4/7.
//  Copyright © 2021 First Cloud. All rights reserved.
//

#import "UITableView+Empty.h"
#import "ListEmptyDataView.h"

static NSString *tableViewCategoryEmptyKey = @"tableViewCategoryEmptyKey";
static NSString *tableViewCategoryUseEmptyKey = @"tableViewCategoryUseEmptyKey";
static NSString *tableViewCategoryEmptyImageKey = @"tableViewCategoryEmptyImageKey";
static NSString *tableViewCategoryEmptyTitleKey = @"tableViewCategoryEmptyTitleKey";
static NSString *tableViewCategoryFirstLoadEmptyKey = @"tableViewCategoryFirstLoadEmptyKey";
static NSString *tableViewCategoryEmptyTitleColorKey = @"tableViewCategoryEmptyTitleColorKey";
static NSString *tableViewViewCategoryTextPositionEmptyKey = @"tableViewViewCategoryTextPositionEmptyKey";

@interface UITableView (Empty)

///空视图（可自行修改EmptyView进行定制）
@property (nonatomic, strong) ListEmptyDataView *emptyV;

///是否是第一次加载
@property (nonatomic, assign) bool isFirstLoad;

@end


@implementation UITableView (Empty)

+ (void)load {
    Method originMethod = class_getInstanceMethod(self, @selector(reloadData));
    Method newMethod = class_getInstanceMethod(self, @selector(xs_reloadData));
    method_exchangeImplementations(originMethod, newMethod);
}


///是否是第一次加载
- (bool)isFirstLoad {
    if (objc_getAssociatedObject(self, &tableViewCategoryFirstLoadEmptyKey) != nil) {
        return [objc_getAssociatedObject(self, &tableViewCategoryFirstLoadEmptyKey) boolValue];
    } else {
        return YES;
    }
}

- (void)setIsFirstLoad:(bool)isFirstLoad {
    objc_setAssociatedObject(self, &tableViewCategoryFirstLoadEmptyKey, [NSNumber numberWithBool:isFirstLoad], OBJC_ASSOCIATION_RETAIN);
}


///是否使用默认空视图
- (bool)isUseDefaultEmpty {
    if (objc_getAssociatedObject(self, &tableViewCategoryUseEmptyKey) != nil) {
        return [objc_getAssociatedObject(self, &tableViewCategoryUseEmptyKey) boolValue];
    } else {
        return NO;
    }
}

- (void)setIsUseDefaultEmpty:(bool)isUseDefaultEmpty {
    objc_setAssociatedObject(self, &tableViewCategoryUseEmptyKey, [NSNumber numberWithBool:isUseDefaultEmpty], OBJC_ASSOCIATION_RETAIN);
}



///是否文字在上面
- (bool)isTextPositionTop {
    if (objc_getAssociatedObject(self, &tableViewViewCategoryTextPositionEmptyKey) != nil) {
        return [objc_getAssociatedObject(self, &tableViewViewCategoryTextPositionEmptyKey) boolValue];
    } else {
        return NO;
    }
}

- (void)setIsTextPositionTop:(bool)isTextPositionTop {
    objc_setAssociatedObject(self, &tableViewViewCategoryTextPositionEmptyKey, [NSNumber numberWithBool:isTextPositionTop], OBJC_ASSOCIATION_RETAIN);
}

///接收外部传入图片
- (UIImage *)emptyImage {
    return objc_getAssociatedObject(self, &tableViewCategoryEmptyImageKey);
}

- (void)setEmptyImage:(UIImage *)emptyImage {
    objc_setAssociatedObject(self, &tableViewCategoryEmptyImageKey, emptyImage, OBJC_ASSOCIATION_RETAIN);
}


///接收外部传入标题描述
- (NSString *)emptyTitle {
    return objc_getAssociatedObject(self, &tableViewCategoryEmptyTitleKey);
}

- (void)setEmptyTitle:(NSString *)emptyTitle {
    objc_setAssociatedObject(self, &tableViewCategoryEmptyTitleKey, emptyTitle, OBJC_ASSOCIATION_RETAIN);
}


///接收外部传入标题颜色
- (UIColor *)emptyTitleColor {
    return objc_getAssociatedObject(self, &tableViewCategoryEmptyTitleColorKey);
}

- (void)setEmptyTitleColor:(UIColor *)emptyTitleColor {
    objc_setAssociatedObject(self, &tableViewCategoryEmptyTitleColorKey, emptyTitleColor, OBJC_ASSOCIATION_RETAIN);
}


///空视图（可自行修改EmptyView进行定制）
- (ListEmptyDataView *)emptyV {
    return objc_getAssociatedObject(self, &tableViewCategoryEmptyKey);
}

- (void)setEmptyV:(ListEmptyDataView *)emptyV {
    objc_setAssociatedObject(self, &tableViewCategoryEmptyKey, emptyV, OBJC_ASSOCIATION_RETAIN);
}



///新的reload方法
- (void)xs_reloadData {
    [self xs_reloadData];
    
    if (self.isUseDefaultEmpty) {

        NSBundle *bundle = [NSBundle bundleForClass:[ListEmptyDataView class]];
        NSURL *url = [bundle URLForResource:@"ListEmpytImages" withExtension:@"bundle"];
        NSBundle *insideBundle = [NSBundle bundleWithURL:url];
        NSString *path = [insideBundle pathForResource:@"empty_default_image" ofType:@"png"];
        UIImage *image = [UIImage imageWithContentsOfFile:path];
        
        NSString *title = @"暂时没有数据哦~";
        UIColor *titleColor = [UIColor grayColor];
        
        if (self.emptyImage != nil) {
            image = self.emptyImage;
        }
        
        if (self.emptyTitle != nil) {
            title = self.emptyTitle;
        }
        
        if (self.emptyTitleColor != nil) {
            titleColor = self.emptyTitleColor;
        }
        
        if (self.emptyImage != nil) {
            image = self.emptyImage;
        }
        
        [self layoutIfNeeded];
        [self setNeedsLayout];
        
        CGSize headSize = (self.tableHeaderView != nil) ? self.tableHeaderView.frame.size : CGSizeZero;
        
        if (self.isFirstLoad) {
            [self addEmptyViewToBackgroundWithSize:headSize image:image title:title color:titleColor textPositionTop: self.isTextPositionTop];
            self.isFirstLoad = false;
            
        } else {
            NSInteger number = [self numberOfSections];
            bool isHavingData = false;
            for (NSInteger idx = 0; idx < number; idx++) {
                NSInteger num = [self numberOfRowsInSection:idx];
                if (num > 0) {
                    isHavingData = YES;
                }
            }

            if ((self.emptyV != nil) && ([[self subviews] containsObject:self.emptyV])) {
                [self sendSubviewToBack:self.emptyV];
                self.emptyV.hidden = isHavingData;
            } else {
                [self addEmptyViewToBackgroundWithSize:headSize image:image title:title color:titleColor textPositionTop: self.isTextPositionTop];
            }
        }
    }
}



///添加空视图到tableView上
- (void)addEmptyViewToBackgroundWithSize:(CGSize)size
                                   image:(UIImage *)image
                                   title:(NSString*)title
                                   color:(UIColor *)color
                         textPositionTop:(BOOL)textPositionTop
{
    CGRect frame = CGRectMake(0, size.height, self.frame.size.width, self.frame.size.height - size.height);
    self.emptyV = [[ListEmptyDataView alloc] initFrame:frame image:image title:title titleColor:color textPositionTop: textPositionTop];
    self.emptyV.hidden = YES;
    self.emptyV.backgroundColor = [UIColor clearColor];
    [self insertSubview:self.emptyV atIndex:0];
}

@end

