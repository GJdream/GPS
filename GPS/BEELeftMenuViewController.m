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
    
    //    [self.view setBackgroundColor:[UIColor colorWithHexString:@"282828"]];
    
    //    UIImageView *headerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 84)];
    //    [headerView setImage:[UIImage imageNamed:@"arteHeader.png"]];
    //    self.tableView.tableHeaderView = headerView;
    
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
//    UIImageView *imgIcon = (UIImageView *)[cell viewWithTag:11];
//    
    
//    lblTitle.textColor = [UIColor colorWithHexString:@"fd7509"];
//    lblTitle.font = [UIFont fontWithName:@"HelveticaNeue" size:18];
//    
//    
    
    if(indexPath.row == 0)
    {
        lblTitle.text = @"Status da Obra";
//        [imgIcon setImage:[UIImage imageNamed:@"ic_inicio.png"]];
    }
    else if(indexPath.row == 1)
    {
        lblTitle.text = @"Ao Vivo";
        //        [imgIcon setImage:[UIImage imageNamed:@"ic_professores.png"]];
    }
    else if(indexPath.row == 2)
    {
        lblTitle.text = @"Fotos";
//        [imgIcon setImage:[UIImage imageNamed:@"ic_professores.png"]];
    }
    else if(indexPath.row == 3)
    {
        lblTitle.text = @"Mensagens";
        //        [imgIcon setImage:[UIImage imageNamed:@"ic_professores.png"]];
    }
    else if(indexPath.row == 4)
    {
        lblTitle.text = @"Check In";
        //        [imgIcon setImage:[UIImage imageNamed:@"ic_professores.png"]];
    }
    else if(indexPath.row == 5)
    {
        lblTitle.text = @"Créditos";
//        [imgIcon setImage:[UIImage imageNamed:@"ic_coordenacao.png"]];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
    
}

//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (cell.isSelected == YES)
//    {
//        //        [cell setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"barraMenuSelecionado.png"]]];
//        
//        UIImageView *imgArrow = (UIImageView *)[cell viewWithTag:12];
//        
//        [imgArrow setImage:[UIImage imageNamed:@"ic_arrow_feedback.png"]];
//    }
//    else
//    {
//        //        [cell setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"barraMenu.png"]]];
//        
//        UIImageView *imgArrow = (UIImageView *)[cell viewWithTag:12];
//        
//        [imgArrow setImage:[UIImage imageNamed:@"ic_arrow.png"]];
//    }
//}

//- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    //    NSIndexPath *currentSelectedIndexPath = [tableView indexPathForSelectedRow];
//    
//    for (int idx=0; idx<3; idx++) {
//        //        [[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:idx inSection:0]] setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"barraMenu.png"]]];
//        
//        UITableViewCell *cell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:idx inSection:0]];
//        
//        UIImageView *imgArrow = (UIImageView *)[cell viewWithTag:12];
//        
//        [imgArrow setImage:[UIImage imageNamed:@"ic_arrow.png"]];
//    }
//    
//    return indexPath;
//}

//-(void)changeToCapaMenu
//{
//    NSIndexPath *currentSelectedIndexPath = [_tableView indexPathForSelectedRow];
//    //    if (currentSelectedIndexPath != nil)
//    //    {
//    //        [[_tableView cellForRowAtIndexPath:currentSelectedIndexPath] setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"barraMenu.png"]]];
//    //    }
//
//    for (int idx=0; idx<4; idx++) {
//        [[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:idx inSection:0]] setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"barraMenu.png"]]];
//
//    }
//
//    currentSelectedIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
//
//    [[_tableView cellForRowAtIndexPath:currentSelectedIndexPath] setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"barraMenuSelecionado.png"]]];
//
//
//}


#pragma mark - UITableViewDelegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    //    [[tableView cellForRowAtIndexPath:indexPath] setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"barraMenuSelecionado.png"]]];
    
    UIImageView *imgArrow = (UIImageView *)[cell viewWithTag:12];
    
//    [imgArrow setImage:[UIImage imageNamed:@"ic_arrow_feedback.png"]];
    
    
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
