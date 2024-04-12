//
//  GGViewModel.h
//  Beansmile
//
//  Created by John on 2018/4/25.
//

#import <Foundation/Foundation.h>

@interface GGViewModel : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *subTitle;
@property (nonatomic, strong) NSString *secondTitle;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *secondContent;
@property (nonatomic, strong) NSString *thirdContent;
@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, strong) NSString *secondImageUrl;
@property (nonatomic, strong) NSString *thirdImageUrl;
@property (nonatomic, strong) NSAttributedString *attributedContent;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) UIImage *secondImage;
@property (nonatomic, strong) NSArray *tags;

@property (nonatomic, strong) NSString *reuseIdentifier;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat secondHeight;
@property (nonatomic, assign) CGFloat itemWidth;
@property (nonatomic, assign) CGFloat itemHeight;

@property (nonatomic, assign) BOOL isOn;
@property (nonatomic, assign) BOOL hideLine;
@property (nonatomic, assign) BOOL isLock;
@property (nonatomic, assign) BOOL isOnSale;
@property (nonatomic, assign) BOOL isLive;
@property (nonatomic, assign) BOOL showAnimate;
@property (nonatomic, assign) BOOL hasReload;
@property (nonatomic, strong) id dataModel;

@property (nonatomic, assign) NSUInteger shareType;
@property (nonatomic, assign) NSUInteger messageCount;
@property (nonatomic, assign) NSUInteger listStyle;
@property (nonatomic, strong) NSIndexPath *indexPath;

@end
