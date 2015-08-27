//
//  View3.m
//  
//
//  Created by Kevin Tan on 8/26/15.
//
//

#import "View3.h"

@interface View3 ()

@end

@implementation View3

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *history = [defaults objectForKey:@"history"];
    
    int image_size = 200;
    int x_offset = (width - 200)/2;
    int margin_offset = 10;
    
    
    self.scrollView = [UIScrollView alloc];
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 50, width, 500)];
    int content_height = [history count] * (image_size + margin_offset);
    [self.scrollView setContentSize:CGSizeMake(320, content_height)];
    [self.scrollView setScrollEnabled:YES];


    for(int i = 0; i < [history count]; i++){
        NSLog(@"alloc");
 
        int y_offset = (i * image_size) + (margin_offset * i) + 40;
        
        UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(x_offset, y_offset, image_size, image_size)];
        iv.image=[UIImage imageNamed:[NSString stringWithFormat:@"%@%@", history[i], @".png"]];

        [self.scrollView addSubview:iv];
    }
    [self.view addSubview:self.scrollView];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
  
    
}


@end
