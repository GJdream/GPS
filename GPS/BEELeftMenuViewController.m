//
//  BEELeftMenuViewController.m
//  GPS
//
//  Created by Mauricio Meirelles on 8/1/13.
//  Copyright (c) 2013 Beelieve. All rights reserved.
//

#import "BEELeftMenuViewController.h"
#import "BEEManager.h"

@interface BEELeftMenuViewController ()

@end

@implementation BEELeftMenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.tableView.scrollsToTop = NO;

    NSIndexPath *topIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    
    [self.tableView selectRowAtIndexPath:topIndexPath animated:NO scrollPosition:UITableViewScrollPositionTop];
    
    [self.view setBackgroundColor:[UIColor colorWithHexString:@"C22825"]];
    
    _tableView.separatorColor = [UIColor whiteColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    
    UIView *footer = [[UIView alloc] initWithFrame:CGRectZero];
    [_tableView setTableFooterView:footer];
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
    {
        
        _tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);

    }
    
}


-(void)viewDidAppear:(BOOL)animated {
    self.tableView.scrollsToTop = YES;
    
}

-(void)viewDidDisappear:(BOOL)animated {
    self.tableView.scrollsToTop = NO;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource methods

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    cell.backgroundColor = [UIColor clearColor];
    	
    UILabel *lblTitle = (UILabel *)[cell viewWithTag:10];

    if(indexPath.row == 0)
    {
        lblTitle.text = @"Status da Obra";
    }
    else if(indexPath.row == 1)
    {
        lblTitle.text = @"Ao Vivo";
    }
    else if(indexPath.row == 2)
    {
        lblTitle.text = @"Fotos";
    }
    else if(indexPath.row == 3)
    {
        lblTitle.text = @"Mensagens";
    }
    else if(indexPath.row == 4)
    {
        lblTitle.text = @"Check In";
    }
    else if(indexPath.row == 5)
    {
        lblTitle.text = @"Créditos";
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
    
}



#pragma mark - UITableViewDelegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
//    UIImageView *imgArrow = (UIImageView *)[cell viewWithTag:12];
    
    UINavigationController *mainVC;
    
    
    if(indexPath.row == 0)
    {
        mainVC = [[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"statusVC"];
        
    }
    else if(indexPath.row == 1)
    {
        
        mainVC = [[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"aovivoVC"];
    }
    else if(indexPath.row == 2)
    {
        
        mainVC = [[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"fotosVC"];
        
    }
    else if(indexPath.row == 3)
    {
        
        mainVC = [[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"mensagensVC"];
        
    }
    else if(indexPath.row == 4)
    {
        
        mainVC = [[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"checkinVC"];
        
    }
    else if(indexPath.row == 5)
    {
        
        mainVC = [[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"aboutVC"];
        
    }
    
    self.viewDeckController.centerController = mainVC;
    
    
    self.viewDeckController.closeSlideAnimationDuration = 0.15;
    
    [self.viewDeckController closeLeftViewAnimated:YES completion:^(IIViewDeckController *controller, BOOL success) {
        self.viewDeckController.closeSlideAnimationDuration = 0.2;
    }];
    
}


- (void)viewDidUnload {
    [self setTableView:nil];
    [super viewDidUnload];
}

@end
