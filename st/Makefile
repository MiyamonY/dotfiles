.PHONY: build install clean

all: build install

build:
	makepkg -f

install:
	sudo pacman -U st-0.9-4-x86_64.pkg.tar.zst

clean:
	$(RM) -rf src st* config.def.h pkg
