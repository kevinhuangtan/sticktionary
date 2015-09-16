//
//  View2.h
//  Sticktionary
//
//  Created by Kevin Tan on 8/25/15.
//  Copyright (c) 2015 Sticktionary. All rights reserved.
//
#import <Parse/Parse.h>
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface View2 : UIViewController

@property (strong, nonatomic) NSString *wordKey;
@property (strong, nonatomic) NSString *imgKey;
@property (weak, nonatomic) IBOutlet UILabel *Result;
@property (weak, nonatomic) IBOutlet UILabel *chinese;
@property (weak, nonatomic) IBOutlet UILabel *pinyin;
@property (weak, nonatomic) IBOutlet UIButton *pronounce;

@property (strong, nonatomic) AVAudioPlayer *audioPlayer;
@property (weak, nonatomic) IBOutlet UIImageView *imageObject;

@end
