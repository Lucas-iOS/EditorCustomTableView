//
//  TableViewCell.m
//  CustomTableViewEditor
//
//  Created by 高波 on 15/11/24.
//  Copyright © 2015年 高波. All rights reserved.
//

#import "TableViewCell.h"

@implementation TableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCellData:(Object *)obj
{
    switch (obj.messageType) {
        case 1:
            _imageViewType.image = [UIImage imageNamed:@"active"];
            break;
        case 2:
            _imageViewType.image = [UIImage imageNamed:@"order"];
            break;
        case 3:
            _imageViewType.image = [UIImage imageNamed:@"system"];
            break;
    }
    
    _imageViewStatus.image = obj.isSelected ? [UIImage imageNamed:@"ic_checkbox_pressed"] : [UIImage imageNamed:@"ic_checkbox_normal"];
    _titleLabel.text = obj.title;
    _messageLabel.text = obj.message;
}


@end
