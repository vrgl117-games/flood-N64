/* game.c -- game helpers implementation
 *
 * Copyright (C) 2018 Victor Vieux
 *
 * This software may be modified and distributed under the terms
 * of the Apache license. See the LICENSE file for details.
 */

#include <math.h>
#include <stdlib.h>
#include <string.h>

#include "bgm.h"
#include "debug.h"
#include "colors.h"
#include "dfs.h"
#include "game.h"
#include "rdp.h"

static game_t game = {0};
static uint32_t colors[8];

void game_init()
{
    // init colors
    colors[0] = COLOR_RED;
    colors[1] = COLOR_BLUE;
    colors[2] = COLOR_GREEN;
    colors[3] = COLOR_YELLOW;
    colors[4] = COLOR_ORANGE;
    colors[5] = COLOR_PURPLE;
    colors[6] = COLOR_CYAN;
    colors[7] = COLOR_PINK;

    game_reset();
}

void game_reset()
{
    bgm_play_pause();
    memset(game.cells, 0, sizeof(int) * 576);
    game.won = false;

    game.board_size = 12;

    // init start position
    for (int i = 0; i < game.board_size * game.board_size; i++)
    {
        game.cells[i] = rand() % 6;
    }

    game.turn = 1;
    game.max_turn = 21;
}

bool game_stop_rumble()
{
    // rumble already stopped
    if (game.rumble == 0)
        return false;

    game.rumble--;

    return (game.rumble == 0);
}
// return true if gameover
static inline bool is_gameover()
{
    return false;
}

static inline int fill(int pos, int old_color, int new_color)
{
    if (pos < game.board_size * game.board_size && game.cells[pos] == old_color)
    {
        int ret = 0;
        game.cells[pos] = new_color;
        ret += fill(pos + 1, old_color, new_color);
        ret += fill(pos + game.board_size, old_color, new_color);
        return ret;
    }
    return 0;
}

status_t game_play(control_t keys)
{
    status_t status = game_none;

    if (keys.direction == d_down)
    {
        game.selected_color++;
        if (game.selected_color == 3)
            game.selected_color = 0;
        if (game.selected_color == 6)
            game.selected_color = 3;
        return status;
    }
    if (keys.direction == d_up)
    {
        game.selected_color--;
        if (game.selected_color == -1)
            game.selected_color = 2;
        if (game.selected_color == 2)
            game.selected_color = 5;
        return status;
    }
    if (keys.direction == d_right || keys.direction == d_left)
    {
        game.selected_color = (game.selected_color + 3) % 6;
        return status;
    }
    else if (keys.A)
    {
        int filled = fill(0, game.cells[0], game.selected_color);
        debug_setf("FILLED %d", filled);
        if (filled == 0 && keys.rumble)
        {
            rumble_start(0);
            game.rumble = 4;
            return status;
        }
    }
    return status;
}

// return macx turn
int game_max_turn() { return game.max_turn; }

// return turn
int game_turn() { return game.turn; }

void game_draw(display_context_t disp, int grid_x, int grid_y)
{
    // draw left column
    for (int i = 0; i < 3; i++)
    {
        int x = 16;
        int y = (i + 1) * ((480 - (64 * 3)) / 4) + i * 64;
        if (i == game.selected_color)
            rdp_draw_filled_rectangle_with_border_size(x - 4, y - 4, 72, 72, COLOR_BG, COLOR_GRID_BG);

        rdp_draw_filled_rectangle_with_border_size(x, y, 64, 64, colors[i], COLOR_GRID_BG);
    }

    // draw right column
    for (int i = 0; i < 3; i++)
    {
        int x = 560;
        int y = (i + 1) * ((480 - (64 * 3)) / 4) + i * 64;
        if (i + 3 == game.selected_color)
            rdp_draw_filled_rectangle_with_border_size(x - 4, y - 4, 72, 72, COLOR_BG, COLOR_GRID_BG);

        rdp_draw_filled_rectangle_with_border_size(x, y, 64, 64, colors[i + 3], COLOR_GRID_BG);
    }

    //draw the board
    rdp_draw_filled_rectangle_size(grid_x, grid_y, 448, 448, COLOR_GRID_BG);
    for (int x = 0; x < game.board_size; x++)
    {
        for (int y = 0; y < game.board_size; y++)
        {
            int cell_size = 432 / game.board_size;
            int xx = grid_x + 8 + x * cell_size;
            int yy = grid_y + 8 + y * cell_size;

            rdp_draw_filled_rectangle_size(xx, yy, cell_size, cell_size, colors[game.cells[x + y * game.board_size]]);
        }
    }
}