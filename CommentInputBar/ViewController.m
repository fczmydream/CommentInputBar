//
//  ViewController.m
//  CommentInputBar
//
//  Created by fcz on 2017/8/8.
//  Copyright © 2017年 com.TulipSport. All rights reserved.
//

#import "ViewController.h"
#import "CommentInputBar.h"
#import "Config.h"

@interface ViewController () <CommentInputBarDelegate>

@property (nonatomic,strong) CommentInputBar *inputBar;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"跟帖";
    
    _inputBar = [[CommentInputBar alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-40, SCREEN_WIDTH, 40) andReply:@""];
    _inputBar.delegate = self;
    [self.view addSubview:_inputBar];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake((SCREEN_WIDTH-100)/2, 200, 100, 45);
    [button setTitle:@"回复" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(btnFun) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
}

- (void)btnFun
{
    [_inputBar showkeyBoard];
}

#pragma mark - CommentInputBarDelegate

- (void)clickSendComment:(NSString *)content
{
    
}

- (void)inputBarEndEditing
{
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
