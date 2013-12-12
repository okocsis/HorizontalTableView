//
//  NextViewController.m
//  HorizontalTableView
//
//  Created by DING FENG on 13-12-11.
//

#import "NextViewController.h"
#import"UITableView+horizontal.h"
#import "ThirdViewController.h"

@interface NextViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *tableList;

}

@end
@implementation NextViewController
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
    self.title=@"Sections";
    
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0))
    {
        self.edgesForExtendedLayout= UIRectEdgeNone ;
    }
    else
    {
        
    }

    tableList = [[UITableView alloc] initWithFrame:CGRectMake(0, 100, 320, 90)direction:@"horizontal"];
    [self.view addSubview:tableList];
    tableList.delegate =self;
    tableList.dataSource =self;
	tableList.showsVerticalScrollIndicator	 = NO;
	tableList.showsHorizontalScrollIndicator = NO;
    tableList.separatorColor = [UIColor clearColor];
    
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(10, 30, 40, 40)];
    lable.text =[NSString stringWithFormat:@"fff"];
    lable.textAlignment =  NSTextAlignmentCenter;
    lable.font = [UIFont boldSystemFontOfSize:12];
    [self.view addSubview: lable];

    
    
    
    UIBarButtonItem *btn = [[UIBarButtonItem alloc] initWithTitle:@"next" style:UIBarButtonItemStylePlain target:self action:@selector(nextViewController)];
    self.navigationItem.rightBarButtonItem = btn;

    
    
}
-(void)nextViewController
{
    ThirdViewController *v = [[ThirdViewController alloc] init];
    [self.navigationController pushViewController:v   animated:NO];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *str = [NSString stringWithFormat:@"cell%d",indexPath.row];
    static NSString *CellIdentifier;
    CellIdentifier=str;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
        CGRect frame =cell.frame;
        frame.size.height=150;
        [cell setFrame:frame];
        UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(50, 30, 40, 40)];

        lable.text =[NSString stringWithFormat:@"%d",indexPath.row];
        lable.textAlignment =  NSTextAlignmentCenter;
        lable.font = [UIFont boldSystemFontOfSize:12];
        [cell.contentView addSubview: lable];
        [cell rotateCoordinat];
    }
    /*随机颜色*/
    static BOOL seeded = NO;
    if (!seeded) {
        seeded = YES;
        (time(NULL));
    }
    CGFloat red   = (CGFloat)random() / (CGFloat)RAND_MAX;
    CGFloat green = (CGFloat)random() / (CGFloat)RAND_MAX;
    CGFloat blue  = (CGFloat)random() / (CGFloat)RAND_MAX;
    cell.contentView.layer.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0f].CGColor;
    /*-------*/
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  150;
}
-(void)viewWillAppear:(BOOL)animated
{
    [tableList reloadData];
    NSIndexPath * ndxPath= [NSIndexPath indexPathForRow:7 inSection:3];
    [tableList scrollToRowAtIndexPath:ndxPath atScrollPosition:UITableViewScrollPositionTop  animated:YES];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 10;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *hview;
    hview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 20)];
    hview.backgroundColor = [UIColor grayColor];
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.backgroundColor =[UIColor blackColor];
    nameLabel.textColor =[UIColor whiteColor];
    
    nameLabel.text = [NSString stringWithFormat:@" HEAD   %d",section];
    nameLabel.frame = CGRectMake(0, 0, 100, 20);
    [hview addSubview:nameLabel];
    return hview;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}
@end
