/* colors.h -- colors helpers header
 *
 * Copyright (C) 2018 Victor Vieux
 *
 * This software may be modified and distributed under the terms
 * of the Apache license. See the LICENSE file for details.
 */

#ifndef __COLORS_H__
#define __COLORS_H__

#include <libdragon.h>

typedef enum
{
    COLOR_RED,
    COLOR_BLUE,
    COLOR_GREEN,
    COLOR_YELLOW,
    COLOR_ORANGE,
    COLOR_PURPLE,
    COLOR_CYAN,
    COLOR_PINK,
    COLOR_BLACK,
    COLOR_BG,
    COLOR_MENU_BG,
    COLOR_GREY,
    COLOR_WHITE

} colors_name_t;

void colors_init();

#endif //__COLORS_H__
