/* screens.c -- screens helpers implementation
 *
 * Copyright (C) 2018 Victor Vieux
 *
 * This software may be modified and distributed under the terms
 * of the Apache license. See the LICENSE file for details.
 */

#include <stdlib.h>

#include "colors.h"
#include "controls.h"
#include "dfs.h"
#include "fps.h"
#include "game.h"
#include "graphics.h"
#include "lang.h"
#include "rdp.h"
#include "screens.h"

static volatile int tick = 0;
static map_t *font;
static map_t *logo;

extern uint32_t colors[];

void screen_timer_title()
{
    tick++;
}

// load a few sprites in memory
void screen_init()
{
    logo = dfs_load_map("/gfx/maps/logo-%d_%d.sprite", NULL);
    font = dfs_load_map("/gfx/maps/font%d_%d.sprite", NULL);
}

void screen_resize_logo()
{
    dfs_free_map(logo);
    logo = dfs_load_map("/gfx/maps/logo_small-%d_%d.sprite", NULL);
}

// display the n64 logo and then the vrgl117 games logo.
// return true when the animation is done.
bool screen_intro(display_context_t disp)
{
    static int anim = 0;

    rdp_attach(disp);

    rdp_draw_filled_fullscreen(colors[COLOR_BLACK]);

    rdp_detach_display();
    sprite_t *intro = NULL;

    switch (anim)
    {
    case 1 ... 9:
        intro = dfs_load_spritef("/gfx/sprites/n64_%d.sprite", anim);
        break;
    case 10 ... 30:
        intro = dfs_load_sprite("/gfx/sprites/n64.sprite");
        break;
    case 31 ... 39:
        intro = dfs_load_spritef("/gfx/sprites/n64_%d.sprite", 40 - anim);
        break;
    case 41 ... 49:
        intro = dfs_load_spritef("/gfx/sprites/intro_%d.sprite", anim - 40);
        break;
    case 50 ... 70:
        intro = dfs_load_sprite("/gfx/sprites/intro.sprite");
        break;
    case 71 ... 79:
        intro = dfs_load_spritef("/gfx/sprites/intro_%d.sprite", 80 - anim);
        break;
    }

    if (intro != NULL)
    {
        graphics_draw_sprite(disp, 320 - intro->width / 2, 150, intro);
        free(intro);
    }

    anim++;
    return (anim >= 82);
}

// display the flags to select the lang.
void screen_lang(display_context_t disp)
{
    int selected_lang = lang_selected();

    rdp_attach(disp);

    rdp_draw_filled_fullscreen(colors[COLOR_BLACK]);

    // display the white border around the selected flag.
    rdp_draw_filled_rectangle_with_border_size(220 - 4, 45 + 45 * selected_lang + 100 * selected_lang - 4, 208, 108, colors[COLOR_BLACK], colors[COLOR_WHITE]);

    rdp_detach_display();

    sprite_t *en = dfs_load_sprite("/gfx/sprites/en_flag.sprite");
    graphics_draw_sprite(disp, 220, 45, en);
    free(en);

    sprite_t *es = dfs_load_sprite("/gfx/sprites/es_flag.sprite");
    graphics_draw_sprite(disp, 220, 190, es);
    free(es);

    sprite_t *fr = dfs_load_sprite("/gfx/sprites/fr_flag.sprite");
    graphics_draw_sprite(disp, 220, 335, fr);
    free(fr);
}

// display a simple text when no controller is connected.
void screen_no_controller(display_context_t disp)
{
    rdp_attach(disp);

    rdp_draw_filled_fullscreen(colors[COLOR_BLACK]);

    map_t *no_controller = dfs_load_map("/gfx/maps/%s/no_controller-%d_%d.sprite", lang_selected_str());
    rdp_draw_sprite_with_texture_map(no_controller, 320 - no_controller->width / 2, 240 - no_controller->height / 2);
    dfs_free_map(no_controller);

    rdp_detach_display();
}

// display the board and scores.
void screen_game(display_context_t disp)
{
    rdp_attach(disp);

    rdp_draw_filled_fullscreen(colors[COLOR_BG]);

    rdp_draw_sprite_with_texture_map(logo, 132, 11);

    // draw score.
    rdp_draw_filled_rectangle_with_border_size(410, 16, 90, 30, colors[COLOR_BG], colors[COLOR_GREY]);
    int x = rdp_draw_int_map_padded(414, 18, font, game_turn(), 10);
    rdp_draw_sprite_with_texture(font->sprites[10], x, 18);
    rdp_draw_int_map(x + 17, 18, font, game_max_turn());

    // draw the board.
    game_draw(disp, 132, 64);

    rdp_detach_display();
}

// display the title screen, with press start blinking.
void screen_title(display_context_t disp)
{
    rdp_attach(disp);

    rdp_draw_filled_fullscreen(colors[COLOR_BG]);

    rdp_draw_sprite_with_texture_map(logo, 320 - logo->width / 2, 18);

    // draw only press start half of the time (blink).
    if (tick % 14 > 7)
    {
        map_t *press_start = dfs_load_map("/gfx/maps/%s/press_start-%d_%d.sprite", lang_selected_str());
        rdp_draw_sprite_with_texture_map(press_start, 320 - press_start->width / 2, 400);
        dfs_free_map(press_start);
    }

    // draw the version.
    sprite_t *version = dfs_load_sprite("/gfx/sprites/version.sprite");
    rdp_draw_sprite_with_texture(version, 640 - version->width - 6, 480 - version->height - 6);
    free(version);

    rdp_detach_display();
}
