/*
** EPITECH PROJECT, 2020
** main
** File description:
** test
*/
#include <SFML/Audio.h>
#include <SFML/Graphics.h>
#define EXIT_FAILURE 84;
#define EXIT_SUCCESS 0;

void move_text(sfText *text, int x, int y)
{
    sfVector2f pos={x, y};
    sfText_move(text, pos);
}

void resize_sprite(sfSprite *sprite, int width, int height)
{
    sfVector2f pos={width, height};
    sfSprite_setScale(sprite, pos);
}

sfText *load_text(char *text_content, int x, int y, sfFont *font)
{
    sfText *text;
    text = sfText_create();
    sfText_setString(text, text_content);
    sfText_setFont(text, font);
    sfText_setColor(text, sfBlack);
    sfText_setCharacterSize(text, 40);
    move_text(text, x, y);
    return text;
}

int main()
{
    sfVideoMode mode = {760, 700, 32};
    sfRenderWindow* window;
    sfTexture *texture;
    sfSprite *sprite;
    sfFont *font;
    sfText *text;
    sfText *music_title;
    sfText *music_description;
    sfText *font_title;
    sfMusic *music;
    sfEvent event;
    /* Create the main window */
    window = sfRenderWindow_create(mode, "SFML window", sfResize | sfClose, NULL);
    if (!window) {
        return EXIT_FAILURE;
    }
    /* Load a sprite to display */
    texture = sfTexture_createFromFile("media/img/test.png", NULL);
    if (!texture) {
        return EXIT_FAILURE;
    }
    sprite = sfSprite_create();
    sfSprite_setTexture(sprite, texture, sfTrue);
    resize_sprite(sprite, 1, 1);
    /* Create a graphical text to display */
    font = sfFont_createFromFile("media/font/Milkshake.ttf");
    if (!font) {
        return EXIT_FAILURE;
    }
    text = load_text("Hello Csfml", 0, 0, font);
    music_title = load_text("Music Title:", 0, 40, font);
    music_description = load_text("Winter Fantasy Music - Snowflake Lullaby", 20, 80, font);
    font_title = load_text("Font Title: Milkshake",0,130,font);
    /* Load a music to play */
    music = sfMusic_createFromFile("media/audio/Winter-Fantasy-Music-Snowflake-Lullaby-NCM-No-Copyright-Music.ogg");
    if (!music) {
        return EXIT_FAILURE;
    }
    /* Play the music */
    sfMusic_play(music);
    /* Start the game loop */
    while (sfRenderWindow_isOpen(window)) {
        /* Process events */
        while (sfRenderWindow_pollEvent(window, &event)) {
            /* Close window : exit */
            if (event.type == sfEvtClosed) {
                sfRenderWindow_close(window);
            }
        }
        /* Clear the screen */
        sfRenderWindow_clear(window, sfBlack);
        /* Draw the sprite */
        sfRenderWindow_drawSprite(window, sprite, NULL);
        /* Draw the text */
        sfRenderWindow_drawText(window, text, NULL);
        sfRenderWindow_drawText(window, music_title, NULL);
        sfRenderWindow_drawText(window, music_description, NULL);
        sfRenderWindow_drawText(window, font_title, NULL);
        /* Update the window */
        sfRenderWindow_display(window);
    }
    /* Cleanup resources */
    sfMusic_destroy(music);
    sfText_destroy(text);
    sfFont_destroy(font);
    sfSprite_destroy(sprite);
    sfTexture_destroy(texture);
    sfRenderWindow_destroy(window);
    return EXIT_SUCCESS;
}
