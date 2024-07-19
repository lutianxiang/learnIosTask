//
//  WaterfallLayout.h
//  Demo04
//
//  Created by 卢天祥 on 2024/7/16.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface WaterfallLayout : UICollectionViewFlowLayout

- (instancetype)initWithDataSource:(ViewController *)source;

@end

NS_ASSUME_NONNULL_END
