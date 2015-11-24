//
//  Object.h
//  CustomTableViewEditor
//
//  Created by 高波 on 15/11/24.
//  Copyright © 2015年 高波. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Object : NSObject

@property (readonly) NSString *title;
@property (readonly) NSString *message;
@property (readonly) NSInteger messageType;
@property (nonatomic) BOOL isSelected;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
