//
//  ViewController.m
//  ListEmptyDataStyle
//
//  Created by High on 2021/4/21.
//

#import "ViewController.h"
#import "ListEmptyStyle.h"
@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *listV;

@property (nonatomic, assign) NSInteger listNum;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _listNum = 10;
    
    _listV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 100) style:UITableViewStylePlain];
    _listV.backgroundColor = [UIColor whiteColor];
    _listV.delegate = self;
    _listV.dataSource = self;
    
    ///以下参数：不传就用默认值
    _listV.isUseDefaultEmpty = YES;
    _listV.isTextPositionTop = NO;
    _listV.emptyImage = [UIImage imageNamed:@"contri_head_xperson"];
    _listV.emptyTitleColor = [UIColor grayColor];
    _listV.emptyTitle = @"暂时没有任何数据哦~";
    
    [self.view addSubview:_listV];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _listNum;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellId"];
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}


-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    _listNum = (_listNum == 0) ? 10 : 0;
    [_listV reloadData];
}
@end
