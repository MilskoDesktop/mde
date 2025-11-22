#!/bin/sh
format() {
	echo "-- $1"
	cd $1
	clang-format --verbose -i `find $2 -name "*.c" -or -name "*.h"`
	cd ..
}

format mdebase "mdm milkwm mpanel"
format mdelibs "audio core include"
format mdeutils "mbiff mauplay"
