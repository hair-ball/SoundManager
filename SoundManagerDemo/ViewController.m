//
//  ViewController.m
//  SoundManagerDemo
//
//  Created by undancer on 12-4-27.
//  Copyright (c) 2012年 北京. All rights reserved.
//

#import "ViewController.h"
#import "SoundManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad{
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}
#pragma mark -
-(void)playWithData:(id)sender{
    NSData* data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"News_Flash" ofType:@"caf"]];
    playWithData(data);
}
-(void)playWithUrl:(id)sender{
    NSURL* url =[NSURL URLWithString:@"News_Flash.caf" relativeToURL:[[NSBundle mainBundle] resourceURL]];
    playWithUrl(url);
}

@end
