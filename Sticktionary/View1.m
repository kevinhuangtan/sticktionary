//
//  View1.m
//  Sticktionary
//
//  Created by Kevin Tan on 8/25/15.
//  Copyright (c) 2015 Sticktionary. All rights reserved.
//

#import "View1.h"
#import "View2.h"
#import "HTAutocompleteTextField.h"

@interface View1 ()

@end

@implementation View1

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.pastUrls = [[NSMutableArray alloc] init];
//
//    self.autocompleteUrls = [[NSMutableArray alloc] init];
//    
//    self.autocompleteTableView = [[UITableView alloc] initWithFrame:
//                             CGRectMake(0, 80, 320, 120) style:UITableViewStylePlain];
//    self.autocompleteTableView.delegate = self;
//    self.autocompleteTableView.dataSource = self;
//    self.autocompleteTableView.scrollEnabled = YES;
//    self.autocompleteTableView.hidden = YES;
//    [self.view addSubview:self.autocompleteTableView];

    
    
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    
//    [defaults setObject:firstName forKey:@"firstName"];
//
//    [defaults synchronize];
    
    NSLog(@"Data saved");
    
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.view endEditing:YES];
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [[event allTouches] anyObject];
    
    if (![[touch view] isKindOfClass:[UITextField class]]) {
        [self.view endEditing:YES];
    }
    [super touchesBegan:touches withEvent:event];
}

- (BOOL)textField:(UITextField *)textField
shouldChangeCharactersInRange:(NSRange)range
replacementString:(NSString *)string {
    self.autocompleteTableView.hidden = NO;
    
    NSString *substring = [NSString stringWithString:textField.text];
    substring = [substring
                 stringByReplacingCharactersInRange:range withString:string];
    [self searchAutocompleteEntriesWithSubstring:substring];
    return YES;
}

- (void)searchAutocompleteEntriesWithSubstring:(NSString *)substring {
    
    // Put anything that starts with this substring into the autocompleteUrls array
    // The items in this array is what will show up in the table view
    [self.autocompleteUrls removeAllObjects];
    for(NSString *curString in self.pastUrls) {
        NSRange substringRange = [curString rangeOfString:substring];
        if (substringRange.location == 0) {
            [self.autocompleteUrls addObject:curString];
        }
    }
    [self.autocompleteTableView reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)submit:(id)sender {

    [self performSegueWithIdentifier:@"showResultView" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showResultView"]) {
        
        // Get destination view
        View2 *vc = [segue destinationViewController];
        NSLog(@"%@", self.inputText.text);
        vc.wordKey = self.inputText.text;
    }
}


@end
