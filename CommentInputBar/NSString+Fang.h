//
//  NSString+Fang.h
//  CommentInputBar
//
//  Created by fcz on 2017/8/8.
//  Copyright © 2017年 com.TulipSport. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface NSString (Fang)

#pragma mark 内容宽度,高度

+ (float)getWidth:(NSString *)text font:(UIFont *)font height:(float)height;
+ (float)getHeight:(NSString *)text font:(UIFont *)font width:(float)width;

@end
