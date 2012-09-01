all:
	valac --save-temps -v --thread --pkg gio-2.0 --pkg sdl-image --pkg sdl --pkg sdl-gfx --pkg sdl-ttf --pkg gee-1.0 -X -lSDL_image -X -lSDL_gfx -X -lSDL_ttf -o synergia main.vala connect_window.vala net.vala events.vala status_window.vala player.vala character.vala map.vala chunk.vala tile.vala ui/*.vala
