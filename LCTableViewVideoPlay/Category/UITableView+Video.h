//
//  UITableView+Video.h
//  LCTableViewVideoPlay
//
//  Created by lcc on 2017/12/14.
//  Copyright © 2017年 early bird international. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,LCSCROLL_DIRECTION) {
    
    LC_SCROLL_UP,
    LC_SCROLL_DOWN,
    LC_SCROLL_NONE
    
};

@interface UITableView (Video)

/* 正在播放的 cell */
@property (nonatomic,strong) id playingCell;

/* 滚动方向*/
@property (nonatomic,assign) LCSCROLL_DIRECTION scrollDirection;

/* 屏幕中央的位置 */
@property (nonatomic,strong) UIView *centerSepLine;

/* 获取距离屏幕最中间的cell */
- (id)getMinCenterCell;

/* 当前播放的视频是否划出屏幕 */
- (BOOL)playingCellIsOutScreen;

/* 进行视频自动播放判定逻辑判断 */
- (void)handleScrollPlay;

/* 滚动期间判断是否已经移动到屏幕外面 */
- (void)handleScrollingCellOutScreen;


@end
