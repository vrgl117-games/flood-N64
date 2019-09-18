/* screens.h -- screens helpers header
 *
 * Copyright (C) 2018 Victor Vieux
 *
 * This software may be modified and distributed under the terms
 * of the Apache license. See the LICENSE file for details.
 */

#ifndef __SCREENS_H__
#define __SCREENS_H__

#include <libdragon.h>

#include "menus.h"

typedef enum screens
{
    intro,
    lang,
    title,
    game
} screen_t;

void screen_init();
bool screen_intro(display_context_t disp);
void screen_lang(display_context_t disp);
void screen_game(display_context_t disp);
void screen_no_controller(display_context_t disp);
void screen_resize_logo();
void screen_title(display_context_t disp);
void screen_timer_title();

#endif //__SCREENS_H__
