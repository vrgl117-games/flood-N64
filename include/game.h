/* game.h -- game header
 *
 * Copyright (C) 2018 Victor Vieux
 *
 * This software may be modified and distributed under the terms
 * of the Apache license. See the LICENSE file for details.
 */

#ifndef __GAME_H__
#define __GAME_H__

#include <libdragon.h>

#include "controls.h"

typedef struct game
{
    int cells[576]; //24*24
    int board_size;
    int num_colors;

    int selected_color;

    uint16_t turn;
    uint16_t max_turn;

    bool won;

    uint8_t rumble;
} game_t;

typedef enum status
{
    game_none,
    game_over,
    game_win
} status_t;

int game_max_turn();
void game_init();
status_t game_play(control_t keys);
void game_draw(display_context_t disp, int grid_x, int grid_y);
int game_turn();
void game_reset();
bool game_stop_rumble();

#endif //__GAME_H__