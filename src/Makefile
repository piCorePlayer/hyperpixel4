SRC   =  hyperpixel4-init.c minimal_gpio.c

OBJ   =  $(SRC:.c=.o)

all:     hp4-init dtbo

hp4-init:   $(OBJ)
	$Q echo [Link]
	$Q $(CC) -o $@ $(OBJ) $(LDFLAGS) $(LIBS)
	strip --strip-unneeded hp4-init

.c.o:
	$Q echo [Compile] $<
	$Q $(CC) -c $(CFLAGS) $< -o $@

dtbo:
	$Q echo [dtbo]
	dtc -I dts -O dtb -o hyperpixel4.dtbo hyperpixel4.dts

clean:
	rm *.o hp4-init *.dtbo
