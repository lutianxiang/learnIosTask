//
//  BannerViewController.m
//  Demo04
//
//  Created by 卢天祥 on 2024/7/19.
//

#import "BannerViewController.h"
#import "BannerContentViewController.h"
#import <Masonry/Masonry.h>

@interface BannerViewController () <UIPageViewControllerDelegate,UIPageViewControllerDataSource>

@property (nonatomic, strong) NSMutableArray<UIViewController *> *pages;
@property (nonatomic, strong) UIPageControl *pageControl;

@end

@implementation BannerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.pages = [NSMutableArray new];
    [self.pages addObject:[BannerContentViewController new]];
    [self.pages addObject:[BannerContentViewController new]];
    [self.pages addObject:[BannerContentViewController new]];
    BannerContentViewController *content = [BannerContentViewController new];
    content.view.backgroundColor = [UIColor blackColor];
    [self.pages addObject:content];
    
    self.dataSource = self;
    self.delegate = self;
    
    [self setViewControllers:@[self.pages[0]] direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:nil];
    self.pageControl = [[UIPageControl alloc] init];
    self.pageControl.numberOfPages = self.pages.count;
    self.pageControl.currentPage = 0;
    [self.view addSubview:self.pageControl];
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
        make.height.equalTo(self.view.mas_height).multipliedBy(0.2);
    }];
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    if (completed) {
        NSUInteger currentPage = [self.pages indexOfObject:[self.viewControllers lastObject]];
        self.pageControl.currentPage = currentPage;
    }
}

- (nullable UIViewController *)pageViewController:(nonnull UIPageViewController *)pageViewController viewControllerBeforeViewController:(nonnull UIViewController *)viewController {
    NSUInteger index = [self.pages indexOfObject:viewController];
    if (index == NSNotFound) {
        NSLog(@"notfound");
        return nil;
    } else if (index == 0) {
        return self.pages[self.pages.count - 1];
    }
    return self.pages[index - 1];
}

- (nullable UIViewController *)pageViewController:(nonnull UIPageViewController *)pageViewController viewControllerAfterViewController:(nonnull UIViewController *)viewController { 
    NSUInteger index = [self.pages indexOfObject:viewController];
    if (index == NSNotFound) {
        return nil;
    } else if (index == self.pages.count - 1) {
        return self.pages[0];
    }
    return self.pages[index + 1];
}


@end
