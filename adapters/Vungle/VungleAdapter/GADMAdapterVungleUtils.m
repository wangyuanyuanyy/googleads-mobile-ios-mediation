// Copyright 2019 Google LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

#import "GADMAdapterVungleUtils.h"
#import "GADMAdapterVungleConstants.h"

void GADMAdapterVungleMutableSetAddObject(NSMutableSet *_Nullable set, NSObject *_Nonnull object) {
  if (object) {
    [set addObject:object];  // Allow pattern.
  }
}

void GADMAdapterVungleMapTableSetObjectForKey(NSMapTable *_Nonnull mapTable,
                                              id<NSCopying> _Nullable key, id _Nullable value) {
  if (value && key) {
    [mapTable setObject:value forKey:key];  // Allow pattern.
  }
}

void GADMAdapterVungleMapTableRemoveObjectForKey(NSMapTable *_Nullable mapTable, id _Nullable key) {
  if (key) {
    [mapTable removeObjectForKey:key];  // Allow pattern.
  }
}

void GADMAdapterVungleMutableDictionarySetObjectForKey(NSMutableDictionary *_Nonnull dictionary,
                                                       id<NSCopying> _Nullable key,
                                                       id _Nullable value) {
  if (value && key) {
    dictionary[key] = value;  // Allow pattern.
  }
}

void GADMAdapterVungleUserDefaultsRemoveObjectForKey(NSUserDefaults *_Nonnull userDefaults,
                                                     id _Nullable key) {
  if (key) {
    [userDefaults removeObjectForKey:key];  // Allow pattern.
  }
}

void GADMAdapterVungleMutableDictionaryRemoveObjectForKey(NSMutableDictionary *_Nonnull dictionary,
                                                          id<NSCopying> _Nullable key) {
  if (key) {
    [dictionary removeObjectForKey:key];  // Allow pattern.
  }
}

NSError *_Nonnull GADMAdapterVungleErrorWithCodeAndDescription(GADMAdapterVungleErrorCode code,
                                                               NSString *_Nonnull description) {
  NSDictionary<NSString *, NSString *> *userInfo =
      @{NSLocalizedDescriptionKey : description, NSLocalizedFailureReasonErrorKey : description};
  NSError *error = [NSError errorWithDomain:kGADMAdapterVungleErrorDomain
                                       code:code
                                   userInfo:userInfo];
  return error;
}

VungleAdSize GADMAdapterVungleAdSizeForCGSize(CGSize adSize) {
  if (adSize.height == kGADAdSizeLeaderboard.size.height) {
    return VungleAdSizeBannerLeaderboard;
  }

  if (adSize.height != kGADAdSizeBanner.size.height) {
    return VungleAdSizeUnknown;
  }

  // Height is 50.
  if (adSize.width < kGADAdSizeBanner.size.width) {
    return VungleAdSizeBannerShort;
  }

  return VungleAdSizeBanner;
}

@implementation GADMAdapterVungleUtils

+ (nullable NSString *)findAppID:(nullable NSDictionary *)serverParameters {
  NSString *appId = serverParameters[kGADMAdapterVungleApplicationID];
  if (!appId) {
    NSString *const message = @"Vungle app ID should be specified!";
    NSLog(message);
    return nil;
  }
  return appId;
}

+ (nullable NSString *)findPlacement:(nullable NSDictionary *)serverParameters
                       networkExtras:(nullable VungleAdNetworkExtras *)networkExtras {
  NSString *ret = serverParameters[kGADMAdapterVunglePlacementID];
  if (networkExtras && networkExtras.playingPlacement) {
    if (ret) {
      NSLog(@"'placementID' had a value in both serverParameters and networkExtras. "
            @"Used one from serverParameters.");
    } else {
      ret = networkExtras.playingPlacement;
    }
  }

  return ret;
}

@end
