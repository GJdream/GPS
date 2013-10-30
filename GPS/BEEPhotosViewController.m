//
//  BEEPhotosViewController.m
//  GPS
//
//  Created by Mauricio Meirelles on 7/22/13.
//  Copyright (c) 2013 Beelieve. All rights reserved.
//

#import "BEEPhotosViewController.h"
#import "UIColor-Expanded.h"

@interface BEEPhotosViewController ()

@end

@implementation BEEPhotosViewController



- (void)viewDidLoad
{
//    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    photos = [[NSMutableArray alloc] init];
    
//    networkCaptions = [[NSArray alloc] initWithObjects:@"Happy New Year!",@"Frosty Web", @"",nil];
//    networkImages = [[NSArray alloc] initWithObjects:@"http://farm6.static.flickr.com/5042/5323996646_9c11e1b2f6_b.jpg", @"http://farm6.static.flickr.com/5007/5311573633_3cae940638.jpg", @"http://sphotos-g.ak.fbcdn.net/hphotos-ak-ash4/1012990_566218130084109_1360618124_n.jpg",nil];
    
    
    networkImages = [[NSMutableArray alloc] init];
    networkCaptions = [[NSMutableArray alloc] init];
    
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
    
//    _tableView.tableHeaderView = headView;

    
    _tableView.separatorColor = [UIColor whiteColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    
    UIView *footer = [[UIView alloc] initWithFrame:CGRectZero];
    [_tableView setTableFooterView:footer];
    
    tblCount = 0;
    
//    actv = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(320/2-50/2, self.view.frame.size.height/2-50/2, 50, 50)];
//    [actv setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhite];
//    [_tableView addSubview:actv];
//    [actv startAnimating];
    
    dicPhotos = [[NSMutableDictionary alloc] init];
    
    if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
        _tableView.frame = CGRectMake(0, imgTopo.frame.origin.y + imgTopo.frame.size.height - 20,320, 20 + self.view.frame.size.height - (imgTopo.frame.origin.y + imgTopo.frame.size.height));
    else
        _tableView.frame = CGRectMake(0, imgTopo.frame.origin.y + imgTopo.frame.size.height, 320, self.view.frame.size.height - (imgTopo.frame.origin.y + imgTopo.frame.size.height));
    
    
    actv = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(320/2-50/2, _tableView.frame.size.height/2-50/2 - 50, 50, 50)];
    [actv setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhite];
    [actv startAnimating];
    [_tableView addSubview:actv];
    
    
    [self loadData];
    
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
//        [self performSelectorOnMainThread:@selector(alertFecharComErro:) withObject:[NSNumber numberWithInt:error] waitUntilDone:NO];
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
    return tblCount;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    cell.backgroundColor = [UIColor clearColor];
    
    UILabel *lblText = (UILabel *) [cell viewWithTag:10];
    
	lblText.text = [dicPhotos.allKeys objectAtIndex:indexPath.row];
    
    return cell;
}


#pragma mark - FGalleryViewControllerDelegate Methods


- (int)numberOfPhotosForPhotoGallery:(FGalleryViewController *)gallery
{
    int num = 0;
    if( gallery == localGallery ) {
        num = [localImages count];
    }
    else if( gallery == networkGallery ) {
        num = [networkImages count]-1;
    }
	return num;
}


- (FGalleryPhotoSourceType)photoGallery:(FGalleryViewController *)gallery sourceTypeForPhotoAtIndex:(NSUInteger)index
{
	if( gallery == localGallery ) {
		return FGalleryPhotoSourceTypeLocal;
	}
	else return FGalleryPhotoSourceTypeNetwork;
}


- (NSString*)photoGallery:(FGalleryViewController *)gallery captionForPhotoAtIndex:(NSUInteger)index
{
    NSString *caption;
    if( gallery == localGallery ) {
        caption = [localCaptions objectAtIndex:index];
    }
    else if( gallery == networkGallery ) {
        caption = [networkCaptions objectAtIndex:index];
    }
	return caption;
}


- (NSString*)photoGallery:(FGalleryViewController*)gallery filePathForPhotoSize:(FGalleryPhotoSize)size atIndex:(NSUInteger)index {
    return [localImages objectAtIndex:index];
}

- (NSString*)photoGallery:(FGalleryViewController *)gallery urlForPhotoSize:(FGalleryPhotoSize)size atIndex:(NSUInteger)index {
    return [networkImages objectAtIndex:index];
}

- (void)handleTrashButtonTouch:(id)sender {
    // here we could remove images from our local array storage and tell the gallery to remove that image
    // ex:
    //[localGallery removeImageAtIndex:[localGallery currentIndex]];
}


- (void)handleEditCaptionButtonTouch:(id)sender {
    // here we could implement some code to change the caption for a stored image
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    [networkImages removeAllObjects];
    [networkCaptions removeAllObjects];
    
    for(BEEPhotos *photo in [dicPhotos objectForKey:[dicPhotos.allKeys objectAtIndex:indexPath.row]])
    {
        [networkImages addObject:photo.source];
        if(photo.name)
            [networkCaptions addObject:photo.name];
    }
    
    
    networkGallery = [[FGalleryViewController alloc] initWithPhotoSource:self];
    [self.navigationController pushViewController:networkGallery animated:YES];
    
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
