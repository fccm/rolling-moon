# The Rolling-Moon

## Dependences

To play this game you need the ocaml-chipmunk bindings version 0.04.2:

http://decapode314.free.fr/ocaml/chipmunk/downloads/ocaml-chipmunk-0.04.2.tar.gz

(Don't take a more recent version, the API is not compatible anymore.)

And the graphics rendering is made through the ocaml-opengl bindings glMLite:

http://decapode314.free.fr/ocaml/GL/

The path set in `rolling_moon.ml` expect that these 2 dependencies are
installed in `/tmp`, if you put it in another directory, then change the
path set with `#directory` in `rolling_moon.ml`.


## Launch the game

Just run the command `make run-int` which will run the game.


## How to play

Use the left and right arrows to rotate the level which makes move the avatar ball.
The goal is to touch all the target green circles of the level.

While playing you can make pauses with the 'P' key, and you can restart
the level with the 'Z' key, or go to the next level with 'N'.

You can also access the commands with a right clic in the window.


## Command line arguments
```
     -l  --level        level.data file (several ones can be given)
     -t  --texture      texture jpeg image
     -r  --resolution   size of the window, for exemple "640x480" (the default)
     -w  --wireframe    minimal rendering for slow machines
     -b  --no-bg        in textured mode, only fills the level,
                        but not the background (for Mesa users)
```

## Designing New Levels

Creating new levels is not very difficult. You can use the SVG editor
Inkscape to create levels in WYSIWYG. The easiest way is probably to edit
an existing one, and to modify it, then save it.
Then convert the SVG source in binary level data with:
```
  sh mk_level_data.sh level.x.svg level.x.data
```

Then just load it in the game with:
```
  ocaml -w -6 rolling_moon.ml -l level.x.data
```

If you prefer to create one from scratch, here is how to do: you need to
add a `class` argument to the element to tell its type. You can do so in
the XML editor of Inkscape. For the avatar (at its initial position) add
`class="avatar"`.
For level parts add `class="level"`, for the targets add `class="target"`.

For the level paths it need to be not closed, and bezier curves are not
recognised yet.

If the tesselation of paths that are inside another path is not as expected,
you may need to use "path > invert" in the Inkscape menu, with the related
path selected.


## Sharing Your Levels

Send them to me `<monnier.florent (at) gmail.com>` and I will include these.


## Inspiration

Rolling-Moon is inspired by the SNES game "On The Ball" (its japaneese name
was "CamelTry").

If you are interested you can see a video of "On The Ball" on youtube here:

http://fr.youtube.com/watch?v=CHS00nAgdk4

Have Fun!
