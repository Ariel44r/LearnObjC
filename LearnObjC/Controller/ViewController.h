//
//  ViewController.h
//  LearnObjC
//
//  Created by ARIEL DIAZ on 12/9/18.
//  Copyright © 2018 ARIEL DIAZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

