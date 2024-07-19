//
//  ViewController.h
//  Demo04
//
//  Created by 卢天祥 on 2024/7/16.
//

#import <UIKit/UIKit.h>
#import <AFNetworking/AFNetworking.h>
#import <Masonry/Masonry.h>

@interface ViewController : UIViewController 

@property (nonatomic, strong) NSMutableArray *picNames;
@property (nonatomic, strong) NSMutableArray *picUrls;
@property (nonatomic, strong) NSMutableArray *heights;
@property (nonatomic, strong) NSMutableArray *widths;
@property (nonatomic) int sections;
@property (nonatomic) int itemsPerSec;
@property (nonatomic) double screenWidth;

@end

