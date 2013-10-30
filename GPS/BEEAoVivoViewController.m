//
//  BEEAoVivoViewController.m
//  GPS
//
//  Created by Mauricio Meirelles on 7/22/13.
//  Copyright (c) 2013 Beelieve. All rights reserved.
//

#import "BEEAoVivoViewController.h"
#import "UIColor-Expanded.h"
#import "BEELiveVideoViewController.h"

@interface BEEAoVivoViewController ()

@end

@implementation BEEAoVivoViewController



- (void)viewDidLoad
{

    photos = [[NSMutableArray alloc] init];
    
    networkImages = [[NSMutableArray alloc] init];
    
    
    if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
    {
        self.navigationController.navigationBar.barTintColor = [UIColor redColor];
        self.navigationController.navigationBar.tintColor = [UIColor whiteColor];

    }
    else
    {
        self.navigationController.navigationBar.tintColor = [UIColor colorWithHexString:@"A70014"];
    }

    
    [self.view setBackgroundColor:[UIColor colorWithHexString:@"C22825"]];
    [_tableView setBackgroundColor:[UIColor clearColor]];

    UIImageView *imgTopo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"topo.png"]];
    imgTopo.frame = CGRectMake(0, 0, 320,108.5);
    [self.view addSubview:imgTopo];

    
    UIButton *btComunidade = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 320, 100)];
    [btComunidade addTarget:self action:@selector(openMenu) forControlEvents:UIControlEventTouchUpInside];
    btComunidade.backgroundColor = [UIColor clearColor];
    [self.view addSubview:btComunidade];
    
    
    _tableView.separatorColor = [UIColor whiteColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    
    UIView *footer = [[UIView alloc] initWithFrame:CGRectZero];
    [_tableView setTableFooterView:footer];
    
    if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
        _tableView.frame = CGRectMake(0, imgTopo.frame.origin.y + imgTopo.frame.size.height - 20,320, 20 + self.view.frame.size.height - (imgTopo.frame.origin.y + imgTopo.frame.size.height));
    else
        _tableView.frame = CGRectMake(0, imgTopo.frame.origin.y + imgTopo.frame.size.height, 320, self.view.frame.size.height - (imgTopo.frame.origin.y + imgTopo.frame.size.height));
    
    
}

-(void)openMenu
{
    [self.viewDeckController openLeftViewAnimated:YES];
}


- (void)loadData {
    
    [[BEEManager singleton] ListaPhotos:^(NSMutableDictionary *dados) {
        dicPhotos = dados;
    
        
        
        [self performSelectorOnMainThread:@selector(atualizaDados) withObject:nil waitUntilDone:NO];
        
        
    } erro:^(int error) {

    }];
}

- (void)atualizaDados
{

    
    tblCount = dicPhotos.allKeys.count;
    [actv stopAnimating];
    [_tableView reloadData];

    
}


// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    cell.backgroundColor = [UIColor clearColor];

    UILabel *lblText = (UILabel *) [cell viewWithTag:10];
    
//	lblText.text = [dicPhotos.allKeys objectAtIndex:indexPath.row];
    
    if(indexPath.row == 0)
        lblText.text = @"GPS1: Casa do Cléo Hickmann";
    else if(indexPath.row == 1)
        lblText.text = @"VEJAAOVIVO1: Av. Padre Cacique";
    
    
    return cell;
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    BEELiveVideoViewController *bel = (BEELiveVideoViewController *)segue.destinationViewController;
    
    bel.strUrl = sender;
    
    
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *strAux = @"";
        
    if(indexPath.row == 0)
    {
        strAux = @"http://xbeirariogpsx.api.channel.livestream.com/3.0/playlist.m3u8";
    }
    else if(indexPath.row == 1)
    {
        strAux = @"http://rtmp.0be3.upx.net.br:1935/0be3_551/0be3_551.stream/playlist.m3u8";
                   
    }

    
    [self performSegueWithIdentifier:@"gotoLive" sender:strAux];
        
}


- (void) viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}

- (void) viewWillDisappear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
}


- (BOOL)shouldAutorotate {
    return NO;
}

- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if (interfaceOrientation == UIInterfaceOrientationPortrait) {    // Or whatever orientation it will be presented in.
        return YES;
    }
    return NO;
}


@end
