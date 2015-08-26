//
//  Character.h
//  Sticktionary
//
//  Created by Kevin Tan on 8/25/15.
//  Copyright (c) 2015 Sticktionary. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Character : UIView
@property (strong, nonatomic) NSString *chineseChar;
@property (strong, nonatomic) NSString *pinyinChar;


@property (strong, nonatomic) IBOutlet UILabel *chineseCharLabel;
@property (strong, nonatomic) IBOutlet UILabel *pinyinCharLabel;
- (id)addLabels;

@end
