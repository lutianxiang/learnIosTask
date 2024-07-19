//
//  CustomCellCollectionViewCell.m
//  Demo04
//
//  Created by 卢天祥 on 2024/7/16.
//

#import "CustomCellCollectionViewCell.h"
#import <Masonry/Masonry.h>
#import <AFNetworking/UIImageView+AFNetworking.h>

@implementation CustomCellCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.cellImage = [[UIImageView alloc] init];
        [self addSubview:self.cellImage];
        [self.cellImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top);
            make.left.equalTo(self.mas_left);
            make.right.equalTo(self.mas_right);
            make.height.equalTo(self.mas_height).multipliedBy(0.8);
        }];
        self.cellImage.backgroundColor = [UIColor greenColor];
        
        self.cellTitle = [[UILabel alloc] init];
        [self addSubview:self.cellTitle];
        [self.cellTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.mas_bottom);
            make.left.equalTo(self.mas_left);
            make.right.equalTo(self.mas_right);
            make.height.equalTo(self.mas_height).multipliedBy(0.2);
        }];
        self.cellTitle.backgroundColor = [UIColor redColor];
    }
    return self;
}

- (void)setImageUrl:(nonnull NSString *)url text:(nonnull NSString *)text {
    [self.cellImage setImageWithURL:[NSURL URLWithString:url]];
    self.cellTitle.text = text;
}

- (void)prepareForReuse {
    [super prepareForReuse];
    [self.cellImage cancelImageDownloadTask];
    self.cellImage.image = nil;
    self.cellTitle.text = nil;
}

@end
