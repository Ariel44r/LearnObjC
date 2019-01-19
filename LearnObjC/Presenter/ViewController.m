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
    UIRefreshControl* refreshControl = [[UIRefreshControl alloc] init];
    [self.tableView addSubview:refreshControl];
    [refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    [self refresh:refreshControl];
    
}

- (void)refresh:(UIRefreshControl*)refresh{
    [refresh endRefreshing];
    WebService* ws = [[WebService alloc] initWithEndPoint:@"https://sproapi-staging.vapor.cloud/JWT_ConsultaEstructura" method:HTTPMethodPOST parameters:[NSDictionary new] headers:[NSDictionary new] name:nil];
    [[APIController new] post2APIWithWS:ws completion:^(SocioProTreeResponse *socioProResponse){
        NSLog(@"%@", socioProResponse.cabResponse.mensResponse);
        
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
