//
//  CommentInputBar.m
//  Sport
//
//  Created by fcz on 16/6/1.
//  Copyright © 2016年 ZKR. All rights reserved.
//

#define FONT 12

#import "CommentInputBar.h"
#import "NSString+Fang.h"
#import "UIView+Fang.h"
#import "Config.h"

@interface CommentInputBar () <UITextViewDelegate>

@property (nonatomic,strong) UILabel *commentLabel;
@property (nonatomic,strong) UILabel *placeLabel;
@property (nonatomic,strong) UIImageView *likeImgView;
@property (nonatomic,strong) UILabel *likeCountLable;
@property (nonatomic,strong) UILabel *commentCountLabel;
@property (nonatomic,strong) UIImageView *commentCountImgView;

@property (nonatomic,strong) NSString *content;
@property (nonatomic,strong) UIButton *sureBtn;
@property (nonatomic,strong) UIButton *cancelBtn;
@property (nonatomic,assign) BOOL sureBtnCanClick;
@property (nonatomic,strong) UITextView *textView;
@property (nonatomic,strong) UIView *commentView;
@property (nonatomic,strong) UIView *backgroudView;
@property (nonatomic,strong) UIColor *styleColor;

@property (nonatomic,assign) BOOL canResign;
@property (nonatomic,assign) BOOL haveNotify;
@property (nonatomic,assign) float keyboardH;

@property (nonatomic,assign) BOOL keyboardShow;

@end


@implementation CommentInputBar

- (id)initWithFrame:(CGRect)frame andCommentCount:(NSString *)commentCount likeCount:(NSString *)likeCount
{
    if(self = [super initWithFrame:frame])
    {
        [self setUIComment:commentCount andLike:likeCount];
        [self setKeyBoardUI];
        
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame andReply:(NSString *)reply
{
    if(self = [super initWithFrame:frame])
    {
        [self setReplyUI];
        [self setKeyBoardUI];
    }
    return self;
}

- (void)setKeyBoardUI
{
    self.cancelBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.sureBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(80, 5, SCREEN_WIDTH-160, 30)];
    self.commentView=[[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_HEIGHT, 150)];
    self.textView=[[UITextView alloc]initWithFrame:CGRectMake(10, 40, SCREEN_WIDTH-20, 100)];
    self.sureBtnCanClick=YES;
    
    UIWindow* currentWindow = [UIApplication sharedApplication].keyWindow;
    
    self.backgroudView=[[UIView alloc]initWithFrame:currentWindow.frame];
    self.backgroudView.backgroundColor = [UIColor blackColor];
    
    self.backgroudView.alpha=0;
    
    UITapGestureRecognizer *taps=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapdissView:)];
    [self.backgroudView addGestureRecognizer:taps];
    
    [currentWindow addSubview:self.backgroudView];
    
    
    
    self.commentView.backgroundColor=[UIColor whiteColor];
    
    [currentWindow addSubview:self.commentView];
    
    
    
    self.textView.backgroundColor=[UIColor whiteColor];
    self.textView.scrollsToTop = NO;
    self.textView.font=[UIFont systemFontOfSize:17];
    self.textView.delegate=self;
    
    [self.commentView addSubview:self.textView];
    
    self.keyboardShow = NO;
    
    _cancelBtn.frame=CGRectMake(10, 5, 60, 30);
    [_cancelBtn setTitle:@"清空" forState:UIControlStateNormal];
    _cancelBtn.backgroundColor=[UIColor clearColor];
    
    [_cancelBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [_cancelBtn setTitleColor:RGB(245, 115, 11) forState:UIControlStateNormal];
    [_cancelBtn addTarget:self action:@selector(dissInputView:) forControlEvents:UIControlEventTouchUpInside];
    [self.commentView addSubview:_cancelBtn];
    
    [self.commentView addSubview:self.titleLabel];
    self.titleLabel.textAlignment=NSTextAlignmentCenter;
    self.titleLabel.font=[UIFont systemFontOfSize:17];
    self.titleLabel.backgroundColor=[UIColor clearColor];
    self.titleLabel.textColor=RGB(245, 115, 11);
    
    _sureBtn.frame=CGRectMake(SCREEN_WIDTH-70, 5, 60, 30);
    [_sureBtn setTitle:@"发送" forState:UIControlStateNormal];
    if (!self.sureBtnCanClick||!self.textView.text||[self.textView.text isEqualToString:@""]) {
        [_sureBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _sureBtn.userInteractionEnabled=NO;
    }else{
        _sureBtn.userInteractionEnabled = YES;
        [_sureBtn setTitleColor:RGB(245, 115, 11) forState:UIControlStateNormal];
    }
    [_sureBtn addTarget:self action:@selector(sendComment:) forControlEvents:UIControlEventTouchUpInside];
    [_sureBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [self.commentView addSubview:_sureBtn];
    
    UIView *aView=[[UIView alloc]initWithFrame:CGRectMake(10, 35, SCREEN_WIDTH-20, 0.5)];
    aView.backgroundColor=RGB(245, 115, 11);
    [self.commentView addSubview:aView];

}

-(void)setReplyUI{
    
    self.backgroundColor = Color(251, 1);
    
    UIView *aView=[[UIView alloc]initWithFrame:CGRectMake(0, 0.4, SCREEN_WIDTH, 0.4)];
    aView.backgroundColor=Color(212, 1);
    aView.alpha=1;
    [self addSubview:aView];
    
    self.commentLabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 8, SCREEN_WIDTH-40, 25)];
    self.commentLabel.textColor=[UIColor blackColor];
    self.commentLabel.textAlignment=NSTextAlignmentLeft;
    self.commentLabel.layer.masksToBounds=YES;
    self.commentLabel.layer.cornerRadius=10;
    self.commentLabel.layer.borderWidth=0.5;
    self.commentLabel.layer.borderColor=[RGB(129, 129, 129)CGColor];
    self.commentLabel.layer.borderColor=[RGB(224, 224, 224)CGColor];
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapContent:)];
    self.commentLabel.userInteractionEnabled=YES;
    self.commentLabel.font=[UIFont systemFontOfSize:14];
    self.commentLabel.text=@"";
    self.commentLabel.backgroundColor=[UIColor whiteColor];
    
    
    [self.commentLabel addGestureRecognizer:tap];
    
    [self addSubview:self.commentLabel];
    self.placeLabel=[[UILabel alloc]initWithFrame:CGRectMake(26, 8,100, 25)];
    self.placeLabel.text=@"我来说点什么...";
    self.placeLabel.font=[UIFont systemFontOfSize:12];
    self.placeLabel.backgroundColor=[UIColor clearColor];
    self.placeLabel.textColor=[UIColor grayColor];
    [self addSubview:self.placeLabel];
}


- (void)setUIComment:(NSString *)comment andLike:(NSString *)like
{
    self.backgroundColor = Color(251, 1);

    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0.4, SCREEN_WIDTH, 0.4)];
    view.backgroundColor=Color(212, 1);
    view.alpha=1;
    [self addSubview:view];
    self.commentLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 8, SCREEN_WIDTH-200, 25)];
    self.commentLabel.textColor=[UIColor blackColor];
    self.commentLabel.textAlignment=NSTextAlignmentLeft;
    self.commentLabel.layer.masksToBounds=YES;
    self.commentLabel.layer.cornerRadius=10;
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapContent:)];
    self.commentLabel.userInteractionEnabled=YES;
    self.commentLabel.font=[UIFont systemFontOfSize:13];
    self.commentLabel.backgroundColor=[UIColor whiteColor];
    self.commentLabel.layer.borderWidth=0.5;
    self.commentLabel.layer.borderColor=[RGB(129, 129, 129)CGColor];
    self.commentLabel.layer.borderColor=[RGB(224, 224, 224)CGColor];
    
    [self.commentLabel addGestureRecognizer:tap];
    [self addSubview:self.commentLabel];
    
    
    self.placeLabel=[[UILabel alloc]initWithFrame:CGRectMake(16, 8,100, 25)];
    self.placeLabel.text=@"我来说点什么...";
    self.placeLabel.font=[UIFont systemFontOfSize:12];
    self.placeLabel.backgroundColor=[UIColor clearColor];
    self.placeLabel.textColor=[UIColor grayColor];
    [self addSubview:self.placeLabel];
    
    self.likeCountLable=[[UILabel alloc]initWithFrame:CGRectMake(0, 5, 40, 30)];
    self.likeCountLable.textColor=[UIColor grayColor];
    self.likeCountLable.font=[UIFont systemFontOfSize:12];
    self.likeCountLable.textAlignment=NSTextAlignmentRight;
    self.likeCountLable.textColor=RGB(255, 104, 51);
    self.likeCountLable.text = @"0";
    self.likeCountLable.textColor = Color(172, 1);
    UITapGestureRecognizer *tapLikeCount = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapLikeImg:)];
    [self.likeCountLable addGestureRecognizer:tapLikeCount];
    [self addSubview:self.likeCountLable];
    
    self.likeImgView=[[UIImageView alloc]initWithFrame:CGRectMake(40, 5, 25, 25)];
    self.likeImgView.image=[UIImage imageNamed:@"zanNormal.png"];
    self.likeImgView.contentMode=1;
    self.likeImgView.userInteractionEnabled=YES;
    UITapGestureRecognizer*tapLikeImg=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapLikeImg:)];
    [self.likeImgView addGestureRecognizer:tapLikeImg];
    [self addSubview:self.likeImgView];
    
    
    self.commentCountLabel=[[UILabel alloc]initWithFrame:CGRectMake(15+SCREEN_WIDTH-200+5, 7,90, 25)];
    self.commentCountLabel.font=[UIFont systemFontOfSize:FONT];
    self.commentCountLabel.layer.masksToBounds=YES;
    self.commentCountLabel.layer.cornerRadius=5;
    self.commentCountLabel.text = @"0条跟帖";
    
    self.commentCountLabel.textColor=RGB(255, 70, 40);
    self.commentCountLabel.font=[UIFont systemFontOfSize:FONT];
    self.commentCountLabel.textAlignment=NSTextAlignmentCenter;
    UITapGestureRecognizer *tapCommentCount=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapCommentCount:)];
    self.commentCountLabel.userInteractionEnabled=YES;
    [self.commentCountLabel addGestureRecognizer:tapCommentCount];
    [self addSubview:self.commentCountLabel];
    
    self.commentCountImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 25, 25)];
    [self.commentCountImgView setImage:[UIImage imageNamed:@"channel_comment_mark Highlight@2x"]];
    self.commentCountImgView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapCommentImgV = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapCommentCount:)];
    [self.commentCountImgView addGestureRecognizer:tapCommentImgV];
    [self addSubview:self.commentCountImgView];
    
    [self setCommentCount:comment andLikeCount:like];

}

- (void)setCommentCount:(NSString *)commentCount andLikeCount:(NSString *)likeCount
{
    if(!commentCount) commentCount = @"0";
    if(!likeCount) likeCount = @"0";
    
    self.commentCountLabel.text = [NSString stringWithFormat:@"%@条跟帖",commentCount];
    self.likeCountLable.text = [NSString stringWithFormat:@"%@",likeCount];
    
    CGFloat likeCountW = [NSString getWidth:likeCount font:Font(12) height:30];
    _likeCountLable.frame = CGRectMake(SCREEN_WIDTH-15-likeCountW, 5, likeCountW, 30);
    _likeImgView.frame = CGRectMake(_likeCountLable.x-25, 5, 25, 25);
    
    if(_isDiscover){
        _commentCountLabel.hidden = YES;
        _commentCountImgView.hidden = YES;
        _likeImgView.frame = CGRectMake(_likeCountLable.x-25, 7, 25, 25);
        _commentLabel.frame = CGRectMake(10, 8, _likeImgView.x-25, 25);
        return;
    }
    
    CGFloat commentCountW = [NSString getWidth:self.commentCountLabel.text font:Font(12) height:25];
    _commentCountLabel.frame = CGRectMake(_likeImgView.x-15-commentCountW, 7, commentCountW, 25);
    _commentCountImgView.frame = CGRectMake(_commentCountLabel.x-25, 7, 25, 25);
    _commentLabel.frame = CGRectMake(10, 8, _commentCountImgView.x-25, 25);
    
}

- (void)showkeyBoard
{
    if(self.keyboardShow){
        return;
    }
    
    self.titleLabel.text = @"回复";
    self.commentTag = 1;
    
    if(self.placeTitle.length > 0){
        self.titleLabel.text = self.placeTitle;
    }
    
    [self addNotify];
    [self.textView becomeFirstResponder];
    [self keyboardBeginShow];
}

- (void)setIsCanLike:(BOOL)isCanLike
{
    _isCanLike = isCanLike;
    
    if(_isCanLike){
        self.likeImgView.userInteractionEnabled = YES;
        self.likeImgView.image=[UIImage imageNamed:@"zanNormal"];
        self.likeCountLable.textColor = Color(172, 1);
        if(_isDiscover){
            self.likeImgView.image = [UIImage imageNamed:@"discover_praise"];
        }
    }else{
        self.likeImgView.userInteractionEnabled = NO;
        self.likeImgView.image=[UIImage imageNamed:@"zanSelected"];
        if(_isDiscover){
            self.likeImgView.image = [UIImage imageNamed:@"discover_praise_on"];
        }
        if(_styleColor){
            self.likeCountLable.textColor = _styleColor;
        }else{
            self.likeCountLable.textColor = RGB(255, 70, 40);
        }
    }
}

- (void)zanSuccess
{
    [self.likeImgView startHeartAnimation];
}

- (void)tapContent:(UITapGestureRecognizer *)tapContent
{
    self.titleLabel.text = @"跟帖";
    self.commentTag = 0;
    
    [self addNotify];
    [self.textView becomeFirstResponder];
    [self keyboardBeginShow];
}

- (void)tapLikeImg:(UITapGestureRecognizer *)tapLike
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(clickInputBarLike:)])
    {
        [self.delegate clickInputBarLike:self.likeCountLable.text];
    }
    [self setIsCanLike:NO];
    double delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        if(_isCanLike){
            [self setIsCanLike:YES];
        }
    });
}

- (void)tapCommentCount:(UITapGestureRecognizer *)tapComment
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(clickInputBarComment)])
    {
        [self.delegate clickInputBarComment];
    }
}

- (void)sendComment:(UIButton *)button
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(clickSendComment:)])
    {
        [self.delegate clickSendComment:self.textView.text];
    }
    
    if(!_haveNotify){
        [self addNotify];
    }
    
    self.canResign = YES;
    [self.textView resignFirstResponder];
    
    [self setSureBtnCanClick:NO];
    double delayInSeconds = 5.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self setSureBtnCanClick:YES];
    });
    
}

- (void)dissInputView:(UIButton *)button
{
    if(!_haveNotify){
        [self addNotify];
    }
    
    self.textView.text = @"";
    self.canResign = YES;
    [self.textView resignFirstResponder];
}

- (void)tapdissView:(UITapGestureRecognizer *)tap
{
    if(!_haveNotify){
        [self addNotify];
    }
    
    if(![self.textView isFirstResponder]){
//        UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
//        UIView   *firstResponder = [keyWindow performSelector:@selector(firstResponder)];
//        NSLog(@"%@",firstResponder);
        [self.textView becomeFirstResponder];
    }
    self.canResign = YES;
    [self.textView resignFirstResponder];
}

- (void)setSureBtnCanClick:(BOOL)sureBtnCanClick{
    
    _sureBtnCanClick=sureBtnCanClick;
    [self canClickSend];
}

- (void)commentSuccess
{
    self.commentLabel.text = @"";
    self.placeLabel.hidden = NO;
    [self setSureBtnCanClick:YES];
}

- (void)commentFail
{
    [self setSureBtnCanClick:YES];
}

- (void)keyboardBeginShow
{
    if(_commentLabel.text && (![_commentLabel.text isEqualToString:@""]))
    {
        _textView.text = [_commentLabel.text substringFromIndex:3];
    }
    else
    {
        _textView.text = @"";
    }
    
    [self canClickSend];
}

#pragma mark - 监听键盘事件
- (void)keyboardWillShow:(NSNotification *)notif {
    
    CGRect rect = [[notif.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat y = rect.size.height;
    self.keyboardH = y;
    float animationTime = [[notif.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
  
    UIViewAnimationCurve curve= [[notif.userInfo valueForKey:UIKeyboardAnimationCurveUserInfoKey]integerValue];
    
    UIWindow *currentWindow = [UIApplication sharedApplication].keyWindow;
    [currentWindow insertSubview:self.backgroudView belowSubview:self.commentView];
    
    [UIView animateWithDuration:animationTime
                          delay:0.0f
                        options:AnimationOptionsForCurve(curve) | UIViewAnimationOptionBeginFromCurrentState
     
                     animations:^{
                         self.commentView.frame=CGRectMake(0, SCREEN_HEIGHT-y-150, SCREEN_WIDTH, 150+y);
                         self.backgroudView.alpha=0.6;
                         
                     }
                     completion:^(__unused BOOL finished){
                         
                     }];
    
    self.keyboardShow = YES;
}

- (void)keyboardWillHide:(NSNotification *)notif {
    
    if(!self.canResign){
        return;
    }
    
    if(_textView.text && (![_textView.text isEqualToString:@""]))
    {
        _commentLabel.text = [NSString stringWithFormat:@"   %@",_textView.text];
        _placeLabel.hidden = YES;
    }
    else
    {
        _commentLabel.text = @"";
        _placeLabel.hidden = NO;
    }
    
    float animationTime = [[notif.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    UIViewAnimationCurve curve= [[notif.userInfo valueForKey:UIKeyboardAnimationCurveUserInfoKey]integerValue];
    
    [UIView animateWithDuration:animationTime
                          delay:0.0f
                        options:AnimationOptionsForCurve(curve) | UIViewAnimationOptionBeginFromCurrentState
     
                     animations:^{
                         self.commentView.frame=CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 150+_keyboardH);
                         self.backgroudView.alpha=0;
                     }
                     completion:^(__unused BOOL finished){
                         [self.backgroudView removeFromSuperview];
                       
                     }];
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(inputBarEndEditing)])
    {
        [self.delegate inputBarEndEditing];
    }
    
}


- (void)keyboardDidHide:(NSNotification *)notify
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    self.haveNotify = NO;
    self.canResign = NO;
    self.keyboardShow = NO;
}

- (void)textViewDidChange:(UITextView *)textView
{
    [self canClickSend];
}

- (void)canClickSend
{
    if ((![_textView.text isEqualToString:@""])&&_textView.text&&self.sureBtnCanClick) {
        self.sureBtn.userInteractionEnabled=YES;
        [_sureBtn setTitleColor:RGB(245, 115, 11) forState:UIControlStateNormal];
        if(_styleColor){
            [_sureBtn setTitleColor:_styleColor forState:UIControlStateNormal];
        }
    }else{
        self.sureBtn.userInteractionEnabled=NO;
        [_sureBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    }
}

- (void)changeColorStyle:(UIColor *)color
{
    if(color)
    {
        _styleColor = color;
        _commentCountLabel.textColor = color;
        _titleLabel.textColor = color;
        [_cancelBtn setTitleColor:color forState:UIControlStateNormal];
        if(!_isCanLike){
            _likeCountLable.textColor = color;
        }
        [self canClickSend];
    }
}

- (void)addNotify
{
    //监听键盘事件
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidHide:)
                                                 name:UIKeyboardDidHideNotification
                                               object:nil];
    
    _haveNotify = YES;
    
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    _haveNotify = NO;
    
    [_textView resignFirstResponder];
    NSLog(@"评论输入框dealloc");
}

@end
