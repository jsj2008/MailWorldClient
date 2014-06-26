//
//  StoreCell.h
//  MailWorldClient
//
//  Created by liyoro on 13-10-15.
//  Copyright (c) 2013年 liyoro. All rights reserved.
//

#import "TableViewCell.h"
#import "ShopEntity.h"
#import "EMAsyncImageView.h"

@interface StoreCell : TableViewCell {
    ShopEntity *shop;
}

@property (nonatomic, strong) ShopEntity *shop;

+ (CGFloat)heightForEntry:(ShopEntity *)entity withWidth:(CGFloat)width;
- (id)initWithReuseIdentifier:(NSString *)identifier;

@end
