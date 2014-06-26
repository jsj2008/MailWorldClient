//
//  InsetsTextField.h
//  LIGridview
//
//  Created by liyoro on 13-5-17.
//  Copyright (c) 2013年 liyoro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LIUITextField : UITextField

- (id)initWithFrame:(CGRect)frame;
- (id)initWithFrame:(CGRect)frame cornerRadius:(CGFloat)cornerRadius;

@property (nonatomic, assign) CGFloat cornerRadius;

@end
