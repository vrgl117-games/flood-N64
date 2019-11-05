# Flood for Nintendo 64

Flood game for N64.

Inspired by [Open Flood](https://github.com/GunshipPenguin/open_flood) game created
by [Rhys Rustad-Elliott](www.rhysre.net).

Support 1 player and Rumble Pak.

![new_game](./misc/new_game.png?raw=true)
![game](./misc/game.png?raw=true)
![credits](./misc/credits.png?raw=true)

## Note

This ROM file has been tested to work on real Nintendo 64 hardware using the
[EverDrive-64 by krikzz](http://krikzz.com/). It should also work with
[64drive by retroactive](http://64drive.retroactive.be/).

This ROM file is only known to work on low-level, high-accuracy Nintendo 64
emulators such as [CEN64](https://cen64.com/) or [MAME](http://mamedev.org/)
due to the use of [libdragon](https://dragonminded.com/n64dev/libdragon/)
instead of the proprietary SDK used by official licensed Nintendo software.

## Building

### Using Docker

All development can be done using Docker. It's the easiest way to build the ROM on Windows and MacOS.

 * Install [Docker](https://docker.com)
 * Run `make` to produce the `Flood-64.z64` ROM file.

 ### On linux

* Install [libdragon development toolchain](https://github.com/DragonMinded/libdragon)
* Run `make Flood-64.z64` to produce the `Flood-64.z64` ROM file.


## Thanks

* Thanks to [Jennifer Taylor](https://github.com/DragonMinded) for libdragon.
* Thanks to [conker64](https://github.com/conker64) and the [#n64dev](irc://irc.efnet.org/#n64dev) IRC community for their help.
* Thanks to [Christopher Bonhage](https://github.com/meeq) for his work on [FlappyBird-N64](https://github.com/meeq/FlappyBird-N64).