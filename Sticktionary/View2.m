//
//  View2.m
//  Sticktionary
//
//  Created by Kevin Tan on 8/25/15.
//  Copyright (c) 2015 Sticktionary. All rights reserved.
//

#import "View2.h"
#import "Character.h"
#import "MeasureWord.h"

@interface View2 ()
@end

@implementation View2

- (void)viewDidLoad {
    [super viewDidLoad];
    [[self.pronounce  layer] setBorderWidth:.5f];
    [[self.pronounce  layer] setBorderColor:[UIColor blackColor].CGColor];
    
    self.pronounce.layer.cornerRadius = 10; // this value vary as per your desire
    self.pronounce.clipsToBounds = YES;
}
- (IBAction)back:(id)sender {

    [self dismissViewControllerAnimated:YES completion:nil];
    
}



- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.Result.text = self.wordKey;
    PFQuery *query = [PFQuery queryWithClassName:@"Words"];
    [query whereKey:@"english" equalTo:self.wordKey];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            NSLog(@"%@", objects[0]);
            
            
        
            
//            add rest of words
            NSMutableArray *chinese = [NSMutableArray array];
            NSString *str = objects[0][@"chinese"];
            for (int i = 0; i < [str length]; i++) {
                NSString *ch = [str substringWithRange:NSMakeRange(i, 1)];
                [chinese addObject:ch];
            }
            
            NSArray *pinyin = [objects[0][@"pinyin"] componentsSeparatedByCharactersInSet:
                              [NSCharacterSet characterSetWithCharactersInString:@" "]];
            CGFloat width = [UIScreen mainScreen].bounds.size.width;
            CGFloat height = [UIScreen mainScreen].bounds.size.height;

            int offset = (width - [chinese count] * 45)/2;
            int box_size = 50;

            
            for(int i = 0; i < [chinese count]; i++){
                CGRect frame;
                frame.origin.x = box_size * i + offset + 25;
                frame.origin.y = 60;
                frame.size = CGSizeMake(box_size, 80);
            
                Character *character = [[Character alloc]initWithFrame:frame];
                character.chineseChar = chinese[i];
                character.pinyinChar = pinyin[i];
                [character addLabels];

                [self.view addSubview:character];
            }
            
            //            add measure word
            NSString *measure_pin = [NSString stringWithFormat:@"%@%@%@", @"(", objects[0][@"measure_eng"], @")"];
            NSString *measure_chi =[NSString stringWithFormat:@"%@%@%@", @"(", objects[0][@"measure_chi"], @")"];
            
            CGRect frame;
            frame.origin.x = offset - 25;
            frame.origin.y = 60;
            frame.size = CGSizeMake(60, 80);
            MeasureWord *character = [[MeasureWord alloc]initWithFrame:frame];
            character.chineseChar = measure_chi;
            character.pinyinChar = measure_pin;
            [character addLabels];
            
            [self.view addSubview:character];
            
    
            self.wordKey = [self.wordKey stringByReplacingOccurrencesOfString:@" "
                                                 withString:@"-"];
            
            int img_offset = (width - 250)/2;
            UIImageView *dot =[[UIImageView alloc] initWithFrame:CGRectMake(img_offset,150,250,250)];
            dot.image=[UIImage imageNamed:[NSString stringWithFormat:@"%@%@", self.wordKey, @".png"]];
            dot.contentMode   = UIViewContentModeScaleAspectFit;
            [self.view addSubview:dot];
            
            


        }
        else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
}

- (IBAction)playSound:(id)sender {
    
    NSLog(@"audio");
    
    // Load in a audio file from your bundle (all the files you have added to your app)
    NSString *audioFile = [[NSBundle mainBundle] pathForResource:self.wordKey ofType:@"mp3"];
    
    // Convert string to NSURL
    NSURL *audioURL = [NSURL fileURLWithPath:audioFile];
    
    // Initialize a audio player with the URL (the mp3)
    self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:audioURL error:nil];
    
    
    
    // Start playing
    [self.audioPlayer play];
    
}

- (IBAction)goToCamera:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
