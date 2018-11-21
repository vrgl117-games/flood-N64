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

    // 4 12 -> 14
    // 4 18 -> 21
    // 4 24 -> 28
    // 6 12 -> 21
    // 6 18 -> 31
    // 6 24 -> 42
    // 8 12 -> 28
    // 8 18 -> 42
    // 8 24 -> 56

    game.board_size = 12;
    game.num_colors = 4;
    game.turn = 1;

    if (game.num_colors == 4 && game.board_size == 12)
        game.max_turn = 140;
    else if (game.num_colors == 4 && game.board_size == 18)
        game.max_turn = 21;
    else if (game.num_colors == 4 && game.board_size == 24)
        game.max_turn = 28;
    else if (game.num_colors == 6 && game.board_size == 12)
        game.max_turn = 21;
    else if (game.num_colors == 6 && game.board_size == 18)
        game.max_turn = 31;
    else if (game.num_colors == 6 && game.board_size == 24)
        game.max_turn = 42;
    else if (game.num_colors == 8 && game.board_size == 12)
        game.max_turn = 28;
    else if (game.num_colors == 8 && game.board_size == 18)
        game.max_turn = 42;
    else if (game.num_colors == 8 && game.board_size == 24)
        game.max_turn = 56;

    // init start position
    for (int i = 0; i < game.board_size * game.board_size; i++)
        game.cells[i] = rand() % game.num_colors;
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

// fills the board with new_color, return 1 if there are more colors
static inline int fill(int pos, int old_color, int new_color)
{
    if (pos >= game.board_size * game.board_size || pos < 0)
        return 0;

    if (game.cells[pos] != old_color)
        return game.cells[pos] != new_color;

    int filled = 0;
    game.cells[pos] = new_color;
    if ((pos + 1) % game.board_size != game.board_size)
        filled += fill(pos + 1, old_color, new_color); // RIGHT
    if ((pos) % game.board_size != 0)
        filled += fill(pos - 1, old_color, new_color); // LEFT

    filled += fill(pos + game.board_size, old_color, new_color); // DOWN
    filled += fill(pos - game.board_size, old_color, new_color); // UP

    return filled;
}

status_t game_play(control_t keys)
{
    if (keys.direction == d_down)
    {
        game.selected_color++;
        if (game.selected_color == game.num_colors / 2)
            game.selected_color = 0;
        if (game.selected_color == game.num_colors)
            game.selected_color = game.num_colors / 2;
        return game_none;
    }
    if (keys.direction == d_up)
    {
        game.selected_color--;
        if (game.selected_color == -1)
            game.selected_color = game.num_colors / 2 - 1;
        if (game.selected_color == game.num_colors / 2 - 1)
            game.selected_color = game.num_colors - 1;
        return game_none;
    }
    if (keys.direction == d_right || keys.direction == d_left)
    {
        game.selected_color = (game.selected_color + game.num_colors / 2) % game.num_colors;
        return game_none;
    }
    else if (keys.A)
    {
        // selected the same color
        if (game.cells[0] == game.selected_color)
        {
            if (keys.rumble)
            {
                rumble_start(0);
                game.rumble = 4;
            }
            return game_none;
        }

        if (fill(0, game.cells[0], game.selected_color))
        {
            game.turn++;
            if (game.turn > game.max_turn)
                return game_over;
        }
        else
            return game_win;
    }
    return game_none;
}

// return max turn
int game_max_turn() { return game.max_turn; }

// return turn
int game_turn() { return game.turn; }

void game_draw(display_context_t disp, int grid_x, int grid_y)
{
    // draw left column
    for (int i = 0; i < game.num_colors / 2; i++)
    {
        int x = 16;
        int y = (i + 1) * ((480 - (64 * game.num_colors / 2)) / (game.num_colors / 2 + 1)) + i * 64;
        if (i == game.selected_color)
            rdp_draw_filled_rectangle_with_sized_border_size(x - 8, y - 8, 80, 80, 4, COLOR_BG, COLOR_GRID_BG);

        rdp_draw_filled_rectangle_with_border_size(x, y, 64, 64, colors[i], COLOR_GRID_BG);
    }

    // draw right column
    for (int i = 0; i < game.num_colors / 2; i++)
    {
        int x = 560;
        int y = (i + 1) * ((480 - (64 * game.num_colors / 2)) / (game.num_colors / 2 + 1)) + i * 64;
        if (i + game.num_colors / 2 == game.selected_color)
            rdp_draw_filled_rectangle_with_sized_border_size(x - 8, y - 8, 80, 80, 4, COLOR_BG, COLOR_GRID_BG);

        rdp_draw_filled_rectangle_with_border_size(x, y, 64, 64, colors[i + game.num_colors / 2], COLOR_GRID_BG);
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