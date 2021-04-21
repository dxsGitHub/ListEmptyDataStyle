//
//  ListEmptyDataView.h
//  Sheng
//
//  Created by High on 2021/4/7.
//  Copyright © 2021 First Cloud. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ListEmptyDataView : UIView

- (ListEmptyDataView *)initFrame:(CGRect)frame
                            image:(UIImage *)image
                            title:(NSString *)title
                       titleColor:(UIColor *)color
                  textPositionTop:(bool)textPositionTop;

@end

NS_ASSUME_NONNULL_END
