/* rdp.c -- rpd helpers implementation
 *
 * Copyright (C) 2018 Victor Vieux
 *
 * This software may be modified and distributed under the terms
 * of the Apache license. See the LICENSE file for details.
 */

#include <math.h>
#include <stdlib.h>

#include "rdp.h"

extern uint32_t __width;
extern uint32_t __height;

void rdp_attach(display_context_t disp)
{
    rdp_attach_display(disp);
    rdp_set_default_clipping();
}

int rdp_draw_int_map(int x, int y, map_t *font, int n)
{
    if (n >= 10)
        x = rdp_draw_int_map(x, y, font, n / 10);

    rdp_draw_sprite_with_texture(font->sprites[n % 10], x, y);
    return x + 16;
}

int rdp_draw_int_map_padded(int x, int y, map_t *font, int n, int pad)
{
    if (n < pad)
    {
        rdp_draw_sprite_with_texture(font->sprites[0], x, y);
        return rdp_draw_int_map_padded(x + 16, y, font, n, pad / 10);
    }

    return rdp_draw_int_map(x, y, font, n);
}

void rdp_draw_filled_fullscreen(uint32_t color)
{
    rdp_draw_filled_rectangle_size(0, 0, __width, __height, color);
}

void rdp_draw_filled_rectangle_size(int x, int y, int width, int height, uint32_t color)
{
    rdp_enable_primitive_fill();
    rdp_sync(SYNC_PIPE);
    rdp_set_primitive_color(color);
    rdp_draw_filled_rectangle(x, y, x + width, y + height);
}

void rdp_draw_filled_rectangle_with_border_size(int x, int y, int width, int height, uint32_t color, uint32_t border_color)
{
    rdp_draw_filled_rectangle_with_sized_border_size(x, y, width, height, 2, color, border_color);
}

void rdp_draw_filled_rectangle_with_sized_border_size(int x, int y, int width, int height, int size_border, uint32_t color, uint32_t border_color)
{
    rdp_enable_primitive_fill();
    rdp_sync(SYNC_PIPE);
    rdp_set_primitive_color(border_color);
    rdp_draw_filled_rectangle(x, y, x + width, y + height);
    rdp_set_primitive_color(color);
    rdp_draw_filled_rectangle(x + size_border, y + size_border, x + width - size_border, y + height - size_border);
}

void rdp_draw_sprite_with_texture(sprite_t *sp, int x, int y)
{
    rdp_enable_texture_copy();
    rdp_sync(SYNC_PIPE);
    rdp_load_texture(0, 0, MIRROR_DISABLED, sp);
    rdp_draw_sprite(0, x, y, MIRROR_DISABLED);
}

void rdp_draw_sprite_with_texture_map(map_t *map, int x, int y)
{
    int xx = 0;
    int yy = 0;

    for (int i = 0; i < map->slices; i++)
    {
        rdp_draw_sprite_with_texture(map->sprites[i], x + xx, y + yy);
        if (i % map->mod == map->mod - 1)
        {
            yy += map->sprites[i]->height;
            xx = 0;
        }
        else
            xx += map->sprites[i]->width;
    }
}
