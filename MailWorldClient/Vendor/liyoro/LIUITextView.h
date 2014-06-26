//
//  LIUITextView.h
//  LIGridview
//
//  Created by liyoro on 13-5-17.
//  Copyright (c) 2013年 liyoro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LIUITextView : UITextView

@property (nonatomic, strong) NSString *placeholder;
@property (nonatomic, strong) UIColor *placeholderColor;

- (void)textChanged:(NSNotification *)notification;

@end
