//
//  TableViewCell.h
//  CustomTableViewEditor
//
//  Created by 高波 on 15/11/24.
//  Copyright © 2015年 高波. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Object.h"

@interface TableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageViewType;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewStatus;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

- (void)setCellData:(Object *)obj;

@end
