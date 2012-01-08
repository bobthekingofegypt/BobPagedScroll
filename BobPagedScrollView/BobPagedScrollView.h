//
//  BobPagedScrollView.h
//  BobPagedScrollView
//
//  Copyright (c) 2011 Richard Martin. All rights reserved.
//  Licensed under the terms of the BSD License, see LICENSE.txt
//

#import <UIKit/UIKit.h>

@class BobPage, BobPagedScrollView;

/** The datasource of a Bob paged scroll view must adopt the BobPagedScrollViewDatasource protocol. 
 */
@protocol BobPagedScrollViewDatasource<NSObject>

/**
 Asks the datasource to return the number of pages.
 @return numberOfPages The number of pages in the Bob paged scroll view.
 */
-(NSUInteger) numberOfPages;

/** 
 Asks the datasource to return the page for the given index in the Bob paged scroll view.
 @param bobPagedScrollView An object representing the Bob paged scroll view requesting this information.
 @param index The index path of the required BobPage.
 @return BobPage The entry view for this index.
 */
-(BobPage *) bobPagedScrollView:(BobPagedScrollView *)bobPagedScrollView pageForIndex:(NSUInteger)index;

@end

/** The delegate of a Bob paged scroll view must adopt the BobPagedScrollViewDelegate protocol. 
 */
@protocol BobPagedScrollViewDelegate<NSObject>

/** 
 Tells the delegate that the bob paged scroll view has settled on a page
 @param bobPagedScrollView An object representing the Bob paged scroll view reporting this information.
 @param page The index of the page settled on.
 */
-(void) bobPagedScrollView:(BobPagedScrollView *)bobPagedScrollView settledOnPage:(NSUInteger) page;

@end

/** This is a base class for all Bob paged scroll views.  It is a subclass of
 UIView so makes available all functionality of UIViews. 
 */
@interface BobPagedScrollView : UIView<UIScrollViewDelegate> {
	UIScrollView *pagedScrollView;
    
	id<BobPagedScrollViewDatasource> datasource_;
    id<BobPagedScrollViewDelegate> delegate_;
	
    NSUInteger padding_;
	CGRect originalFrame;
	
	NSUInteger firstShowingPageIndex;
	NSUInteger lastShowingPageIndex;
	
	NSMutableDictionary *reusablePages;
	NSMutableDictionary *visiblePages;
	
	NSUInteger currentIndex;
    NSUInteger numberOfPages;
    
    BOOL settingFrame;
}

/**---------------------------------------------------------------------------------------
 * @name Configuring the paged scroll view
 *  ---------------------------------------------------------------------------------------
 */

/** read only property for access to the underlying scroll view to allow setting off bounce and scrollbars etc */
@property (nonatomic, readonly) UIScrollView *pagedScrollView;

/** The padding to be shown between pages */
@property (nonatomic, assign) NSUInteger padding;

/** Returns a reusable bob page object with the given identifier 
 @param identifier The reuse identifier used to identify the page type 
 @return page a reusable bob page object 
 */
-(BobPage *) dequeueReusablePageWithIdentifier:(NSString *)identifier;

/**---------------------------------------------------------------------------------------
 * @name Managing the delegate and the datasource
 *  ---------------------------------------------------------------------------------------
 */

/** The datasource for this paged scroll view */
@property (nonatomic, assign) id<BobPagedScrollViewDatasource> datasource;

/** The delegate for this paged scroll view */
@property (nonatomic, assign) id<BobPagedScrollViewDelegate> delegate;

/**---------------------------------------------------------------------------------------
 * @name Positioning the paged scroll view
 *  ---------------------------------------------------------------------------------------
 */

/** Scrolls the paged scroll view to a specified page 
 @param page The index of the page to scroll to
 @param animated Wether to animate the scroll
 */
-(void) scrollToPage:(NSUInteger)page animated:(BOOL)animated;

/**---------------------------------------------------------------------------------------
 * @name Reload the paged scroll view data
 *  ---------------------------------------------------------------------------------------
 */

/** Reloads the paged scroll view from the datasource */
-(void) reloadData;

@end


