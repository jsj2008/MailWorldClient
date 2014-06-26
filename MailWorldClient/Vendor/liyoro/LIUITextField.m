//
//  InsetsTextField.m
//  LIGridview
//
//  Created by liyoro on 13-5-17.
//  Copyright (c) 2013年 liyoro. All rights reserved.
//

#import "LIUITextField.h"

@implementation LIUITextField

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame cornerRadius:(CGFloat)cornerRadius {
    self = [super initWithFrame:frame];
    if (self) {
        self.cornerRadius = cornerRadius;
        
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    self.borderStyle = UITextBorderStyleNone;
//    UIImage *fieldBg = [[UIImage imageNamed:@"inputFd.png"]stretchableImageWithLeftCapWidth:10 topCapHeight:5];
//    [self setBackground:fieldBg];
//    [UIColor colorWithRed:0.752941 andGreen:0.752941 andBlue:0.752941]
//    [UIColor colorWithRed:0.752941 green:0.752941 blue:0.752941 alpha:1]
//    [UIColor colorWithRed:0.011765 andGreen:0.243137 andBlue:0.341176]
    
    self.autocorrectionType = UITextAutocorrectionTypeNo;
    self.autocapitalizationType = UITextAutocapitalizationTypeNone;
    CALayer *layer = self.layer;
    layer.backgroundColor = [[UIColor whiteColor] CGColor];
    
//    layer.cornerRadius = 8.0;
    layer.cornerRadius = self.cornerRadius;
    layer.masksToBounds = YES;
    layer.borderWidth = 1.0;
    layer.borderColor = [[UIColor colorWithRed:0.752941 green:0.752941 blue:0.752941 alpha:0.5] CGColor];
//    [layer setShadowColor: [[UIColor colorWithRed:0.011765 green:0.243137 blue:0.341176 alpha:0.2] CGColor]];
//    [layer setShadowOpacity:1];
//    [layer setShadowOffset: CGSizeMake(0, 2.0)];
//    [layer setShadowRadius:5];
    [self setClipsToBounds:NO];
    [self setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [self setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
}

//控制 placeHolder 的位置，左右缩 20
- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectMake(bounds.origin.x + 20, bounds.origin.y + 8,
                      bounds.size.width - 40, bounds.size.height - 16);
}

// 控制文本的位置，左右缩 20
- (CGRect)editingRectForBounds:(CGRect)bounds {
    return [self textRectForBounds:bounds];
}


@end
