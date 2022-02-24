//
//  GADPangleRTBInterstitialRenderer.h
//  PangleAdapter
//
//  Created by bytedance on 2022/1/11.
//

#import <Foundation/Foundation.h>
#import <GoogleMobileAds/GoogleMobileAds.h>

NS_ASSUME_NONNULL_BEGIN

@interface GADPangleRTBInterstitialRenderer : NSObject<GADMediationInterstitialAd>

/// Asks the receiver to render the ad configuration.
- (void)renderInterstitialForAdConfiguration:
            (nonnull GADMediationInterstitialAdConfiguration *)adConfiguration
                         completionHandler:(nonnull GADMediationInterstitialLoadCompletionHandler)completionHandler;

@end

NS_ASSUME_NONNULL_END
