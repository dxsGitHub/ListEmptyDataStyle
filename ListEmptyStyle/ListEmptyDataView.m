//
//  ListEmptyDataView.m
//  Sheng
//
//  Created by High on 2021/4/7.
//  Copyright © 2021 First Cloud. All rights reserved.
//

#import "ListEmptyDataView.h"

@interface ListEmptyDataView()

@property (nonatomic, strong) UIImageView *emptyImage;

@property (nonatomic, strong) UILabel *titleLab;

@end


@implementation ListEmptyDataView

- (ListEmptyDataView *)initFrame:(CGRect)frame image:(UIImage *)image title:(NSString *)title titleColor:(UIColor *)color textPositionTop:(bool)textPositionTop {
    ListEmptyDataView *emptyV = [[ListEmptyDataView alloc] initWithFrame:frame];
    emptyV.backgroundColor = [UIColor clearColor];

    _emptyImage = [[UIImageView alloc] initWithFrame:CGRectZero];
    _emptyImage.image = image;
    _emptyImage.backgroundColor = [UIColor clearColor];
    [emptyV addSubview:_emptyImage];
    _emptyImage.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    _emptyImage.center = CGPointMake(frame.size.width / 2.0, frame.size.height / 2.0);

    [self layoutIfNeeded];
    [self setNeedsLayout];
    
    _titleLab = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, frame.size.width - 60, 18)];
    _titleLab.backgroundColor = [UIColor clearColor];
    _titleLab.textAlignment = NSTextAlignmentCenter;
    _titleLab.textColor = color;
    _titleLab.font = [UIFont systemFontOfSize:14];
    
    CGFloat y = textPositionTop ? (_emptyImage.frame.origin.y - 20) : (CGRectGetMaxY(_emptyImage.frame) + 15);
    
    _titleLab.center = CGPointMake(frame.size.width / 2.0, y);
    _titleLab.text = title;
    [emptyV addSubview:_titleLab];
    
    return emptyV;
}



@end
