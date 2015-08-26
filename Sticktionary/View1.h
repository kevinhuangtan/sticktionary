//
//  View1.h
//  Sticktionary
//
//  Created by Kevin Tan on 8/25/15.
//  Copyright (c) 2015 Sticktionary. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface View1 : UIViewController <UITableViewDataSource, UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITextField *inputText;
@property (strong, nonatomic) UITableView *autocompleteTableView;
@property (strong, nonatomic) NSMutableArray *pastUrls;
@property (strong, nonatomic) NSMutableArray *autocompleteUrls;

@end

