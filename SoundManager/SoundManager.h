//
//  SoundManager.h
//  SoundManager
//
//  Created by 涛 魏 on 12-2-20.
//  Copyright (c) 2012年 北京. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface SoundManager : NSObject<AVAudioPlayerDelegate>

@property (nonatomic, retain) AVAudioPlayer* player;

+(BOOL)playWithString:(NSString *)file;
+(BOOL)playWithData:(NSData *)data;

+(SoundManager*)defaultManager;

-(void)clearPlayIfNeeded;

@end
