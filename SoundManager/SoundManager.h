//
//  SoundManager.h
//  SoundManager
//
//  Created by undancer on 12-2-20.
//  Copyright (c) 2012年 北京. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

#define defaultSettings [NSDictionary dictionaryWithObjectsAndKeys:\
                            [NSNumber numberWithFloat:4000.0],AVSampleRateKey,\
                            [NSNumber numberWithInt:kAudioFormatLinearPCM],AVFormatIDKey,\
                            [NSNumber numberWithInt:1],AVNumberOfChannelsKey,\
                            [NSNumber numberWithInt:AVAudioQualityMin],AVEncoderAudioQualityKey,\
                            [NSNumber numberWithInt:16],AVLinearPCMBitDepthKey,\
                            [NSNumber numberWithBool:NO],AVLinearPCMIsBigEndianKey,\
                            [NSNumber numberWithBool:NO],AVLinearPCMIsFloatKey,\
                        nil];

BOOL playWithData(NSData* data);

@interface SoundManager : NSObject<AVAudioPlayerDelegate,AVAudioRecorderDelegate>

@property (nonatomic, retain) AVAudioPlayer* player;
@property (nonatomic, retain) AVAudioRecorder* recorder;
@property (nonatomic, retain) NSDictionary* recordSettings;

+(SoundManager*)defaultManager;

-(void)clearPlayIfNeeded;
-(void)clearRecorderIfNeeded;

-(AVAudioPlayer *)playerWithData:(NSData*)data;
-(AVAudioRecorder *)recorderWithURL:(NSURL*)url;

@end
