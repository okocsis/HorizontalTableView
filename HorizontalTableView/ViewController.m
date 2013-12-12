//
//  ViewController.m
//  HorizontalTableView
//
//  Created by DING FENG on 13-12-10.
//

#import "ViewController.h"
#import"UITableView+horizontal.h"
#import "NextViewController.h"



@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

{
    UITableView *tableList;
    UIPageControl *_pageControl;
}


@end
@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"Pages";
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0))
    {
        self.edgesForExtendedLayout= UIRectEdgeNone ;
    }
    else
    {
    }
    tableList = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height-20-44)direction:@"horizontal"];
    [self.view addSubview:tableList];
    tableList.delegate =self;
    tableList.dataSource =self;
	tableList.showsVerticalScrollIndicator	 = NO;
	tableList.showsHorizontalScrollIndicator = NO;
    tableList.pagingEnabled = YES;
    
    UIBarButtonItem *btn = [[UIBarButtonItem alloc] initWithTitle:@"next" style:UIBarButtonItemStylePlain target:self action:@selector(nextViewController)];
    self.navigationItem.rightBarButtonItem = btn;
    
    CGRect rect = self.view.bounds;
    rect.origin.y = self.view.frame.size.height-20-44-30;
    rect.size.height = 30;
    _pageControl = [[UIPageControl alloc] initWithFrame:rect];
    _pageControl.userInteractionEnabled = NO;
    [self.view addSubview:_pageControl];

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;              // Default is 1 if not implemented
{
    return 1;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    _pageControl.numberOfPages = 10;
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
        frame.size.height=320;
        [cell setFrame:frame];
        UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        CGPoint p = tableView.center;
        lable.center =p ;
        lable.text =[NSString stringWithFormat:@"%d ",indexPath.row];
        lable.textAlignment =  NSTextAlignmentCenter;
        lable.font = [UIFont boldSystemFontOfSize:120];
        [cell.contentView addSubview: lable];
        [cell rotateCoordinat];
    }
    cell.contentView.layer.borderColor = [UIColor whiteColor].CGColor;
    cell.contentView.layer.borderWidth = 2;
    cell.contentView.layer.cornerRadius = 15;
    
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
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  320;
}


-(void)nextViewController
{
    NextViewController *v = [[NextViewController alloc] init];
    [self.navigationController pushViewController:v   animated:NO];
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"ddddd%f",tableList.contentOffset.y);
    NSInteger pageIndex=tableList.contentOffset.y/self.view.frame.size.width;
    _pageControl.currentPage = pageIndex;
}






@end
