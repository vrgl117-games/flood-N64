/* rdp.c -- rpd helpers implementation
 *
 * Copyright (C) 2018 Victor Vieux
 *
 * This software may be modified and distributed under the terms
 * of the Apache license. See the LICENSE file for details.
 */

#include <stdlib.h>
#include <math.h>

#include "rdp.h"

extern uint32_t __width;
extern uint32_t __height;

void rdp_attach(display_context_t disp)
{
    rdp_attach_display(disp);
    rdp_set_default_clipping();
}

int rdp_draw_int_map(int x, int y, map_t *font, int n, int flags)
{
    if (n >= 10)
        x = rdp_draw_int_map(x, y, font, n / 10, flags);

    rdp_draw_sprite_with_texture(font->sprites[n % 10], x, y, flags);
    return x + 11;
}

void rdp_draw_filled_fullscreen(uint32_t color)
{
    rdp_draw_filled_rectangle_size(0, 0, __width, __height, color);
}

void rdp_draw_filled_rectangle_size(int x, int y, int width, int height, uint32_t color)
{
    rdp_enable_primitive_fill();
    rdp_sync(SYNC_PIPE);
    rdp_set_fill_color((color & 0xFF000000) >> 24, (color & 0x00FF0000) >> 16, (color & 0x0000FF00) >> 8, 0x55);
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
    rdp_set_fill_color((border_color & 0xFF000000) >> 24, (border_color & 0x00FF0000) >> 16, (border_color & 0x0000FF00) >> 8, (border_color & 0x000000FF));
    rdp_draw_filled_rectangle(x, y, x + width, y + height);
    rdp_set_fill_color((color & 0xFF000000) >> 24, (color & 0x00FF0000) >> 16, (color & 0x0000FF00) >> 8, (color & 0x000000FF));
    rdp_draw_filled_rectangle(x + size_border, y + size_border, x + width - size_border, y + height - size_border);
}

void rdp_draw_sprite_with_texture(sprite_t *sp, int x, int y, int flags)
{
    rdp_enable_texture_copy();
    rdp_sync(SYNC_PIPE);
    rdp_load_texture(sp);
    rdp_draw_sprite(x, y, flags);
}

void rdp_draw_sprite_with_texture_map(map_t *map, int x, int y, int flags)
{
    int xx = 0;
    int yy = 0;

    for (int i = 0; i < map->slices; i++)
    {
        int ii = (flags == 3 ? map->slices - 1 - i : i);
        rdp_draw_sprite_with_texture(map->sprites[ii], x + xx, y + yy, flags);
        if (i % map->mod == map->mod - 1)
        {
            yy += map->sprites[ii]->height;
            xx = 0;
        }
        else
            xx += map->sprites[ii]->width;
    }
}

void rdp_enable_texture_copy()
{
    // 16bits:  rdp_texture_copy(ATOMIC_PRIM | ALPHA_DITHER_SEL_NO_DITHER | RGB_DITHER_SEL_NO_DITHER);
    rdp_texture_cycle(0, 0, ATOMIC_PRIM | ALPHA_DITHER_SEL_NO_DITHER | RGB_DITHER_SEL_NO_DITHER);
}