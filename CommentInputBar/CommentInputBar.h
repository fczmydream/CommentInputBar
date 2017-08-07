//
//  CommentInputBar.h
//  Sport
//
//  Created by fcz on 16/6/1.
//  Copyright © 2016年 ZKR. All rights reserved.
//

#import <UIKit/UIKit.h>

static inline UIViewAnimationOptions AnimationOptionsForCurve(UIViewAnimationCurve curve)
{
    return curve << 16;
}


@protocol CommentInputBarDelegate <NSObject>

- (void)clickSendComment:(NSString *)content;

@optional

- (void)clickInputBarComment;

- (void)clickInputBarLike:(NSString *)likeCount;

- (void)inputBarEndEditing;

@end

@interface CommentInputBar : UIView

@property (nonatomic,assign) BOOL isCanLike;
@property (nonatomic,assign) NSInteger commentTag;  //评论类型（ 0 跟帖  1 回复 ）
@property (nonatomic,strong) UILabel *titleLabel;

@property (nonatomic,strong) NSString *placeTitle;
@property (nonatomic,assign) BOOL isDiscover;

@property (nonatomic,assign) id<CommentInputBarDelegate> delegate;

- (id)initWithFrame:(CGRect)frame andCommentCount:(NSString *)commentCount likeCount:(NSString *)likeCount;

- (id)initWithFrame:(CGRect)frame andReply:(NSString *)reply;

- (void)showkeyBoard;

- (void)setCommentCount:(NSString *)commentCount andLikeCount:(NSString *)likeCount;

- (void)commentSuccess;

- (void)commentFail;

- (void)zanSuccess;

- (void)changeColorStyle:(UIColor *)color;

@end
