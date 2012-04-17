//
//  SoundManager.h
//  SoundManager
//
//  Created by undancer on 12-2-20.
//  Copyright (c) 2012年 北京. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

BOOL playWithData(NSData* data);

@interface SoundManager : NSObject<AVAudioPlayerDelegate>

@property (nonatomic, retain) AVAudioPlayer* player;
@property (nonatomic, retain) AVAudioRecorder* recorder;

+(SoundManager*)defaultManager;

-(void)clearPlayIfNeeded;

-(AVAudioPlayer *)playerWithData:(NSData*)data;

@end
