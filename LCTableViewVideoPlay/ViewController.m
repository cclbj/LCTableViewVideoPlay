//
//  ViewController.m
//  LCTableViewVideoPlay
//
//  Created by lcc on 2017/12/14.
//  Copyright © 2017年 early bird international. All rights reserved.
//

#import "ViewController.h"
#import "LCVideoCell.h"
#import "UITableView+Video.h"

static NSString *cellID = @"videoCellID";

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,assign) CGFloat lastOffsetY;

@property (nonatomic,strong) UIView *centerSepLine;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.centerSepLine];
}

#pragma -mark- tableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LCVideoCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.tag = indexPath.row;
    
    return cell;
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{


    [self.tableView handleScrollPlay];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat offsetY = scrollView.contentOffset.y;
    
    CGFloat delaY = offsetY - self.lastOffsetY;
    
    self.tableView.scrollDirection = delaY > 0 ? LC_SCROLL_UP : LC_SCROLL_DOWN;
    
    if (delaY == 0) {
        self.tableView.scrollDirection = LC_SCROLL_NONE;
    }
    
    self.lastOffsetY = offsetY;
    
    
    //判断快速滑动期间是否移动到屏幕外
    [self.tableView handleScrollingCellOutScreen];
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    [self.tableView handleScrollPlay];
}


#pragma -mark- lazy load
- (UIView *)centerSepLine{
    
    if (!_centerSepLine) {
        _centerSepLine = [UIView new];
        _centerSepLine.backgroundColor = [UIColor orangeColor];
        _centerSepLine.frame = CGRectMake(0,self.view.frame.size.height * 0.5, self.view.frame.size.width, 1);
    }
    
    return _centerSepLine;
}
- (UITableView *)tableView{
    
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 150;
        [_tableView registerClass:[LCVideoCell class] forCellReuseIdentifier:cellID];
    }
    
    return _tableView;
}


@end
