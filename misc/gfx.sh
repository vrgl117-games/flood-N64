#!/usr/bin/env bash

fontb='misc/font/pf_ronda_seven_bold.ttf'
fontr='misc/font/pf_ronda_seven.ttf'

#UI
convert -strip resources/gfx/sprites/logo.png -crop 32 resources/gfx/maps/logo-%d_0.png
convert -strip resources/gfx/sprites/logo_small.png -crop 32 resources/gfx/maps/logo_small-%d_0.png

convert -strip -background "#c0c0c0ff" -fill "#404040ff" -font "$fontb" -pointsize 42 label:"Press Start" -gravity center -extent x64 -crop 32 resources/gfx/maps/en/press_start-%d_0.png
convert -strip -background "#c0c0c0ff" -fill "#404040ff" -font "$fontb" -pointsize 42 label:"Appuyez sur Start" -gravity center -extent 520x64 -crop 32 resources/gfx/maps/fr/press_start-%d_0.png
convert -strip -background "#c0c0c0ff" -fill "#404040ff" -font "$fontb" -pointsize 42 label:"Pulsa Start" -gravity center -extent x64 -crop 32 resources/gfx/maps/es/press_start-%d_0.png

convert -strip -background "#c0c0c0ff" -fill "#404040ff" -font "$fontb" -pointsize 10 label:"version: 0.1" -gravity center -extent x16 resources/gfx/sprites/version.png

# #menu
convert -strip -background "#f8f8f8ff" -fill "#404040ff" -font "$fontb" -pointsize 24 label:"Game Over" resources/gfx/sprites/en/title_game_over.png
convert -strip -background "#f8f8f8ff" -fill "#404040ff" -font "$fontb" -pointsize 24 label:"Partie Terminée" resources/gfx/sprites/fr/title_game_over.png
convert -strip -background "#f8f8f8ff" -fill "#404040ff" -font "$fontb" -pointsize 24 label:"Fin del juego" resources/gfx/sprites/es/title_game_over.png

convert -strip -background "#f8f8f8ff" -fill "#404040ff" -font "$fontb" -pointsize 24 label:"You Win!" resources/gfx/sprites/en/title_you_win.png
convert -strip -background "#f8f8f8ff" -fill "#404040ff" -font "$fontb" -pointsize 24 label:"Gagné !" resources/gfx/sprites/fr/title_you_win.png
convert -strip -background "#f8f8f8ff" -fill "#404040ff" -font "$fontb" -pointsize 24 label:"¡Exito!" resources/gfx/sprites/es/title_you_win.png

convert -strip -background "#f8f8f8ff" -fill "#404040ff" -font "$fontb" -pointsize 24 label:"Pause" resources/gfx/sprites/en/title_pause.png
convert -strip -background "#f8f8f8ff" -fill "#404040ff" -font "$fontb" -pointsize 24 label:"Pause" resources/gfx/sprites/fr/title_pause.png
convert -strip -background "#f8f8f8ff" -fill "#404040ff" -font "$fontb" -pointsize 24 label:"Pausa" resources/gfx/sprites/es/title_pause.png

convert -strip -background "#f8f8f8ff" -fill "#404040ff" -font "$fontb" -pointsize 24 label:"New Game" resources/gfx/sprites/en/title_new_game.png
convert -strip -background "#f8f8f8ff" -fill "#404040ff" -font "$fontb" -pointsize 24 label:"Nouvelle Partie" resources/gfx/sprites/fr/title_new_game.png
convert -strip -background "#f8f8f8ff" -fill "#404040ff" -font "$fontb" -pointsize 24 label:"Nuevo juego" resources/gfx/sprites/es/title_new_game.png

convert -strip -background "#f8f8f8ff" -fill "#404040ff" -font "$fontb" -pointsize 24 label:"Credits" resources/gfx/sprites/en/title_credits.png
convert -strip -background "#f8f8f8ff" -fill "#404040ff" -font "$fontb" -pointsize 24 label:"Crédits" resources/gfx/sprites/fr/title_credits.png
convert -strip -background "#f8f8f8ff" -fill "#404040ff" -font "$fontb" -pointsize 24 label:"Créditos" resources/gfx/sprites/es/title_credits.png

convert -strip -background "#f8f8f8ff" -fill "#404040ff" -font "$fontr" -pointsize 18 label:"Continue" -extent x32 resources/gfx/sprites/en/continue.png
convert -strip -background "#f8f8f8ff" -fill "#404040ff" -font "$fontr" -pointsize 18 label:"Continuer" -extent x32 resources/gfx/sprites/fr/continue.png
convert -strip -background "#f8f8f8ff" -fill "#404040ff" -font "$fontr" -pointsize 18 label:"Continuar" -extent x32 resources/gfx/sprites/es/continue.png

convert -strip -background "#f8f8f8ff" -fill "#404040ff" -font "$fontb" -pointsize 18 label:"Continue" -extent x32 resources/gfx/sprites/en/continue_selec.png
convert -strip -background "#f8f8f8ff" -fill "#404040ff" -font "$fontb" -pointsize 18 label:"Continuer" -extent x32 resources/gfx/sprites/fr/continue_selec.png
convert -strip -background "#f8f8f8ff" -fill "#404040ff" -font "$fontb" -pointsize 18 label:"Continuar" -extent x32 resources/gfx/sprites/es/continue_selec.png

convert -strip -background "#f8f8f8ff" -fill "#404040ff" -font "$fontr" -pointsize 18 label:"  Size of the board: 12x12  " -extent x32 resources/gfx/sprites/en/size_0.png
convert -strip -background "#f8f8f8ff" -fill "#404040ff" -font "$fontr" -pointsize 18 label:"  Taille de la grille: 12x12  " -extent x32 resources/gfx/sprites/fr/size_0.png
convert -strip -background "#f8f8f8ff" -fill "#404040ff" -font "$fontr" -pointsize 18 label:"  Tamaño del tablero: 12x12  " -extent x32 resources/gfx/sprites/es/size_0.png

convert -strip -background "#f8f8f8ff" -fill "#404040ff" -font "$fontb" -pointsize 18 label:"< Size of the board: 12x12 >" -extent x32 resources/gfx/sprites/en/size_0_selec.png
convert -strip -background "#f8f8f8ff" -fill "#404040ff" -font "$fontb" -pointsize 18 label:"< Taille de la grille: 12x12 >" -extent x32 resources/gfx/sprites/fr/size_0_selec.png
convert -strip -background "#f8f8f8ff" -fill "#404040ff" -font "$fontb" -pointsize 18 label:"< Tamaño del tablero: 12x12 >" -extent x32 resources/gfx/sprites/es/size_0_selec.png

convert -strip -background "#f8f8f8ff" -fill "#404040ff" -font "$fontr" -pointsize 18 label:"  Size of the board: 18x18  " -extent x32 resources/gfx/sprites/en/size_1.png
convert -strip -background "#f8f8f8ff" -fill "#404040ff" -font "$fontr" -pointsize 18 label:"  Taille de la grille: 18x18  " -extent x32 resources/gfx/sprites/fr/size_1.png
convert -strip -background "#f8f8f8ff" -fill "#404040ff" -font "$fontr" -pointsize 18 label:"  Tamaño del tablero: 18x18  " -extent x32 resources/gfx/sprites/es/size_1.png

convert -strip -background "#f8f8f8ff" -fill "#404040ff" -font "$fontb" -pointsize 18 label:"< Size of the board: 18x18 >" -extent x32 resources/gfx/sprites/en/size_1_selec.png
convert -strip -background "#f8f8f8ff" -fill "#404040ff" -font "$fontb" -pointsize 18 label:"< Taille de la grille: 18x18 >" -extent x32 resources/gfx/sprites/fr/size_1_selec.png
convert -strip -background "#f8f8f8ff" -fill "#404040ff" -font "$fontb" -pointsize 18 label:"< Tamaño del tablero: 18x18 >" -extent x32 resources/gfx/sprites/es/size_1_selec.png

convert -strip -background "#f8f8f8ff" -fill "#404040ff" -font "$fontr" -pointsize 18 label:"  Size of the board: 24x24  " -extent x32 resources/gfx/sprites/en/size_2.png
convert -strip -background "#f8f8f8ff" -fill "#404040ff" -font "$fontr" -pointsize 18 label:"  Taille de la grille: 24x24  " -extent x32 resources/gfx/sprites/fr/size_2.png
convert -strip -background "#f8f8f8ff" -fill "#404040ff" -font "$fontr" -pointsize 18 label:"  Tamaño del tablero: 24x24  " -extent x32 resources/gfx/sprites/es/size_2.png

convert -strip -background "#f8f8f8ff" -fill "#404040ff" -font "$fontb" -pointsize 18 label:"< Size of the board: 24x24 >" -extent x32 resources/gfx/sprites/en/size_2_selec.png
convert -strip -background "#f8f8f8ff" -fill "#404040ff" -font "$fontb" -pointsize 18 label:"< Taille de la grille: 24x24 >" -extent x32 resources/gfx/sprites/fr/size_2_selec.png
convert -strip -background "#f8f8f8ff" -fill "#404040ff" -font "$fontb" -pointsize 18 label:"< Tamaño del tablero: 24x24 >" -extent x32 resources/gfx/sprites/es/size_2_selec.png

convert -strip -background "#f8f8f8ff" -fill "#404040ff" -font "$fontr" -pointsize 18 label:"  Number of colors: 4  " -extent x32 resources/gfx/sprites/en/colors_0.png
convert -strip -background "#f8f8f8ff" -fill "#404040ff" -font "$fontr" -pointsize 18 label:"  Nombre de couleurs: 4  " -extent x32 resources/gfx/sprites/fr/colors_0.png
convert -strip -background "#f8f8f8ff" -fill "#404040ff" -font "$fontr" -pointsize 18 label:"  Cantidad de colores: 4  " -extent x32 resources/gfx/sprites/es/colors_0.png

convert -strip -background "#f8f8f8ff" -fill "#404040ff" -font "$fontb" -pointsize 18 label:"< Number of colors: 4 >" -extent x32 resources/gfx/sprites/en/colors_0_selec.png
convert -strip -background "#f8f8f8ff" -fill "#404040ff" -font "$fontb" -pointsize 18 label:"< Nombre de couleurs: 4 >" -extent x32 resources/gfx/sprites/fr/colors_0_selec.png
convert -strip -background "#f8f8f8ff" -fill "#404040ff" -font "$fontb" -pointsize 18 label:"< Cantidad de colores: 4 >" -extent x32 resources/gfx/sprites/es/colors_0_selec.png

convert -strip -background "#f8f8f8ff" -fill "#404040ff" -font "$fontr" -pointsize 18 label:"  Number of colors: 6  " -extent x32 resources/gfx/sprites/en/colors_1.png
convert -strip -background "#f8f8f8ff" -fill "#404040ff" -font "$fontr" -pointsize 18 label:"  Nombre de couleurs: 6  " -extent x32 resources/gfx/sprites/fr/colors_1.png
convert -strip -background "#f8f8f8ff" -fill "#404040ff" -font "$fontr" -pointsize 18 label:"  Cantidad de colores: 6  " -extent x32 resources/gfx/sprites/es/colors_1.png

convert -strip -background "#f8f8f8ff" -fill "#404040ff" -font "$fontb" -pointsize 18 label:"< Number of colors: 6 >" -extent x32 resources/gfx/sprites/en/colors_1_selec.png
convert -strip -background "#f8f8f8ff" -fill "#404040ff" -font "$fontb" -pointsize 18 label:"< Nombre de couleurs: 6 >" -extent x32 resources/gfx/sprites/fr/colors_1_selec.png
convert -strip -background "#f8f8f8ff" -fill "#404040ff" -font "$fontb" -pointsize 18 label:"< Cantidad de colores: 6 >" -extent x32 resources/gfx/sprites/es/colors_1_selec.png

convert -strip -background "#f8f8f8ff" -fill "#404040ff" -font "$fontr" -pointsize 18 label:"  Number of colors: 8  " -extent x32 resources/gfx/sprites/en/colors_2.png
convert -strip -background "#f8f8f8ff" -fill "#404040ff" -font "$fontr" -pointsize 18 label:"  Nombre de couleurs: 8  " -extent x32 resources/gfx/sprites/fr/colors_2.png
convert -strip -background "#f8f8f8ff" -fill "#404040ff" -font "$fontr" -pointsize 18 label:"  Cantidad de colores: 8  " -extent x32 resources/gfx/sprites/es/colors_2.png

convert -strip -background "#f8f8f8ff" -fill "#404040ff" -font "$fontb" -pointsize 18 label:"< Number of colors: 8 >" -extent x32 resources/gfx/sprites/en/colors_2_selec.png
convert -strip -background "#f8f8f8ff" -fill "#404040ff" -font "$fontb" -pointsize 18 label:"< Nombre de couleurs: 8 >" -extent x32 resources/gfx/sprites/fr/colors_2_selec.png
convert -strip -background "#f8f8f8ff" -fill "#404040ff" -font "$fontb" -pointsize 18 label:"< Cantidad de colores: 8 >" -extent x32 resources/gfx/sprites/es/colors_2_selec.png

convert -strip -background "#f8f8f8ff" -fill "#404040ff" -font "$fontr" -pointsize 18 label:"  Music: Track #1  " -extent x32 resources/gfx/sprites/en/music_1.png
convert -strip -background "#f8f8f8ff" -fill "#404040ff" -font "$fontr" -pointsize 18 label:"  Musique: Track #1  " -extent x32 resources/gfx/sprites/fr/music_1.png
convert -strip -background "#f8f8f8ff" -fill "#404040ff" -font "$fontr" -pointsize 18 label:"  Musica: Track #1  " -extent x32 resources/gfx/sprites/es/music_1.png

convert -strip -background "#f8f8f8ff" -fill "#404040ff" -font "$fontb" -pointsize 18 label:"< Music: Track #1 >" -extent x32 resources/gfx/sprites/en/music_1_selec.png
convert -strip -background "#f8f8f8ff" -fill "#404040ff" -font "$fontb" -pointsize 18 label:"< Musique: Track #1 >" -extent x32 resources/gfx/sprites/fr/music_1_selec.png
convert -strip -background "#f8f8f8ff" -fill "#404040ff" -font "$fontb" -pointsize 18 label:"< Musica: Track #1 >" -extent x32 resources/gfx/sprites/es/music_1_selec.png

convert -strip -background "#f8f8f8ff" -fill "#404040ff" -font "$fontr" -pointsize 18 label:"  Music: Track #2  " -extent x32 resources/gfx/sprites/en/music_2.png
convert -strip -background "#f8f8f8ff" -fill "#404040ff" -font "$fontr" -pointsize 18 label:"  Musique: Track #2  " -extent x32 resources/gfx/sprites/fr/music_2.png
convert -strip -background "#f8f8f8ff" -fill "#404040ff" -font "$fontr" -pointsize 18 label:"  Musica: Track #2  " -extent x32 resources/gfx/sprites/es/music_2.png

convert -strip -background "#f8f8f8ff" -fill "#404040ff" -font "$fontb" -pointsize 18 label:"< Music: Track #2 >" -extent x32 resources/gfx/sprites/en/music_2_selec.png
convert -strip -background "#f8f8f8ff" -fill "#404040ff" -font "$fontb" -pointsize 18 label:"< Musique: Track #2 >" -extent x32 resources/gfx/sprites/fr/music_2_selec.png
convert -strip -background "#f8f8f8ff" -fill "#404040ff" -font "$fontb" -pointsize 18 label:"< Musica: Track #2 >" -extent x32 resources/gfx/sprites/es/music_2_selec.png

convert -strip -background "#f8f8f8ff" -fill "#404040ff" -font "$fontr" -pointsize 18 label:"  Music: Track #3  " -extent x32 resources/gfx/sprites/en/music_3.png
convert -strip -background "#f8f8f8ff" -fill "#404040ff" -font "$fontr" -pointsize 18 label:"  Musique: Track #3  " -extent x32 resources/gfx/sprites/fr/music_3.png
convert -strip -background "#f8f8f8ff" -fill "#404040ff" -font "$fontr" -pointsize 18 label:"  Musica: Track #3  " -extent x32 resources/gfx/sprites/es/music_3.png

convert -strip -background "#f8f8f8ff" -fill "#404040ff" -font "$fontb" -pointsize 18 label:"< Music: Track #3 >" -extent x32 resources/gfx/sprites/en/music_3_selec.png
convert -strip -background "#f8f8f8ff" -fill "#404040ff" -font "$fontb" -pointsize 18 label:"< Musique: Track #3 >" -extent x32 resources/gfx/sprites/fr/music_3_selec.png
convert -strip -background "#f8f8f8ff" -fill "#404040ff" -font "$fontb" -pointsize 18 label:"< Musica: Track #3 >" -extent x32 resources/gfx/sprites/es/music_3_selec.png

convert -strip -background "#f8f8f8ff" -fill "#404040ff" -font "$fontr" -pointsize 18 label:"  Music: OFF  " -extent x32 resources/gfx/sprites/en/music_0.png
convert -strip -background "#f8f8f8ff" -fill "#404040ff" -font "$fontr" -pointsize 18 label:"  Musique: OFF  " -extent x32 resources/gfx/sprites/fr/music_0.png
convert -strip -background "#f8f8f8ff" -fill "#404040ff" -font "$fontr" -pointsize 18 label:"  Musica: OFF  " -extent x32 resources/gfx/sprites/es/music_0.png

convert -strip -background "#f8f8f8ff" -fill "#404040ff" -font "$fontb" -pointsize 18 label:"< Music: OFF >" -extent x32 resources/gfx/sprites/en/music_0_selec.png
convert -strip -background "#f8f8f8ff" -fill "#404040ff" -font "$fontb" -pointsize 18 label:"< Musique: OFF >" -extent x32 resources/gfx/sprites/fr/music_0_selec.png
convert -strip -background "#f8f8f8ff" -fill "#404040ff" -font "$fontb" -pointsize 18 label:"< Musica: OFF >" -extent x32 resources/gfx/sprites/es/music_0_selec.png

convert -strip -background "#f8f8f8ff" -fill "#404040ff" -font "$fontr" -pointsize 18 label:"Restart" -extent x32 resources/gfx/sprites/en/restart.png
convert -strip -background "#f8f8f8ff" -fill "#404040ff" -font "$fontr" -pointsize 18 label:"Recommencer" -extent x32 resources/gfx/sprites/fr/restart.png
convert -strip -background "#f8f8f8ff" -fill "#404040ff" -font "$fontr" -pointsize 18 label:"Jugar otra vez" -extent x32 resources/gfx/sprites/es/restart.png

convert -strip -background "#f8f8f8ff" -fill "#404040ff" -font "$fontb" -pointsize 18 label:"Restart" -extent x32 resources/gfx/sprites/en/restart_selec.png
convert -strip -background "#f8f8f8ff" -fill "#404040ff" -font "$fontb" -pointsize 18 label:"Recommencer" -extent x32 resources/gfx/sprites/fr/restart_selec.png
convert -strip -background "#f8f8f8ff" -fill "#404040ff" -font "$fontb" -pointsize 18 label:"Jugar otra vez" -extent x32 resources/gfx/sprites/es/restart_selec.png

convert -strip -background "#f8f8f8ff" -fill "#404040ff" -font "$fontr" -pointsize 18 label:"Credits" -extent x32 resources/gfx/sprites/en/credits.png
convert -strip -background "#f8f8f8ff" -fill "#404040ff" -font "$fontr" -pointsize 18 label:"Crédits" -extent x32 resources/gfx/sprites/fr/credits.png
convert -strip -background "#f8f8f8ff" -fill "#404040ff" -font "$fontr" -pointsize 18 label:"Créditos" -extent x32 resources/gfx/sprites/es/credits.png

convert -strip -background "#f8f8f8ff" -fill "#404040ff" -font "$fontb" -pointsize 18 label:"Credits" -extent x32 resources/gfx/sprites/en/credits_selec.png
convert -strip -background "#f8f8f8ff" -fill "#404040ff" -font "$fontb" -pointsize 18 label:"Crédits" -extent x32 resources/gfx/sprites/fr/credits_selec.png
convert -strip -background "#f8f8f8ff" -fill "#404040ff" -font "$fontb" -pointsize 18 label:"Créditos" -extent x32 resources/gfx/sprites/es/credits_selec.png

convert -strip -background "#f8f8f8ff" -fill "#404040ff" -font "$fontr" -pointsize 18 label:"Back" -extent x32 resources/gfx/sprites/en/back.png
convert -strip -background "#f8f8f8ff" -fill "#404040ff" -font "$fontr" -pointsize 18 label:"Retour" -extent x32 resources/gfx/sprites/fr/back.png
convert -strip -background "#f8f8f8ff" -fill "#404040ff" -font "$fontr" -pointsize 18 label:"Volver" -extent x32 resources/gfx/sprites/es/back.png

convert -strip -background "#f8f8f8ff" -fill "#404040ff" -font "$fontb" -pointsize 18 label:"Back" -extent x32 resources/gfx/sprites/en/back_selec.png
convert -strip -background "#f8f8f8ff" -fill "#404040ff" -font "$fontb" -pointsize 18 label:"Retour" -extent x32 resources/gfx/sprites/fr/back_selec.png
convert -strip -background "#f8f8f8ff" -fill "#404040ff" -font "$fontb" -pointsize 18 label:"Volver" -extent x32 resources/gfx/sprites/es/back_selec.png

convert -strip -background "#f8f8f8ff" -fill "#404040ff" -font "$fontr" -pointsize 18 -gravity Center label:"Inspired by the game Open Flood\nby Rhys Rustad-Elliott\nwww.rhysre.net\n\nMusic by m0d\nwww.modarchive.org\n\nN64 version developed by Victor Vieux\nwww.vrgl117.games" -extent 372x272 resources/gfx/sprites/en/text_credits.png
convert -strip -background "#f8f8f8ff" -fill "#404040ff" -font "$fontr" -pointsize 18 -gravity Center label:"Insipiré du jeu Open Flood\ncreé par Rhys Rustad-Elliott\nwww.rhysre.net\n\nMusique par m0d\nwww.modarchive.org\n\nVersion N64 codée par Victor Vieux\nwww.vrgl117.games" -extent 346x272 resources/gfx/sprites/fr/text_credits.png
convert -strip -background "#f8f8f8ff" -fill "#404040ff" -font "$fontr" -pointsize 18 -gravity Center label:"Inspirado en el Juego Open Flood\npor Rhys Rustad-Elliott\nwww.rhysre.net\n\nMusica por m0d\nwww.modarchive.org\n\nVersion N64 por Victor Vieux\nwww.vrgl117.games" -extent 312x272 resources/gfx/sprites/es/text_credits.png

convert -strip -background "#f8f8f8ff" -fill "#404040ff" -font "$fontr" -pointsize 18 -gravity Center label:"Try to flood fill the entire grid with one color!\n\n\nThis game is Rumble Pak compatible. Please insert\nyour Rumble Pak now if you wish to play with it." -extent 486x152 resources/gfx/sprites/en/text_help.png
convert -strip -background "#f8f8f8ff" -fill "#404040ff" -font "$fontr" -pointsize 18 -gravity Center label:"Essayez d'innonder la grille d'une seule couleur!\n\n\Ce jeu est compatible avec le Rumble Pak. Insérez\nvotre Rumble Pak maintenant si vous souhaitez\nl'utiliser." -extent 486x152 resources/gfx/sprites/fr/text_help.png
convert -strip -background "#f8f8f8ff" -fill "#404040ff" -font "$fontr" -pointsize 18 -gravity Center label:"Intenta inundar toda la cuadrícula con un solo color!\n\n\nEste juego es compatible con Rumble Pak. Por favor\ninserte su Rumble Pak si desea jugar con este." -extent 502x152 resources/gfx/sprites/es/text_help.png

# #screen
# convert -strip -background "#000000FF" -fill "#EDE0C8ff" -font "$fontb" -pointsize 24 label:"NO CONTROLLER INSERTED ON PORT #1" -gravity center -extent 446x32 -crop 64 resources/gfx/maps/en/no_controller-%d_0.png
# convert -strip -background "#000000FF" -fill "#EDE0C8ff" -font "$fontb" -pointsize 24 label:"PAS DE MANETTE CONNECTEE AU PORT #1" -gravity center -extent 476x32 -crop 64 resources/gfx/maps/fr/no_controller-%d_0.png
# convert -strip -background "#000000FF" -fill "#EDE0C8ff" -font "$fontb" -pointsize 24 label:"JOYSTICK NO INSERTADO EN EL PUERTO #1" -gravity center -extent 482x32 -crop 64 resources/gfx/maps/es/no_controller-%d_0.png



# font
convert -strip -background "#c0c0c0ff" -fill "#404040ff" -font "$fontb" -pointsize 18 label:0 -shave x4 -background "#c0c0c0ff" -gravity center -extent 18x24-1 resources/gfx/maps/font0_0.png
convert -strip -background "#c0c0c0ff" -fill "#404040ff" -font "$fontb" -pointsize 18 label:1 -shave x4 -background "#c0c0c0ff" -gravity center -extent 18x24-1 resources/gfx/maps/font1_0.png
convert -strip -background "#c0c0c0ff" -fill "#404040ff" -font "$fontb" -pointsize 18 label:2 -shave x4 -background "#c0c0c0ff" -gravity center -extent 18x24-1 resources/gfx/maps/font2_0.png
convert -strip -background "#c0c0c0ff" -fill "#404040ff" -font "$fontb" -pointsize 18 label:3 -shave x4 -background "#c0c0c0ff" -gravity center -extent 18x24-1 resources/gfx/maps/font3_0.png
convert -strip -background "#c0c0c0ff" -fill "#404040ff" -font "$fontb" -pointsize 18 label:4 -shave x4 -background "#c0c0c0ff" -gravity center -extent 18x24-1 resources/gfx/maps/font4_0.png
convert -strip -background "#c0c0c0ff" -fill "#404040ff" -font "$fontb" -pointsize 18 label:5 -shave x4 -background "#c0c0c0ff" -gravity center -extent 18x24-1 resources/gfx/maps/font5_0.png
convert -strip -background "#c0c0c0ff" -fill "#404040ff" -font "$fontb" -pointsize 18 label:6 -shave x4 -background "#c0c0c0ff" -gravity center -extent 18x24-1 resources/gfx/maps/font6_0.png
convert -strip -background "#c0c0c0ff" -fill "#404040ff" -font "$fontb" -pointsize 18 label:7 -shave x4 -background "#c0c0c0ff" -gravity center -extent 18x24-1 resources/gfx/maps/font7_0.png
convert -strip -background "#c0c0c0ff" -fill "#404040ff" -font "$fontb" -pointsize 18 label:8 -shave x4 -background "#c0c0c0ff" -gravity center -extent 18x24-1 resources/gfx/maps/font8_0.png
convert -strip -background "#c0c0c0ff" -fill "#404040ff" -font "$fontb" -pointsize 18 label:9 -shave x4 -background "#c0c0c0ff" -gravity center -extent 18x24-1 resources/gfx/maps/font9_0.png
convert -strip -background "#c0c0c0ff" -fill "#404040ff" -font "$fontb" -pointsize 14 label:/ -shave x4 -background "#c0c0c0ff" -gravity center -extent 18x24-1-1 resources/gfx/maps/font10_0.png

# studio logo
convert -strip -brightness-contrast -10 resources/gfx/sprites/intro.png resources/gfx/sprites/intro_9.png
convert -strip -brightness-contrast -20 resources/gfx/sprites/intro.png resources/gfx/sprites/intro_8.png
convert -strip -brightness-contrast -30 resources/gfx/sprites/intro.png resources/gfx/sprites/intro_7.png
convert -strip -brightness-contrast -40 resources/gfx/sprites/intro.png resources/gfx/sprites/intro_6.png
convert -strip -brightness-contrast -50 resources/gfx/sprites/intro.png resources/gfx/sprites/intro_5.png
convert -strip -brightness-contrast -60 resources/gfx/sprites/intro.png resources/gfx/sprites/intro_4.png
convert -strip -brightness-contrast -70 resources/gfx/sprites/intro.png resources/gfx/sprites/intro_3.png
convert -strip -brightness-contrast -80 resources/gfx/sprites/intro.png resources/gfx/sprites/intro_2.png
convert -strip -brightness-contrast -90 resources/gfx/sprites/intro.png resources/gfx/sprites/intro_1.png

# n64 logo
convert -strip -brightness-contrast -10 resources/gfx/sprites/n64.png resources/gfx/sprites/n64_9.png
convert -strip -brightness-contrast -20 resources/gfx/sprites/n64.png resources/gfx/sprites/n64_8.png
convert -strip -brightness-contrast -30 resources/gfx/sprites/n64.png resources/gfx/sprites/n64_7.png
convert -strip -brightness-contrast -40 resources/gfx/sprites/n64.png resources/gfx/sprites/n64_6.png
convert -strip -brightness-contrast -50 resources/gfx/sprites/n64.png resources/gfx/sprites/n64_5.png
convert -strip -brightness-contrast -60 resources/gfx/sprites/n64.png resources/gfx/sprites/n64_4.png
convert -strip -brightness-contrast -70 resources/gfx/sprites/n64.png resources/gfx/sprites/n64_3.png
convert -strip -brightness-contrast -80 resources/gfx/sprites/n64.png resources/gfx/sprites/n64_2.png
convert -strip -brightness-contrast -90 resources/gfx/sprites/n64.png resources/gfx/sprites/n64_1.png
