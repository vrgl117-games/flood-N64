/* colors.c -- colors helpers implementation
 *
 * Copyright (C) 2019 Victor Vieux
 *
 * This software may be modified and distributed under the terms
 * of the Apache license. See the LICENSE file for details.
 */

#include "colors.h"

uint32_t colors[13];

void colors_init()
{
    colors[COLOR_BG] = graphics_make_color(0xc0, 0xc0, 0xc0, 0xff);
    colors[COLOR_MENU_BG] = graphics_make_color(0xf8, 0xf8, 0xf8, 0xff);
    colors[COLOR_GREY] = graphics_make_color(0x40, 0x40, 0x40, 0xff);
    colors[COLOR_BLACK] = graphics_make_color(0x00, 0x00, 0x00, 0xff);
    colors[COLOR_WHITE] = graphics_make_color(0xff, 0xff, 0xff, 0xff);
    colors[COLOR_RED] = graphics_make_color(0xe6, 0x3a, 0x3f, 0xff);
    colors[COLOR_BLUE] = graphics_make_color(0x70, 0x8c, 0xfd, 0xff);
    colors[COLOR_GREEN] = graphics_make_color(0x35, 0x9c, 0x35, 0xff);
    colors[COLOR_YELLOW] = graphics_make_color(0xff, 0xce, 0x2c, 0xff);
    colors[COLOR_ORANGE] = graphics_make_color(0xff, 0x6f, 0x43, 0xff);
    colors[COLOR_PURPLE] = graphics_make_color(0xa1, 0x3c, 0xb1, 0xff);
    colors[COLOR_CYAN] = graphics_make_color(0x38, 0xff, 0xff, 0xff);
    colors[COLOR_PINK] = graphics_make_color(0xf2, 0x73, 0x9d, 0xff);
}