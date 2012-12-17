//
//  TestViewController.h
//  PhotoHub
//
//  Created by Scott Mason on 12/14/12.
//  Copyright (c) 2012 Apex-net srl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SampleNavigationController.h"
#import "PhotoHubLib.h"

@interface TestViewController : UIViewController
{
    PhotoHubLib *myPhotoHubLib;
}

@property (strong, nonatomic) SampleNavigationController *headerViewController;
@property (strong, nonatomic) UIView *headerView;
@property (strong, nonatomic) UIBarButtonItem *backButton;

@property (nonatomic, strong) PhotoHubLib *myPhotoHubLib;

@end
