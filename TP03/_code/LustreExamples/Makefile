FILE=edge.lus
NODE=edge
OUTPUTNAME=`basename $(FILE) .lus`_$(NODE)

all:  demo

#for interactive stdin/stdout output
demostd: $(FILE)
	lus2c $(FILE) $(NODE) -loop
	gcc -o $(OUTPUTNAME) $(NODE).c $(NODE)_loop.c 

#for luciole test.
demo: $(FILE)
	luciole $(FILE) $(NODE)

clean:
	rm -f *.o *~ *.oc *.ec $(NODE).c $(NODE).h *_loop.c $(OUTPUTNAME) *.atg
