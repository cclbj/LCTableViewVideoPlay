//
//  UITableView+Video.m
//  LCTableViewVideoPlay
//
//  Created by lcc on 2017/12/14.
//  Copyright © 2017年 early bird international. All rights reserved.
//

#import "UITableView+Video.h"
#import "LCVideoCell.h"
#import <objc/runtime.h>

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@implementation UITableView (Video)


#pragma public method
- (void)handleScrollingCellOutScreen{
    
    if (self.playingCell  && [self playingCellIsOutScreen]) {
        NSLog(@"移动到屏幕外，停止播放视频");
        LCVideoCell *videoCell = self.playingCell;
        videoCell.backgroundColor = [UIColor whiteColor];
    }
    
}

/* 进行视频自动播放判定逻辑判断 */
- (void)handleScrollPlay{
    
    LCVideoCell *cell = (LCVideoCell *)[self getMinCenterCell];
    
    if (cell && ![self.playingCell isEqual:cell]) {
        
        NSLog(@"当前的 cell 存在,是%ld",cell.tag);
        cell.backgroundColor = [UIColor redColor];
        
        if (self.playingCell) {
            LCVideoCell *playingCell = (LCVideoCell *)self.playingCell;
            playingCell.backgroundColor = [UIColor whiteColor];
        }
        
        self.playingCell = cell;
        
    }
    
    
    
}

/* 获取距离屏幕最中间的cell */
- (id)getMinCenterCell{
    
    CGFloat minDelta = CGFLOAT_MAX;
    
    //屏幕中央位置
    CGFloat screenCenterY = SCREEN_HEIGHT * 0.5;
    //当前距离屏幕中央最近的cell
    id minCell = nil;
    
    for (id cell in self.visibleCells) {
        
        if ([cell isKindOfClass:[LCVideoCell class]]) {
            
            LCVideoCell *videoCell = (LCVideoCell *)cell;
            //获取当前 cell 的居中点坐标
            CGPoint cellCenterPoint = CGPointMake(videoCell.frame.origin.x, videoCell.frame.size.height * 0.5 + videoCell.frame.origin.y);
            //转换当前的 cell 的坐标
            CGPoint coorPoint = [videoCell.superview convertPoint:cellCenterPoint toView:nil];
            CGFloat deltaTemp =  fabs(coorPoint.y - screenCenterY);
            
            if (deltaTemp < minDelta) {
                minCell = videoCell;
                minDelta = deltaTemp;
            }
            
        }
        
    }
    
    return minCell;
    
}

/* 当前播放的视频是否划出屏幕 */
- (BOOL)playingCellIsOutScreen{

    if (!self.playingCell) {
        
        return YES;
    }
    
    LCVideoCell *videoCell = (LCVideoCell *)self.playingCell;
    
    //当前显示区域内容
    CGRect visiableContentZone = [UIScreen mainScreen].bounds;
    
    //向上滚动
    if(self.scrollDirection == LC_SCROLL_UP){
        
        //找到滚动时候的正在播放视频的cell底部的y坐标点，计算出当前播放的视频是否移除到屏幕外
        CGRect playingCellFrame = videoCell.frame;
        
        //当前正在播放视频的坐标
        CGPoint cellBottomPoint = CGPointMake(playingCellFrame.origin.x, playingCellFrame.size.height + playingCellFrame.origin.y);
        
        //坐标系转换（转换到 window坐标）
        CGPoint coorPoint = [videoCell.superview convertPoint:cellBottomPoint toView:nil];
        
        return CGRectContainsPoint(visiableContentZone, coorPoint);
        
        
    }
    
    //向下滚动
    else if(self.scrollDirection == LC_SCROLL_DOWN){
        
        //找到滚动时候的正在播放视频的cell底部的y坐标点，计算出当前播放的视频是否移除到屏幕外
        CGRect playingCellFrame = videoCell.frame;
        
        //当前正在播放视频的坐标
        CGPoint orginPoint = CGPointMake(playingCellFrame.origin.x, playingCellFrame.origin.y);
        
        //坐标系转换（转换到 window坐标）
        CGPoint coorPoint = [videoCell.superview convertPoint:orginPoint toView:nil];
        
        return CGRectContainsPoint(visiableContentZone, coorPoint);
        
    }
    
    else{
        
        return NO;
    }
    
    
    return YES;
}

#pragma getter and setter

- (void)setScrollDirection:(LCSCROLL_DIRECTION)scrollDirection{
    
    objc_setAssociatedObject(self, @selector(scrollDirection), @(scrollDirection), OBJC_ASSOCIATION_ASSIGN);
    
}

- (LCSCROLL_DIRECTION)scrollDirection{
    
    return [objc_getAssociatedObject(self, _cmd) integerValue];
    
}

- (void)setPlayingCell:(id)playingCell{
    
    objc_setAssociatedObject(self, @selector(playingCell), playingCell, OBJC_ASSOCIATION_RETAIN);
    
}

- (id)playingCell{
    
   return objc_getAssociatedObject(self, _cmd);
}

- (UIView *)centerSepLine{
    
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setCenterSepLine:(UIView *)centerSepLine{

    objc_setAssociatedObject(self, @selector(centerSepLine), centerSepLine, OBJC_ASSOCIATION_RETAIN);
}




@end
