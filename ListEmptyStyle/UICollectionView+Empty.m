//
//  UICollectionView+Empty.m
//  ListEmptyDataStyle
//
//  Created by High on 2021/4/8.
//

#import "UICollectionView+Empty.h"
#import "ListEmptyDataView.h"

static NSString *collectionViewCategoryEmptyKey = @"collectionViewCategoryEmptyKey";
static NSString *collectionViewCategoryUseEmptyKey = @"collectionViewCategoryUseEmptyKey";
static NSString *collectionViewCategoryFirstLoadKey = @"collectionViewCategoryFirstLoadKey";
static NSString *collectionViewCategoryEmptyImageKey = @"collectionViewCategoryEmptyImageKey";
static NSString *collectionViewCategoryEmptyTitleKey = @"collectionViewCategoryEmptyTitleKey";
static NSString *collectionViewCategoryEmptyTitleColorKey = @"collectionViewCategoryEmptyTitleColorKey";
static NSString *collectionViewCategoryTextPositionEmptyKey = @"collectionViewCategoryTextPositionEmptyKey";

@interface UICollectionView (Empty)

///空视图（可自行修改EmptyView进行定制）
@property (nonatomic, strong) ListEmptyDataView *emptyV;

///是否是第一次加载
@property (nonatomic, assign) bool isFirstLoad;

@end

@implementation UICollectionView (Empty)

+ (void)load {
    Method originMethod = class_getInstanceMethod(self, @selector(reloadData));
    Method newMethod = class_getInstanceMethod(self, @selector(xs_reloadData));
    method_exchangeImplementations(originMethod, newMethod);
}

///是否是第一次加载
- (bool)isFirstLoad {
    if (objc_getAssociatedObject(self, &collectionViewCategoryFirstLoadKey) != nil) {
        return [objc_getAssociatedObject(self, &collectionViewCategoryFirstLoadKey) boolValue];
    } else {
        return YES;
    }
}

- (void)setIsFirstLoad:(bool)isFirstLoad {
    objc_setAssociatedObject(self, &collectionViewCategoryFirstLoadKey, [NSNumber numberWithBool:isFirstLoad], OBJC_ASSOCIATION_RETAIN);
}


///是否使用默认空视图
- (bool)isUseDefaultEmpty {
    if (objc_getAssociatedObject(self, &collectionViewCategoryUseEmptyKey) != nil) {
        return [objc_getAssociatedObject(self, &collectionViewCategoryUseEmptyKey) boolValue];
    } else {
        return NO;
    }
}

- (void)setIsUseDefaultEmpty:(bool)isUseDefaultEmpty {
    objc_setAssociatedObject(self, &collectionViewCategoryUseEmptyKey, [NSNumber numberWithBool:isUseDefaultEmpty], OBJC_ASSOCIATION_RETAIN);
}


///是否文字在上面
- (bool)isTextPositionTop {
    if (objc_getAssociatedObject(self, &collectionViewCategoryTextPositionEmptyKey) != nil) {
        return [objc_getAssociatedObject(self, &collectionViewCategoryTextPositionEmptyKey) boolValue];
    } else {
        return NO;
    }
}

- (void)setIsTextPositionTop:(bool)isTextPositionTop {
    objc_setAssociatedObject(self, &collectionViewCategoryTextPositionEmptyKey, [NSNumber numberWithBool:isTextPositionTop], OBJC_ASSOCIATION_RETAIN);
}


///接收外部传入图片
- (UIImage *)emptyImage {
    return objc_getAssociatedObject(self, &collectionViewCategoryEmptyImageKey);
}

- (void)setEmptyImage:(UIImage *)emptyImage {
    objc_setAssociatedObject(self, &collectionViewCategoryEmptyImageKey, emptyImage, OBJC_ASSOCIATION_RETAIN);
}


///接收外部传入标题描述
- (NSString *)emptyTitle {
    return objc_getAssociatedObject(self, &collectionViewCategoryEmptyTitleKey);
}

- (void)setEmptyTitle:(NSString *)emptyTitle {
    objc_setAssociatedObject(self, &collectionViewCategoryEmptyTitleKey, emptyTitle, OBJC_ASSOCIATION_RETAIN);
}


///接收外部传入标题颜色
- (UIColor *)emptyTitleColor {
    return objc_getAssociatedObject(self, &collectionViewCategoryEmptyTitleColorKey);
}

- (void)setEmptyTitleColor:(UIColor *)emptyTitleColor {
    objc_setAssociatedObject(self, &collectionViewCategoryEmptyTitleColorKey, emptyTitleColor, OBJC_ASSOCIATION_RETAIN);
}


///空视图（可自行修改EmptyView进行定制）
- (ListEmptyDataView *)emptyV {
    return objc_getAssociatedObject(self, &collectionViewCategoryEmptyKey);
}

- (void)setEmptyV:(ListEmptyDataView *)emptyV {
    objc_setAssociatedObject(self, &collectionViewCategoryEmptyKey, emptyV, OBJC_ASSOCIATION_RETAIN);
}

- (void)xs_reloadData {
    [self xs_reloadData];
    
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
    
    if (self.isFirstLoad) {
        [self addEmptyViewToBackgroundWithImage:image title:title color:titleColor textPositionTop: self.isTextPositionTop];
        self.isFirstLoad = NO;
        
    } else {
        NSInteger number = [self numberOfSections];
        bool isHavingData = false;
        for (NSInteger idx = 0; idx < number; idx++) {
            NSInteger num = [self numberOfItemsInSection: idx];
            if (num > 0) {
                isHavingData = YES;
            }
        }
        
        if ((self.emptyV != nil) && ([[self subviews] containsObject:self.emptyV])) {
            [self sendSubviewToBack:self.emptyV];
            self.emptyV.hidden = isHavingData;
            
        } else {
            [self addEmptyViewToBackgroundWithImage:image title:title color:titleColor textPositionTop: self.isTextPositionTop];
        }
    }
}

///添加空视图到tableView上
- (void)addEmptyViewToBackgroundWithImage:(UIImage *)image
                                   title:(NSString*)title
                                   color:(UIColor *)color
                          textPositionTop:(bool)textPositionTop
{
    [self layoutIfNeeded];
    [self setNeedsLayout];
    CGRect frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    self.emptyV = [[ListEmptyDataView alloc] initFrame:frame image:image title:title titleColor:color textPositionTop: textPositionTop];
    self.emptyV.hidden = YES;
    self.emptyV.backgroundColor = [UIColor clearColor];
    [self insertSubview:self.emptyV atIndex:0];
}


@end
