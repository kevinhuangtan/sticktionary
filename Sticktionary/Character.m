//
//  Character.m
//  Sticktionary
//
//  Created by Kevin Tan on 8/25/15.
//  Copyright (c) 2015 Sticktionary. All rights reserved.
//

#import "Character.h"

@implementation Character

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];

    return self;
}

-(id)addLabels
{
    UILabel *chineseLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 50)];
    
    [chineseLabel setTextColor:[UIColor blackColor]];
    [chineseLabel setFont:[UIFont fontWithName: @"Trebuchet MS" size: 40.0f]];
    chineseLabel.text = self.chineseChar;
    [self addSubview:chineseLabel];

//    [chineseLabel setCenter:self.center];
    [chineseLabel setTextAlignment:UITextAlignmentCenter];
    
    UILabel *pinyinLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 37, 60, 50)];
    
    [pinyinLabel setTextColor:[UIColor blackColor]];
    [pinyinLabel setFont:[UIFont fontWithName: @"Trebuchet MS" size: 15.0f]];
    pinyinLabel.text = self.pinyinChar;
//    [pinyinLabel setCenter:self.center];
    [pinyinLabel setTextAlignment:UITextAlignmentCenter];
    [self addSubview:pinyinLabel];
    
    return self;

}


@end

