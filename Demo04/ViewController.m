//
//  ViewController.m
//  Demo04
//
//  Created by 卢天祥 on 2024/7/16.
//

#import "ViewController.h"
#import "CustomCellCollectionViewCell.h"
#import "AFNetworking/AFNetworking.h"
#import "WaterfallLayout.h"
#import "BannerViewController.h"

@interface ViewController () <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic) bool colding;
@property (nonatomic, strong) BannerViewController *banner;

- (void)getDataFromApi:(int)times;
- (void)updateWaterFall;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.itemsPerSec = 10;
    WaterfallLayout *waterfallLayout = [[WaterfallLayout alloc] initWithDataSource:self];
    self.colding = false;
    
    self.banner = [[BannerViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    [self.view addSubview:self.banner.view];
    [self.banner.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom).multipliedBy(0.2);
        make.height.equalTo(self.view.mas_height).multipliedBy(0.2);
    }];
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:waterfallLayout];
    [self.view addSubview:collectionView];
    [collectionView registerClass:[CustomCellCollectionViewCell class] forCellWithReuseIdentifier:@"CustomCell"];
    collectionView.backgroundColor = [UIColor blackColor];
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
        make.height.equalTo(self.view.mas_height).multipliedBy(0.8);
    }];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    self.collectionView = collectionView;
    self.picNames = [NSMutableArray new];
    self.picUrls = [NSMutableArray new];
    self.widths = [NSMutableArray new];
    self.heights = [NSMutableArray new];
    self.sections = 0;

    self.screenWidth = UIScreen.mainScreen.bounds.size.width / 2.0 - 10;
    [self getDataFromApi:self.itemsPerSec];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.itemsPerSec;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.sections;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CustomCellCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CustomCell" forIndexPath:indexPath];
    [cell setImageUrl:[self.picUrls objectAtIndex:(self.itemsPerSec * indexPath.section + indexPath.row)] text:[self.picNames objectAtIndex:(self.itemsPerSec * indexPath.section + indexPath.row)]];
    return cell;
}

- (void)updateWaterFall {
    [self.collectionView reloadData];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y + scrollView.frame.size.height - scrollView.contentSize.height + 10 > 0) {
        if (self.colding) {
            return;
        }
        [self getDataFromApi:self.itemsPerSec];
    }
}

- (void)getDataFromApi:(int)times{
    __weak ViewController *weakSelf = self;
    weakSelf.colding = true;
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:3 repeats:NO block:^(NSTimer * _Nonnull timer) {
        if (weakSelf) {
            weakSelf.colding = false;
        }
    }];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    NSString *apiUrl = @"https://api.thecatapi.com/v1/images/search?size=full";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    __block int items = 0;
    for (int i = 0;i < times;i ++) {
        [manager GET:apiUrl
          parameters:nil
             headers:nil
            progress:nil
             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSArray *arr = [responseObject allObjects];
            NSDictionary *dic = arr[0];
            [self.picNames addObject:dic[@"id"]];
            [self.picUrls addObject:dic[@"url"]];
            [self.widths addObject:dic[@"width"]];
            [self.heights addObject:dic[@"height"]];
            items += 1;
            if (items == self.itemsPerSec) {
                self.sections += 1;
                [self updateWaterFall];
            }
            }
             failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"Error: %@", error.localizedDescription);
        }];
    }
}

@end
