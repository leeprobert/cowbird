//
//  DetailViewController.h
//  cowbird
//
//  Created by Lee Probert on 14/05/2014.
//  Copyright (c) 2014 cowbird. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
