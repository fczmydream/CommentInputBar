//
//  NSString+Fang.m
//  CommentInputBar
//
//  Created by fcz on 2017/8/8.
//  Copyright © 2017年 com.TulipSport. All rights reserved.
//

#import "NSString+Fang.h"

@implementation NSString (Fang)

+ (float)getWidth:(NSString *)text font:(UIFont *)font height:(float)height {
    NSDictionary *attributes = @{NSFontAttributeName:font};
    CGRect newSize = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
    return newSize.size.width+1;
}

+ (float)getHeight:(NSString *)text font:(UIFont *)font width:(float)width {
    NSDictionary *attributes = @{NSFontAttributeName:font};
    CGSize newSize =[text boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    return newSize.height+1;
}

@end
