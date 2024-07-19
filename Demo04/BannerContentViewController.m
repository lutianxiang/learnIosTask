//
//  BannerContentViewController.m
//  Demo04
//
//  Created by 卢天祥 on 2024/7/19.
//

#import "BannerContentViewController.h"
#import <AFNetworking/UIKit+AFNetworking.h>
#import <Masonry/Masonry.h>

@interface BannerContentViewController ()

@property(nonatomic, strong) UIImageView *imageView;
- (void)getMyImage;

@end

@implementation BannerContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor greenColor];
    self.imageView = [UIImageView new];
    [self.view addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
        make.height.equalTo(self.view.mas_height);
    }];
    [self getMyImage];
}

- (void)getMyImage {
    NSString *apiUrl = @"https://api.thedogapi.com/v1/images/search?size=full";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager GET:apiUrl
      parameters:nil
         headers:nil
        progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *arr = [responseObject allObjects];
        NSDictionary *dic = arr[0];
        NSString *imageUrl = dic[@"url"];
        [self.imageView setImageWithURL:[NSURL URLWithString:imageUrl]];
        }
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Error: %@", error.localizedDescription);
    }];
}

@end
