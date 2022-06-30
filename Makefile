LEVEL_SRC=\
   level.0.svg \
   level.1.svg \
   level.2.svg \
   level.3.svg \
   level.4.svg \
   level.5.svg \
   #End

LDATA := $(patsubst %.svg, %.data, $(LEVEL_SRC))
LPLAY := $(patsubst %, -l %, $(LDATA))

CHIP_PATH := +chipmunk

# boot
all: run-opt

run-int: rolling_moon.ml $(LDATA)
	ocaml -w -6 $< $(LPLAY)

run-bin: rolling_moon.bin $(LDATA)
	./$< $(LPLAY)

run-opt: rolling_moon.opt $(LDATA)
	./$< $(LPLAY)

# levels
edit:
	inkscape $(LEVEL_SRC)

level:  $(LDATA)
%.data: %.svg
	sh mk_level_data.sh $< $@

# compilations
bin: rolling_moon.bin
opt: rolling_moon.opt

rolling_moon_.ml: rolling_moon.ml
	sed -e 's|^#.*$$||g' $< > $@

rolling_moon.bin: rolling_moon_.ml
	ocamlc  \
	  -I $(CHIP_PATH) chipmunk.cma  \
	  -I +glMLite GL.cma Glu.cma Glut.cma  \
	  jpeg_loader.cma \
	  $< -o $@

rolling_moon.opt: rolling_moon_.ml
	ocamlopt  \
	  -I $(CHIP_PATH) chipmunk.cmxa  \
	  -I +glMLite GL.cmxa Glu.cmxa Glut.cmxa  \
	  jpeg_loader.cmxa \
	  $< -o $@

# clean
clean:
	$(RM) *~ *.cm[iox] *.o *.bin *.opt *.data rolling_moon_.ml

# tarball
VERSION=`date --iso`
DIR=rolling_moon-$(VERSION)
FILES=\
     README.html \
     Makefile \
     mk_level_data.ml \
     mk_level_data.sh \
     rolling_moon.ml \
     tex-b-64.jpg \
     best-times.txt \
     $(LEVEL_SRC)


pack: $(FILES)
	if [ ! -d $(DIR) ]; then mkdir $(DIR); fi
	cp $(FILES) $(DIR)/
	mv LICENSE.txt $(DIR)/
	tar cf $(DIR).tar  $(DIR)/
	if [ -f $(DIR).tar.bz2 ]; then rm -f $(DIR).tar.bz2 ; fi
	bzip2 -9  $(DIR).tar
	ls -lh  $(DIR).tar.bz2

