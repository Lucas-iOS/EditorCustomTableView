//
//  TableViewController.m
//  CustomTableViewEditor
//
//  Created by 高波 on 15/11/24.
//  Copyright © 2015年 高波. All rights reserved.
//

#import "TableViewController.h"
#import "TableViewCell.h"
#import "Object.h"

@interface TableViewController () <UIActionSheetDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *footerView;
@property (weak, nonatomic) IBOutlet UIButton *allButton;
@property (nonatomic, strong) NSArray *datas;
@property (nonatomic, strong) NSMutableArray *cells;
@property (nonatomic, strong) NSMutableArray *selectedCells;
@property (nonatomic) BOOL isSelected;
@property (nonatomic) BOOL isCheckAll;

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _footerView.alpha = 0;
    _cells = [NSMutableArray array];
    _selectedCells = [NSMutableArray array];
    
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    //假数据
    _datas = @[@{@"type":@1,@"title":@"送礼",@"message":@"送你1亿",@"time":@"今天就送"},
               @{@"type":@2,@"title":@"送礼",@"message":@"送你1亿",@"time":@"今天就送"},
               @{@"type":@3,@"title":@"送礼",@"message":@"送你1亿",@"time":@"今天就送"}];
    [_datas enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        Object *object = [[Object alloc] initWithDictionary:obj];
        [_cells addObject:object];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _cells.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    [cell setCellData:_cells[indexPath.row]];
    cell.tag = indexPath.row;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return UITableViewCellEditingStyleNone;
}

- (IBAction)editAddress:(UIBarButtonItem *)sender {
    [self.tableView setEditing:YES animated:YES];
}

//编辑模式
-(void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    [self.tableView setEditing:editing animated:animated];
    if (self.tableView.editing) {
        [UIView animateWithDuration:0.5 animations:^{
            _footerView.alpha = 1.0;
        }];
        for (TableViewCell *cell in self.tableView.visibleCells) {
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(checkCell:)];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell addGestureRecognizer:tapGesture];
        }
    } else {
        [UIView animateWithDuration:0.5 animations:^{
            _footerView.alpha = 0.0;
        }];
        for (TableViewCell *cell in self.tableView.visibleCells) {
            cell.selectionStyle = UITableViewCellSelectionStyleDefault;
            cell.gestureRecognizers = nil;
            _isCheckAll = NO;
        }
        for (Object *obj in _cells) {
            obj.isSelected = NO;
        }
        [self performSelector:@selector(EditEndRefresh) withObject:nil afterDelay:0.3f];
    }
}

- (void)EditEndRefresh {
    [self.tableView reloadData];
}

//单选
- (void)checkCell:(UITapGestureRecognizer *)tapGesture {
    TableViewCell *cell = (TableViewCell *)tapGesture.view;
    Object *obj = _cells[cell.tag];
    obj.isSelected = !obj.isSelected;
    [self.tableView reloadData];
}

//全选
- (IBAction)selectAll:(UIButton *)sender {
    [_selectedCells removeAllObjects];
    _isCheckAll = !_isCheckAll;
    for (Object *obj in _cells) {
        obj.isSelected = _isCheckAll;
    }
    [self.tableView reloadData];
}

- (IBAction)selectDelete:(UIButton *)sender {
    
    UIActionSheet *choiceSheet = [[UIActionSheet alloc] initWithTitle:@"是否删除消息"
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:@"确定"
                                                    otherButtonTitles:nil];
    [choiceSheet showInView:self.view];
    
}

#pragma mark UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        //根据isSelected删除
        [_cells enumerateObjectsUsingBlock:^(Object *obj, NSUInteger idx, BOOL *stop) {
            if (obj.isSelected == YES) {
                [_cells removeObjectAtIndex:idx];
            }
        }];
        [self.tableView reloadData];
    }
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
