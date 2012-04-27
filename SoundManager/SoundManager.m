//
//  SoundManager.m
//  SoundManager
//
//  Created by undancer on 12-2-20.
//  Copyright (c) 2012年 北京. All rights reserved.
//

#import "SoundManager.h"

BOOL playWithData(NSData* data){
    AVAudioPlayer* player = [[SoundManager defaultManager] playerWithData:data];
    if (player) {
        [SoundManager defaultManager].isPlaying = YES;
        return [player play];
    }
    return NO;
}

BOOL playWithUrl(NSURL* url){
    AVAudioPlayer* player = [[SoundManager defaultManager] playerWithUrl:url];
    if (player) {
        [SoundManager defaultManager].isPlaying = YES;
        return [player play];
    }
    return NO;
}

@implementation SoundManager

@synthesize isPlaying = _isPlaying;
@synthesize player = _player;
@synthesize recorder = _recorder;
@synthesize recordSettings = _recordSettings;

+(SoundManager *)defaultManager{
    static SoundManager* soundManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        soundManager = [[SoundManager alloc] init];
    });
    return soundManager;
}

-(void)clearPlayIfNeeded{
    if (self.isPlaying) {
        [self.player stop];
        [self.player release];
        self.isPlaying = NO;
    }
}

-(void)clearRecorderIfNeeded{
    if (self.recorder) {
        if ([self.recorder isRecording]) {
            [self.recorder stop];
        }
        self.recorder = nil;
    }
}

-(AVAudioPlayer *)playerWithData:(NSData *)data{
    [self clearPlayIfNeeded];
    NSError* error = nil;
    self.player = [[AVAudioPlayer alloc] initWithData:data error:&error];
    self.player.delegate = self;
    [self.player prepareToPlay];
    return self.player;
}

-(AVAudioPlayer *)playerWithUrl:(NSURL *)url{
    [self clearPlayIfNeeded];
    NSError* error = nil;
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    self.player.delegate = self;
    [self.player prepareToPlay];
    return self.player;
}

-(AVAudioRecorder *)recorderWithURL:(NSURL *)url{
    [self clearRecorderIfNeeded];
    NSDictionary* settings = self.recordSettings ? self.recordSettings : defaultSettings;
    NSError* error = nil;
    AVAudioRecorder* recorder = [[AVAudioRecorder alloc] initWithURL:url settings:settings error:&error];
    recorder.delegate = self;
    [recorder prepareToRecord];
    return recorder;
}

#pragma mark - delegate
-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
    self.isPlaying = NO;
    [player release];
}
-(void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag{
    [recorder release];
}

@end
