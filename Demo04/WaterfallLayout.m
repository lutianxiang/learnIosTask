//
//  WaterfallLayout.m
//  Demo04
//
//  Created by 卢天祥 on 2024/7/16.
//

#import "WaterfallLayout.h"
#import "ViewController.h"

@interface WaterfallLayout ()

@property (nonatomic,strong) ViewController *dataSource;
@property (nonatomic)CGFloat leftHeight;
@property (nonatomic)CGFloat rightHeight;
@property (nonatomic,strong) NSMutableArray<UICollectionViewLayoutAttributes *> *attributes;
@property (nonatomic)CGFloat contentHeight;

- (double)computeLayoutHeight:(NSIndexPath *)indexPath;

@end

@implementation WaterfallLayout

- (instancetype)initWithDataSource:(ViewController *)source
{
    self = [super init];
    if (self) {
        self.dataSource = source;
        self.scrollDirection = UICollectionViewScrollDirectionVertical;
        self.minimumLineSpacing = 5.0;
        self.minimumInteritemSpacing = 5.0;
        self.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
        self.leftHeight = self.sectionInset.top;
        self.rightHeight = self.sectionInset.top;
        self.attributes = [NSMutableArray new];
    }
    return self;
}

- (void)prepareLayout {
    [super prepareLayout];
    int count = 0;
    for (int section = 0; section < [self.collectionView numberOfSections]; section++) {
        for (int item = 0; item < [self.collectionView numberOfItemsInSection:section]; item++) {
            if (count < self.attributes.count) {
                count ++;
                continue;
            }
            count ++;
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:item inSection:section];
            UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
            [self.attributes addObject:attributes];
        }
    }
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    return self.attributes;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    double screenWidth = UIScreen.mainScreen.bounds.size.width / 2.0 - 10;
    double layoutHeight = [self computeLayoutHeight:indexPath];
    double x,y;
    
    if (self.leftHeight <= self.rightHeight) {
        x = self.sectionInset.left;
        y = self.leftHeight + self.minimumInteritemSpacing;
        self.leftHeight = y + layoutHeight;
        if (self.contentHeight < self.leftHeight) {
            self.contentHeight = self.leftHeight + self.sectionInset.bottom;
        }
    } else {
        x = self.sectionInset.left + screenWidth + self.minimumLineSpacing;
        y = self.rightHeight + self.minimumInteritemSpacing;
        self.rightHeight = y + layoutHeight;
        if (self.contentHeight < self.rightHeight) {
            self.contentHeight = self.rightHeight + self.sectionInset.bottom;
        }
    }
    attributes.frame = CGRectMake(x, y, screenWidth, layoutHeight);
    return attributes;
}

- (CGSize)collectionViewContentSize {
    double width = self.collectionView.bounds.size.width;
    return CGSizeMake(width, self.contentHeight);
}

- (double)computeLayoutHeight:(NSIndexPath *)indexPath {
    double picHeight = [self.dataSource.heights[indexPath.section * self.dataSource.itemsPerSec + indexPath.row] doubleValue];
    double picWidth = [self.dataSource.widths[indexPath.section * self.dataSource.itemsPerSec + indexPath.row] doubleValue];
    double screenWidth = UIScreen.mainScreen.bounds.size.width / 2.0 - 10;
    double layoutHeight = picHeight * screenWidth / picWidth;
    return layoutHeight;
}

@end
