//
//  LIUITextView.m
//  LIGridview
//
//  Created by liyoro on 13-5-17.
//  Copyright (c) 2013年 liyoro. All rights reserved.
//

#import "LIUITextView.h"

@interface LIUITextView ()

@property (nonatomic, strong) UILabel *placeHolderLabel;

@end

@implementation LIUITextView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    // Use Interface Builder User Defined Runtime Attributes to set
    // placeholder and placeholderColor in Interface Builder.
    if (!self.placeholder) {
        [self setPlaceholder:@""];
    }
    
    if (!self.placeholderColor) {
        [self setPlaceholderColor:[UIColor lightGrayColor]];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:nil];
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setPlaceholder:@""];
        [self setPlaceholderColor:[UIColor lightGrayColor]];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:nil];
    }
    return self;
}

- (void)textChanged:(NSNotification *)notification {
    if([[self placeholder] length] == 0) {
        return;
    }
    
    if([[self text] length] == 0) {
        [[self viewWithTag:999] setAlpha:1];
    }
    else {
        [[self viewWithTag:999] setAlpha:0];
    }
}

- (void)setText:(NSString *)text {
    [super setText:text];
    [self textChanged:nil];
}

- (void)drawRect:(CGRect)rect {
    
    if( [[self placeholder] length] > 0 ) {
        if (_placeHolderLabel == nil ) {
            _placeHolderLabel = [[UILabel alloc] initWithFrame:CGRectMake(8,8,self.bounds.size.width - 16,0)];
            _placeHolderLabel.lineBreakMode = NSLineBreakByWordWrapping;
            _placeHolderLabel.numberOfLines = 0;
            _placeHolderLabel.font = self.font;
            _placeHolderLabel.backgroundColor = [UIColor clearColor];
            _placeHolderLabel.textColor = self.placeholderColor;
            _placeHolderLabel.alpha = 0;
            _placeHolderLabel.tag = 999;
            [self addSubview:_placeHolderLabel];
        }
        
        _placeHolderLabel.text = self.placeholder;
        [_placeHolderLabel sizeToFit];
        [self sendSubviewToBack:_placeHolderLabel];
    }
    
    if( [[self text] length] == 0 && [[self placeholder] length] > 0 ) {
        [[self viewWithTag:999] setAlpha:1];
    }
    
    [self.layer setBackgroundColor: [[UIColor whiteColor]CGColor]];
    [self.layer setBorderColor: [[UIColor colorWithRed:0.752941 green:0.752941 blue:0.752941 alpha:0.5]CGColor]];
    [self.layer setBorderWidth:1.0];
    [self.layer setCornerRadius:8.0f];
    [self.layer setMasksToBounds:YES];
//
    UIGraphicsBeginImageContext(self.frame.size);
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(currentContext, 1.0);
    CGContextSetRGBStrokeColor(currentContext, 0.968628, 0.968628, 0.968628, 1.0);
    CGRect myRect = CGContextGetClipBoundingBox(currentContext);
    float myShadowColorValues[] = {0.968628, 0.968628, 0.968628, 1};
    CGColorSpaceRef myColorSpace =CGColorSpaceCreateDeviceRGB();
    CGColorRef colorRef = CGColorCreate(myColorSpace, myShadowColorValues);
    CGContextSetShadowWithColor(currentContext, CGSizeMake(-1,1),2, colorRef);
    
    CGContextStrokeRect(currentContext, myRect);
    
}

- (void)setContentOffset:(CGPoint)s {
	[super setContentOffset:s];
    
	if (self.tracking || self.decelerating) {
		//initiated by user...
		self.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
	}
    else {
        
		float bottomOffset = (self.contentSize.height - self.frame.size.height + self.contentInset.bottom);
		if(s.y < bottomOffset && self.scrollEnabled) {
			self.contentInset = UIEdgeInsetsMake(0, 0, 8, 0); //maybe use scrollRangeToVisible?
		}
	}
}

- (void)setContentInset:(UIEdgeInsets)s {
	UIEdgeInsets insets = s;
	
	if(s.bottom>8) insets.bottom = 0;
	insets.top = 0;
    
	[super setContentInset:insets];
}

@end
