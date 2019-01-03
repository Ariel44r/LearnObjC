//
//  ViewController.m
//  LearnObjC
//
//  Created by ARIEL DIAZ on 12/9/18.
//  Copyright © 2018 ARIEL DIAZ. All rights reserved.
//

#import "ViewController.h"
#import "LearnObjC-Swift.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"title";
    
    APIManager* apiManager = [[APIManager alloc] init];
    [apiManager getSocioProTreeWithParameters:[NSDictionary new] completion:^(SocioProTreeResponse* socioProResponse){
        NSLog(@"%@", socioProResponse);
        
    }];
}

#pragma mark - UITableViewProtocols
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 50;
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [[UITableViewCell alloc] init];
    cell.backgroundColor = (indexPath.row%2 == 0 ? [UIColor.lightGrayColor colorWithAlphaComponent:0.3] : UIColor.whiteColor);
    return cell;
    
}

@end
