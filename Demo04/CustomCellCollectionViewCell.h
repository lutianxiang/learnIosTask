//
//  CustomCellCollectionViewCell.h
//  Demo04
//
//  Created by 卢天祥 on 2024/7/16.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomCellCollectionViewCell : UICollectionViewCell

@property (nonatomic,strong) UIImageView *cellImage;
@property (nonatomic,strong) UILabel *cellTitle;

- (void)setImageUrl:(NSString *)url text:(NSString *)text;

@end

NS_ASSUME_NONNULL_END
