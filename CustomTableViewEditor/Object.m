//
//  Object.m
//  CustomTableViewEditor
//
//  Created by 高波 on 15/11/24.
//  Copyright © 2015年 高波. All rights reserved.
//

#import "Object.h"

@implementation Object

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init]) {
        _isSelected = NO;
        _title = dictionary[@"title"];
        _message = dictionary[@"message"];
        _messageType = [dictionary[@"type"] integerValue];
    }
    return self;
}

@end
