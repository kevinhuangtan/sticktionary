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

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    if (section == 0)
//        return 6;
//    else
//        return 3;
    return [self.autocompleteUrls count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"myCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if([self.autocompleteUrls count] > 0){
        cell.textLabel.text = [self.autocompleteUrls objectAtIndex:indexPath.row];
    }
    
    return cell;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.pastUrls = [[NSMutableArray alloc] init];

    NSString *path = [[NSBundle mainBundle] pathForResource:@"keys" ofType:@"txt"];
    NSString *content = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSArray *items = [content componentsSeparatedByString:@"\n"];
    
    for (int i = 0; i < [items count]; i++) {
        [self.pastUrls addObject:items[i]];
    }

    self.autocompleteUrls = [[NSMutableArray alloc] init];

    self.autocompleteTableView = [[UITableView alloc] initWithFrame:
                             CGRectMake(0, 100, 330, 250) style:UITableViewStylePlain];
    self.autocompleteTableView.delegate = self;
    self.autocompleteTableView.dataSource = self;
    self.autocompleteTableView.scrollEnabled = YES;
    self.autocompleteTableView.hidden = YES;
    [self.inputText addTarget:self
                  action:@selector(textFieldDidChange)
        forControlEvents:UIControlEventEditingChanged];
    self.inputText.autocorrectionType = UITextAutocorrectionTypeNo;
    [self.view addSubview:self.autocompleteTableView];


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


- (void) textFieldDidChange{

    int length = [self.inputText.text length];

    if(length > 0){
        self.autocompleteTableView.hidden = NO;
    }
    else{
        self.autocompleteTableView.hidden = YES;

    }
    
    NSString *substring = [NSString stringWithString:self.inputText.text];

    [self searchAutocompleteEntriesWithSubstring:substring];
    
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


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    self.inputText.text = selectedCell.textLabel.text;
    
    [self goPressed];
    
}

- (IBAction)goPressed {


    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSArray *history = [defaults objectForKey:@"history"];
    
    if(history){
        if([history containsObject:self.inputText.text]){
//            do nothing
        }
        else{
            history = [history arrayByAddingObject:self.inputText.text];
            NSLog(@"%@", history);
            [defaults setObject:history forKey:@"history"];
        }

    }
    else{
        NSArray *newHistory = @[self.inputText.text];
        [defaults setObject:newHistory forKey:@"history"];
    }

    [defaults synchronize];
    
    [self performSegueWithIdentifier:@"showResultView" sender:self];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//- (IBAction)submit:(id)sender {
//    
//    
//        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    
//        NSArray *history = [defaults objectForKey:@"history"];
//        history = [history arrayByAddingObject:self.inputText.text];
//    
//        [defaults setObject:history forKey:@"history"];
//    
//        [defaults synchronize];
//    
//
//    [self performSegueWithIdentifier:@"showResultView" sender:self];
//}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showResultView"]) {
        
        // Get destination view
        View2 *vc = [segue destinationViewController];
        vc.wordKey = self.inputText.text;
        self.inputText.text = @"";
        self.autocompleteTableView.hidden = YES;

    }
}


@end
