//
//  StoreCell.m
//  MailWorldClient
//
//  Created by liyoro on 13-10-15.
//  Copyright (c) 2013年 liyoro. All rights reserved.
//

#import "StoreCell.h"

#define kShopImageWidth 72.0
#define kShopImageHeight 72.0

@implementation StoreCell

@synthesize shop;

- (id)initWithReuseIdentifier:(NSString *)identifier {
    if ((self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier])) {
        [contentView setBackgroundColor:[UIColor whiteColor]];
        
        CALayer *layer = [contentView layer];
        [layer setContentsGravity:kCAGravityTopLeft];
        [layer setNeedsDisplayOnBoundsChange:YES];
    }
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    [self setNeedsDisplay];
}

- (void)setShop:(ShopEntity *)shop_ {
    shop = shop_;
    
    [self setNeedsDisplay];
}

+ (UIFont *)shopNameFont {
    return [UIFont boldSystemFontOfSize:16.0f];
}

+ (UIFont *)distanceFont {
    return [UIFont systemFontOfSize:13.0f];
}

+ (UIFont *)serverFont {
    return [UIFont systemFontOfSize:13.0f];
}

+ (UIFont *)zhuyingFont {
    return [UIFont systemFontOfSize:13.0f];
}

+ (CGFloat)heightForEntry:(ShopEntity *)entity withWidth:(CGFloat)width {
//    CGSize titlesize = [[entity shopname] sizeWithFont:[self shopNameFont] constrainedToSize:CGSizeMake(width - 16.0f, 200.0f) lineBreakMode:NSLineBreakByWordWrapping];
    return kShopImageHeight + 24.0f;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGSize offsets = CGSizeMake(8.0f, 12.0f);
    self.imageView.frame = CGRectMake(offsets.width, offsets.height, kShopImageWidth, kShopImageHeight);
    
}

- (void)drawContentView:(CGRect)rect {
    CGSize bounds = [self bounds].size;
    CGSize offsets = CGSizeMake(8.0f, 12.0f);
    CGRect cellRect = self.frame;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (self.highlighted || self.selected) { //选择或高亮时对应的颜色
        CGContextSetFillColorWithColor(context, [UIColor colorWithRed:1.000000 green:0.647059 blue:0.450980 alpha:1].CGColor);
        CGContextFillRect(context, CGRectMake(0, 0, cellRect.size.width, cellRect.size.height));
    }
    else {
        CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
        CGContextFillRect(context, CGRectMake(0, 0, cellRect.size.width, cellRect.size.height));
    }
#pragma mark - 画门店图片
    EMAsyncImageView *shopImageView = [[EMAsyncImageView alloc]init];
    shopImageView.image = [UIImage imageNamed:@"homeMenu_boy_on"];
    shopImageView.imageUrl = [shop shopImage];
    CGRect r = CGRectMake(offsets.width, offsets.height, kShopImageWidth, kShopImageHeight);
    [shopImageView.image drawInRect:r];
    
    NSString *shopname = [shop shopname];
    NSString *shopzhuying = [shop shopzhuying];
    NSString *distance = [shop distance];
    NSString *shopmwserver = [shop shopmwserver];//门店提供的服务
    NSInteger shopgrad = [shop shopgrad];
    
    if ([self isHighlighted] || [self isSelected]) [[UIColor whiteColor] set];
#pragma mark - 画店名
    if (!([self isHighlighted] || [self isSelected])) [[UIColor blackColor] set];
    [shopname drawInRect:CGRectMake(offsets.width*2+kShopImageWidth, offsets.height, bounds.width - (2 * offsets.width), 21) withFont:[[self class] shopNameFont] lineBreakMode:NSLineBreakByWordWrapping];
#pragma mark - 画距离
    if (!([self isHighlighted] || [self isSelected])) [[UIColor lightGrayColor] set];
    CGFloat distancewidth = [distance sizeWithFont:[[self class] distanceFont]].width;
    [distance drawAtPoint:CGPointMake(bounds.width - distancewidth - offsets.width, offsets.height) withFont:[[self class] distanceFont]];
#pragma mark - 画自提
    NSString *ziti = @"自提";
    CGFloat zitiwidth = [ziti sizeWithFont:[[self class] serverFont]].width+offsets.width*2;
    CGRect zitirect;
    CGRect zitibgrect;
    if ([shopmwserver hasSuffix:ziti] || [shopmwserver hasPrefix:ziti]) {
        zitirect = CGRectMake(offsets.width*2+kShopImageWidth, offsets.height*2+[shopname sizeWithFont:[[self class] serverFont]].height, zitiwidth, 21);
        zitibgrect = CGRectMake(offsets.width*2+kShopImageWidth, offsets.height*2+[shopname sizeWithFont:[[self class] serverFont]].height-2, zitiwidth, 21);
    }
    else {
        zitirect = CGRectMake(offsets.width*2+kShopImageWidth, offsets.height*2+[shopname sizeWithFont:[[self class] serverFont]].height, -offsets.width, 0);
        zitibgrect = CGRectMake(offsets.width*2+kShopImageWidth, offsets.height*2+[shopname sizeWithFont:[[self class] serverFont]].height-2, -offsets.width, 0);
    }
    
    //选择或高亮时对应的颜色
    CGContextSetFillColorWithColor(context, [UIColor colorWithRed:0.000000 green:0.607843 blue:0.968628 alpha:1].CGColor);
    CGContextFillRect(context, zitibgrect);
    
    if (!([self isHighlighted] || [self isSelected])) [[UIColor whiteColor] set];
    [ziti drawInRect:zitirect withFont:[[self class] serverFont]lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    
#pragma mark - 画O2O
    NSString *o2o = @"O2O";
    CGFloat o2owidth = [o2o sizeWithFont:[[self class] serverFont]].width+offsets.width*2;
    CGRect o2orect;
    CGRect o2obgrect;
    if ([shopmwserver hasSuffix:o2o] || [shopmwserver hasPrefix:o2o]) {
        o2orect = CGRectMake(offsets.width*3+kShopImageWidth+zitirect.size.width, offsets.height*2+[o2o sizeWithFont:[[self class] serverFont]].height, o2owidth, 21);
        o2obgrect = CGRectMake(offsets.width*3+kShopImageWidth+zitirect.size.width, offsets.height*2+[o2o sizeWithFont:[[self class] serverFont]].height-2, o2owidth, 21);
    }
    else {
        o2orect = CGRectMake(offsets.width*3+kShopImageWidth+zitirect.size.width, offsets.height*2+[o2o sizeWithFont:[[self class] serverFont]].height, -offsets.width, 0);
        o2obgrect = CGRectMake(offsets.width*3+kShopImageWidth+zitirect.size.width, offsets.height*2+[o2o sizeWithFont:[[self class] serverFont]].height-2, -offsets.width, 0);
    }
    
    //选择或高亮时对应的颜色
    CGContextSetFillColorWithColor(context, [UIColor colorWithRed:1.000000 green:0.584314 blue:0.203922 alpha:1].CGColor);
    CGContextFillRect(context, o2obgrect);
    
    if (!([self isHighlighted] || [self isSelected])) [[UIColor whiteColor] set];
    [o2o drawInRect:o2orect withFont:[[self class] serverFont]lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    
#pragma mark - 画星级
    if (!([self isHighlighted] || [self isSelected])) [[UIColor lightGrayColor] set];
    CGRect starrect = CGRectMake(offsets.width*4+kShopImageWidth+o2orect.size.width+zitirect.size.width, offsets.height*2+[shopname sizeWithFont:[[self class] serverFont]].height, 16*5+2*4, 16);
    
    UIImage *image1 = [UIImage imageNamed:@"backgroundStar"];
    UIImage *image2 = [UIImage imageNamed:@"foregroundStar"];
    
    for (int i = 0; i < 5; i ++) {
        CGRect imagerect = CGRectMake(i * starrect.size.width/5+offsets.width*4+kShopImageWidth+o2orect.size.width+zitirect.size.width, starrect.origin.y, starrect.size.width/5, starrect.size.height);
        if (i<shopgrad) {
            [image2 drawInRect:imagerect];
        }
        else {
            [image1 drawInRect:imagerect];
        }
    }
#pragma mark - 画主营业务
    if (!([self isHighlighted] || [self isSelected])) [[UIColor lightGrayColor] set];
    CGRect zhuyingrect;
    zhuyingrect.size.height = [shopzhuying sizeWithFont:[[self class] zhuyingFont]].height;
    zhuyingrect.size.width = bounds.width - offsets.width * 2 - kShopImageWidth;
    zhuyingrect.size.width = floorf(zhuyingrect.size.width);
    zhuyingrect.origin = CGPointMake(offsets.width*2+kShopImageWidth, bounds.height - offsets.height - zhuyingrect.size.height);
    [shopzhuying drawInRect:zhuyingrect withFont:[[self class] zhuyingFont] lineBreakMode:NSLineBreakByTruncatingTail alignment:NSTextAlignmentLeft];
    
}

@end
