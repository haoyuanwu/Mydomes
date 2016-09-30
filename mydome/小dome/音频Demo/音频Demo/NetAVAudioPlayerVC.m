//
//  NetAVAudioPlayerVC.m
//  音频Demo
//
//  Created by ibokan on 12-4-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "NetAVAudioPlayerVC.h"
#import "LoadingPlayeVC.h"
#import "LoadingAndDocPlayerVC.h"
@implementation NetAVAudioPlayerVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}
    

#pragma mark - View lifecycle

-(void)dealloc{
    [dataArray release],dataArray = nil;
    [super dealloc];
}
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    UIView * aView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 460-49-44)];
    aView.backgroundColor = [UIColor orangeColor];
    self.view = aView;
    [aView release];
    
    dataArray = [[NSArray alloc] initWithObjects: @"边下载边播放",@"下载到本地播放", nil];
    
    UITableView * myTableview = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    myTableview.delegate = self;
    myTableview.dataSource = self;
    [self.view addSubview:myTableview];
    [myTableview release];
}


/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * reUse = @"123";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:reUse];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reUse];
    }
    cell.textLabel.text = [dataArray objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        //边下载边播放
        case 0:
        {
            LoadingPlayeVC * loadingVC = [[LoadingPlayeVC alloc] init];
            [self.navigationController pushViewController:loadingVC animated:YES];
        }
            break;
        //下载到本地播放
        case 1:
        {
            LoadingAndDocPlayerVC * loadingAndDocVC = [[LoadingAndDocPlayerVC alloc] init];
            [self.navigationController pushViewController:loadingAndDocVC animated:YES];
        }
            break;
        default:
            break;
    }
}

@end
