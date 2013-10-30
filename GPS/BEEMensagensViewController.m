//
//  BEEMensagensViewController.m
//  GPS
//
//  Created by Mauricio Meirelles on 7/22/13.
//  Copyright (c) 2013 Beelieve. All rights reserved.
//

#import "BEEMensagensViewController.h"
#import "UIColor-Expanded.h"

@interface BEEMensagensViewController ()

@end

@implementation BEEMensagensViewController

-(void)reloadAllData
{
    
    [self loadData];
}



- (void)viewDidLoad
{
//    [super viewDidLoad];

    
    self.navigationController.navigationBar.tintColor = [UIColor colorWithHexString:@"C22825"];
    
    [self.view setBackgroundColor:[UIColor colorWithHexString:@"C22825"]];
    [_tableView setBackgroundColor:[UIColor clearColor]];

//    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 100)];
    UIImageView *imgTopo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"topo.png"]];
    imgTopo.frame = CGRectMake(0, 0, 320, 108.5);
    [self.view addSubview:imgTopo];

//    UIImageView *imgLogo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo_inter.png"]];
//    imgLogo.frame = CGRectMake(2, 2, 60, 60);
//    [imgTopo addSubview:imgLogo];
    
    UIButton *btComunidade = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 320, 100)];
    [btComunidade addTarget:self action:@selector(openMenu) forControlEvents:UIControlEventTouchUpInside];
    btComunidade.backgroundColor = [UIColor clearColor];
    [self.view addSubview:btComunidade];
    
    
    _tableView.separatorColor = [UIColor whiteColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
//    _tableView.tableHeaderView = headView;
    
    UIView *footer = [[UIView alloc] initWithFrame:CGRectZero];
    [_tableView setTableFooterView:footer];
    

    actv = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(320/2-50/2, self.view.frame.size.height/2-50/2, 50, 50)];
    [actv setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhite];
    [_tableView addSubview:actv];
    
//    msgArray = [[NSMutableArray alloc] init];
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reloadAllData)
                                                 name:UIApplicationDidBecomeActiveNotification
                                               object:nil];
    
    
    if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
        _tableView.frame = CGRectMake(0, imgTopo.frame.origin.y + imgTopo.frame.size.height - 20,320, 20 + self.view.frame.size.height - (imgTopo.frame.origin.y + imgTopo.frame.size.height));
    else
        _tableView.frame = CGRectMake(0, imgTopo.frame.origin.y + imgTopo.frame.size.height, 320, self.view.frame.size.height - (imgTopo.frame.origin.y + imgTopo.frame.size.height));
    
    
    
    [self loadData];
    
}

-(void)openMenu
{
    [self.viewDeckController openLeftViewAnimated:YES];
}


- (void)loadData {

    
    // Load from prefs
    NSUserDefaults *currentDefaults = [NSUserDefaults standardUserDefaults];
        
    NSData *dataRepresentingSavedArray = [currentDefaults objectForKey:@"gpsMensagens"];
    if (dataRepresentingSavedArray != nil) {
        NSArray *oldSavedDict = [NSKeyedUnarchiver unarchiveObjectWithData:dataRepresentingSavedArray];
        if (oldSavedDict != nil)
        {
            msgArray  = [[NSMutableArray alloc] initWithArray:oldSavedDict];
            [_tableView reloadData];
        }
        else
        {
            msgArray  = [[NSMutableArray alloc] init];
            [actv startAnimating];   
        }
    }
        
    [[BEEManager singleton] ListaMensagens:^(NSMutableArray *mensagens) {
        msgArray = mensagens;
        
        [self performSelectorOnMainThread:@selector(atualizaDados) withObject:nil waitUntilDone:NO];
        
        
    } erro:^(int error) {
        [actv performSelectorOnMainThread:@selector(stopAnimating) withObject:nil waitUntilDone:NO];
//        [self performSelectorOnMainThread:@selector(alertFecharComErro:) withObject:[NSNumber numberWithInt:error] waitUntilDone:NO];
    }];

}

- (void)atualizaDados
{

    [actv stopAnimating];
    [_tableView reloadData];

    
}


// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return msgArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    BEEMensagens *objMsg = [msgArray objectAtIndex:indexPath.row];
    
    UILabel *lblAux = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 280, CGFLOAT_MAX)];
    lblAux.font = [UIFont boldSystemFontOfSize:20];
    lblAux.text = objMsg.msg;
    lblAux.numberOfLines = 0;
    [lblAux sizeToFit];
 
    return lblAux.frame.size.height + 24.0 + 31;
    
    
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];

    cell.backgroundColor = [UIColor clearColor];
    
    BEEMensagens *objMsg = [msgArray objectAtIndex:indexPath.row];
    
    UILabel *lblText = (UILabel *) [cell viewWithTag:11];
    [lblText setFrame:CGRectMake(0, 0,280, 1000)];
	lblText.text = objMsg.msg;
    lblText.numberOfLines = 0;
    [lblText sizeToFit];
//    [lblText setBackgroundColor:[UIColor greenColor]];
    lblText.frame = CGRectMake(20,12, 280, lblText.frame.size.height);
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy HH:mm"];
    NSString *strDate = [dateFormatter stringFromDate:objMsg.data];
    
    UILabel *lblData = (UILabel *) [cell viewWithTag:12];
    lblData.text = strDate;
    lblData.frame = CGRectMake(lblData.frame.origin.x,lblText.frame.origin.y + lblText.frame.size.height + 20, lblData.frame.size.width , lblData.frame.size.height);

    
    return cell;
}


#pragma mark - FGalleryViewControllerDelegate Methods



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
