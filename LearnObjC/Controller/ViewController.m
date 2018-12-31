//
//  ViewController.m
//  LearnObjC
//
//  Created by ARIEL DIAZ on 12/9/18.
//  Copyright © 2018 ARIEL DIAZ. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.currentOffset = CGPointMake(0, 0);
    self.navigationItem.largeTitleDisplayMode = UINavigationItemLargeTitleDisplayModeAlways;
    self.title = @"title";
    
}

#pragma mark - UITableViewProtocols
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 50;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [[UITableViewCell alloc] init];
    cell.backgroundColor = (indexPath.row%2 == 0 ? UIColor.lightGrayColor : UIColor.whiteColor);
    return cell;
    
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@"(%f, %f)", scrollView.contentOffset.x, scrollView.contentOffset.y);
    
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    if(self.currentOffset.y < scrollView.contentOffset.y){
        NSLog(@"UP");
//        [self.navigationController setNavigationBarHidden:YES animated:YES];
//        self.navigationController.navigationBar.prefersLargeTitles = NO;
        [self.navigationController.navigationBar setPrefersLargeTitles:NO];

    } else {
        NSLog(@"DOWN");
//        [self.navigationController setNavigationBarHidden:NO animated:YES];
//        self.navigationController.navigationBar.prefersLargeTitles = YES;
        [self.navigationController.navigationBar setPrefersLargeTitles:YES];
        
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    self.currentOffset = scrollView.contentOffset;

}

@end
