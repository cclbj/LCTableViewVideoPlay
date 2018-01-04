//
//  LCVideoCell.m
//  LCTableViewVideoPlay
//
//  Created by lcc on 2017/12/14.
//  Copyright © 2017年 early bird international. All rights reserved.
//

#import "LCVideoCell.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface LCVideoCell()

@property (nonatomic,strong) UIButton *playBtn;

@end

@implementation LCVideoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self creatUI];
    }
    
    return self;
    
}

- (void)creatUI{
    
    [self.contentView addSubview:self.playBtn];
    
    
}

#pragma -mark- Touch event
- (void)playTouch:(UIButton *)button{
    
    
}

#pragma getter
- (UIButton *)playBtn{
    
    if (!_playBtn) {
        _playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _playBtn.center = CGPointMake(SCREEN_WIDTH * 0.5, 75);
        _playBtn.bounds  = CGRectMake(0, 0, 28, 28);
        [_playBtn addTarget:self action:@selector(playTouch:) forControlEvents:UIControlEventTouchDragInside];
        [_playBtn setBackgroundImage:[UIImage imageNamed:@"video_play"] forState:UIControlStateNormal];
        [_playBtn setBackgroundImage:[UIImage imageNamed:@"video_pause"] forState:UIControlStateSelected];
    }
    
    return _playBtn;
}

@end
