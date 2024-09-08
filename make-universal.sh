#! /bin/bash

if [ -z "$CONFIGURATION" ]; then
    CONFIGURATION=Release
fi

INTEL=dependencies-macos-intel-$CONFIGURATION
SILICON=dependencies-macos-silicon-$CONFIGURATION

cp -r $SILICON/include ./
mkdir lib

combine() {
    lipo -create $SILICON/lib/$1 $INTEL/lib/$1 -output lib/$1
}

combine_all() {
    for LIB in $LIBS; do
        (cd ../../ && combine $LIB)
    done
}
copy_all() {
    for LIB in $LIBS; do
        cp -av $LIB ../../lib/
    done
}

(cd $SILICON/lib && LIBS=*.a combine_all)
(cd $SILICON/lib && LIBS=*.dylib combine_all)

(cd $SILICON/lib && LIBS=*.framework copy_all)