//
//  Config.h
//  CommentInputBar
//
//  Created by fcz on 2017/8/8.
//  Copyright © 2017年 com.TulipSport. All rights reserved.
//

#ifndef Config_h
#define Config_h

#define SCREEN_HEIGHT   [[UIScreen mainScreen] bounds].size.height
#define SCREEN_WIDTH    [[UIScreen mainScreen] bounds].size.width

#define RGB(r, g, b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define Color(x, a) [UIColor colorWithRed:x/255.0 green:x/255.0 blue:x/255.0 alpha:a]

#define Font(a) [UIFont systemFontOfSize:a]

#endif /* Config_h */
