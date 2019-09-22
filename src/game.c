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

extern uint32_t colors[];

static game_t game = {0};
// current size  0: 12x12, 1: 18x18, 2: 24x24
static int current_size = 1;
// current num colors  0: 4, 1: 6, 2:8
static int current_num_colors = 1;

void game_init()
{
}

void game_reset()
{
    bgm_play_pause();
    memset(game.cells, 8, sizeof(int) * 576);
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

    switch (current_size)
    {
    case 0:
        game.board_size = 12;
        break;
    case 2:
        game.board_size = 24;
        break;
    default:
        game.board_size = 18;
    }
    switch (current_num_colors)
    {
    case 0:
        game.num_colors = 4;
        break;
    case 2:
        game.num_colors = 8;
        break;
    default:
        game.num_colors = 6;
    }
    game.turn = 1;

    if (game.num_colors == 4 && game.board_size == 12)
        game.max_turn = 14;
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
    for (int x = 0; x < game.board_size; x++)
        for (int y = 0; y < game.board_size; y++)
            game.cells[x][y] = rand() % game.num_colors;
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
static inline int fill(int x, int y, int old_color, int new_color)
{
    if (x < 0 || y < 0 || x > game.board_size || y > game.board_size)
        return 0;

    if (game.cells[x][y] != old_color)
        return game.cells[x][y] != new_color;

    int filled = 0;
    game.cells[x][y] = new_color;
    if (y - 1 >= 0)
        filled += fill(x, y - 1, old_color, new_color); // UP
    if (y + 1 < game.board_size)
        filled += fill(x, y + 1, old_color, new_color); // DOWN
    if (x + 1 < game.board_size)
        filled += fill(x + 1, y, old_color, new_color); // RIGHT
    if (x - 1 >= 0)
        filled += fill(x - 1, y, old_color, new_color); // LEFT

    return filled;
}

int game_size_toggle(int change)
{
    if (change != 0)
    {
        // change size
        current_size += change;

        // handle overflow
        if (current_size < 0)
            current_size = 2;
        else if (current_size > 2)
            current_size = 0;
    }
    return current_size;
}

int game_num_colors_toggle(int change)
{
    if (change != 0)
    {
        // change difficulty
        current_num_colors += change;

        // handle overflow
        if (current_num_colors < 0)
            current_num_colors = 2;
        else if (current_num_colors > 2)
            current_num_colors = 0;
    }
    return current_num_colors;
}

status_t game_play(control_t keys)
{
    if (keys.direction == d_down)
    {
        game.selected_color++;
        if (game.selected_color == game.num_colors / 2)
            game.selected_color = 0;
        else if (game.selected_color == game.num_colors)
            game.selected_color = game.num_colors / 2;
        return game_none;
    }
    if (keys.direction == d_up)
    {
        game.selected_color--;
        if (game.selected_color == -1)
            game.selected_color = game.num_colors / 2 - 1;
        else if (game.selected_color == game.num_colors / 2 - 1)
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
        if (game.cells[0][0] == game.selected_color)
        {
            if (keys.rumble)
            {
                rumble_start(0);
                game.rumble = 4;
            }
            return game_none;
        }

        if (fill(0, 0, game.cells[0][0], game.selected_color))
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
        int x = 24;
        int y = (i + 1) * ((480 - (64 * game.num_colors / 2)) / (game.num_colors / 2 + 1)) + i * 64;
        if (i == game.selected_color)
            rdp_draw_filled_rectangle_size(x - 4, y - 4, 72, 72, colors[COLOR_GREY]);

        rdp_draw_filled_rectangle_with_border_size(x, y, 64, 64, colors[i], colors[COLOR_GREY]);
    }

    // draw right column
    for (int i = 0; i < game.num_colors / 2; i++)
    {
        int x = 552;
        int y = (i + 1) * ((480 - (64 * game.num_colors / 2)) / (game.num_colors / 2 + 1)) + i * 64;
        if (i + game.num_colors / 2 == game.selected_color)
            rdp_draw_filled_rectangle_size(x - 4, y - 4, 72, 72, colors[COLOR_GREY]);

        rdp_draw_filled_rectangle_with_border_size(x, y, 64, 64, colors[i + game.num_colors / 2], colors[COLOR_GREY]);
    }

    //draw the board
    rdp_draw_filled_rectangle_size(grid_x, grid_y, 368, 368, colors[COLOR_GREY]);
    for (int x = 0; x < game.board_size; x++)
    {
        for (int y = 0; y < game.board_size; y++)
        {
            int cell_size = 360 / game.board_size;
            int xx = grid_x + 4 + x * cell_size;
            int yy = grid_y + 4 + y * cell_size;

            rdp_draw_filled_rectangle_size(xx, yy, cell_size, cell_size, colors[game.cells[x][y]]);
        }
    }

    for (int x = 0; x < game.board_size; x++)
    {
        for (int y = 0; y < game.board_size; y++)
        {
            int cell_size = 360 / game.board_size;
            int xx = grid_x + 4 + x * cell_size;
            int yy = grid_y + 4 + y * cell_size;

            // up border
            if (y == 0 || game.cells[x][y] != game.cells[x][y - 1])
                rdp_draw_filled_rectangle_size(xx - 1, yy, cell_size + 2, 2, colors[COLOR_GREY]);

            // down border
            if (y == game.board_size - 1 || game.cells[x][y] != game.cells[x][y + 1])
                rdp_draw_filled_rectangle_size(xx - 1, yy + cell_size - 1, cell_size + 2, 2, colors[COLOR_GREY]);

            // left border
            if (x == 0 || game.cells[x][y] != game.cells[x - 1][y])
                rdp_draw_filled_rectangle_size(xx, yy - 1, 2, cell_size + 2, colors[COLOR_GREY]);

            // right border
            if (x == game.board_size - 1 || game.cells[x][y] != game.cells[x + 1][y])
                rdp_draw_filled_rectangle_size(xx + cell_size - 1, yy - 1, 2, cell_size + 2, colors[COLOR_GREY]);
        }
    }
}