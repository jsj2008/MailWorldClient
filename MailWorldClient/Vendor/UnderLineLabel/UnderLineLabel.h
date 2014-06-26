//
//  UnderLineLabel.h
//  CustomLabelWithUnderLine
//
//  Created by liuweizhen on 13-4-17.
//  Copyright (c) 2013年 WeiZhen_Liu. All rights reserved.
//
//  edit by liyoro@163.com
//

#import <UIKit/UIKit.h>

@interface UnderLineLabel : UILabel
{
    UIControl *_actionView;
    UIColor *_normalColor;
    UIColor *_highlightedColor;
    BOOL _shouldUnderline;
}

@property (nonatomic, strong) UIColor *normalColor;
@property (nonatomic, strong) UIColor *highlightedColor;
@property (nonatomic, assign) BOOL shouldUnderline;

- (void)setText:(NSString *)text;
- (void)addTarget:(id)target action:(SEL)action;

@end
 