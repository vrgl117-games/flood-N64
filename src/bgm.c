/* bgm.c -- bgm helpers implementation
 *
 * Copyright (C) 2018 Victor Vieux
 *
 * This software may be modified and distributed under the terms
 * of the Apache license. See the LICENSE file for details.
 */

#include <stdlib.h>
#include <strings.h>

#include "bgm.h"
#include "dfs.h"

MIKMODAPI extern UWORD md_mode __attribute__((section(".data")));
MIKMODAPI extern UWORD md_mixfreq __attribute__((section(".data")));

// current bgm playing 0: not playing; 1,2,3,4:bgms
static int current_bgm;
static bool paused = false;
MODULE *module = NULL;

void bgm_init()
{
    audio_init(FREQUENCY_44KHZ, 4);
    MikMod_RegisterAllDrivers();
    MikMod_RegisterAllLoaders();

    md_mode |= DMODE_16BITS;
    md_mode |= DMODE_SOFT_MUSIC;
    md_mode |= DMODE_SOFT_SNDFX;
    md_mode |= DMODE_STEREO;

    md_mixfreq = audio_get_frequency();

    MikMod_Init("");

    current_bgm = 0;
}

void bgm_start()
{
    current_bgm = 1 + rand() % (NUM_BGMS - 1);
    char buffer[25];
    sprintf(buffer, "rom://sfx/bgms/bgm%d.mod", current_bgm);
    module = Player_Load(buffer, 256, 0);
    audio_write_silence();
    audio_write_silence();
    Player_Start(module);
    paused = false;
}

void bgm_stop()
{
    Player_Stop();
    Player_Free(module);
    audio_close();
}

int bgm_toggle(int change)
{
    if (change != 0)
    {
        // if a bgm is already playing, close it
        if (current_bgm != 0)
        {
            Player_Stop();
            Player_Free(module);
        }

        // change bgm
        current_bgm += change;

        // handle overflow
        if (current_bgm < 0)
            current_bgm = NUM_BGMS;
        else if (current_bgm > NUM_BGMS)
            current_bgm = 0;

        if (current_bgm != 0)
        {
            char buffer[24];
            sprintf(buffer, "rom://sfx/bgms/bgm%d.mod", current_bgm);
            module = Player_Load(buffer, 256, 0);
            audio_write_silence();
            Player_Start(module);
        }
    }
    return current_bgm;
}

void bgm_play_pause()
{
    paused = !paused;
}

void bgm_update()
{
    if (!paused && current_bgm != 0)
    {
        MikMod_Update();
    }
}
