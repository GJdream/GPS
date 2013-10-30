//
//  BEEVouOptionViewController.m
//  GPS
//
//  Created by Mauricio Meirelles on 9/24/13.
//  Copyright (c) 2013 Beelieve. All rights reserved.
//

#import "BEEVouOptionViewController.h"
#import "UIColor-Expanded.h"

@interface BEEVouOptionViewController ()

@end

@implementation BEEVouOptionViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor colorWithHexString:@"C22825"]];

    UIView *footer = [[UIView alloc] initWithFrame:CGRectZero];
    [self.tableView setTableFooterView:footer];
    
    
    if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
        self.tableView.contentInset = UIEdgeInsetsMake(25.0, 0, 0, 0);
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [BEEManager singleton].optionsArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    BEEVouNaoVouOption *opt = (BEEVouNaoVouOption *)[[BEEManager singleton].optionsArray objectAtIndex:indexPath.row];
    
    UILabel *lblAux = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 280, CGFLOAT_MAX)];
    lblAux.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:17];
    lblAux.text = opt.name;
    lblAux.numberOfLines = 0;
    [lblAux sizeToFit];
    
    return lblAux.frame.size.height + 24.0 ;
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    
    UILabel *lblText = (UILabel *)[cell viewWithTag:10];
    [lblText setFrame:CGRectMake(0, 0,280, 1000)];

    
    BEEVouNaoVouOption *opt = (BEEVouNaoVouOption *)[[BEEManager singleton].optionsArray objectAtIndex:indexPath.row];
    
    lblText.text = opt.name;
    
    if(opt.selected)
    {
        [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
    }
    else
    {
        [cell setAccessoryType:UITableViewCellAccessoryNone];
    }
    
    lblText.numberOfLines = 0;
    [lblText sizeToFit];
    //    [lblText setBackgroundColor:[UIColor greenColor]];
    lblText.frame = CGRectMake(20,12, 280, lblText.frame.size.height);
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    for(BEEVouNaoVouOption *optAux in [BEEManager singleton].optionsArray)
    {
        optAux.selected = NO;
    }
    
    BEEVouNaoVouOption *optAux2 = [[BEEManager singleton].optionsArray objectAtIndex:indexPath.row];
    optAux2.selected = YES;
    
    [self dismissModalViewControllerAnimated:YES];
}


@end
