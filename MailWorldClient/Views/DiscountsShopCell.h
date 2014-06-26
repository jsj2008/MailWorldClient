//
//  DiscountsShopCell.h
//  MailWorldClient
//
//  Created by liyoro on 13-10-17.
//  Copyright (c) 2013年 liyoro. All rights reserved.
//
//  打折活动商店

#import "TableViewCell.h"
#import "EMAsyncImageView.h"
#import "DiscountsShopEntity.h"

@interface DiscountsShopCell : TableViewCell {
    DiscountsShopEntity *shop;
}
@property (nonatomic, strong) DiscountsShopEntity *shop;

+ (CGFloat)heightForEntry:(DiscountsShopEntity *)entity withWidth:(CGFloat)width;
- (id)initWithReuseIdentifier:(NSString *)identifier;

@end
