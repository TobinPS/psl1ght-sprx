ppu-gcc -r source/libent.c -I $PSL1GHT/ppu/include/ -ffunction-sections -fdata-sections -nodefaultlibs -nostdlib -fPIC -fPIE -c -o objs/libent.o
ppu-gcc -r source/libent.s -I $PSL1GHT/ppu/include/ -ffunction-sections -fdata-sections -nodefaultlibs -nostdlib -fPIC -fPIE -c -o objs/libent_s.o
ppu-gcc -r source/modinfo.c -I $PSL1GHT/ppu/include/ -ffunction-sections -fdata-sections -nodefaultlibs -nostdlib -fPIC -fPIE -c -o objs/modinfo.o
ppu-gcc -r source/modinfo.s -I $PSL1GHT/ppu/include/ -ffunction-sections -fdata-sections -nodefaultlibs -nostdlib -fPIC -fPIE -c -o objs/modinfo_s.o

ppu-gcc -ffunction-sections -fdata-sections -nodefaultlibs -nostdlib -fPIC -fPIE -T crt/lv2.ld objs/*.o -o test.prx

#possibly dangerous hacks
printf '\x66' | dd of=test.prx bs=1 seek=7 count=1 conv=notrunc #change processor type
printf '\xff\xa4' | dd of=test.prx bs=1 seek=16 count=2 conv=notrunc #change to prx type
printf '\x00\x00\x00' | dd of=test.prx bs=1 seek=29 count=3 conv=notrunc #null entry point
printf '\x01' | dd of=test.prx bs=1 seek=48 count=1 conv=notrunc #attributes 0x10000
scetool -0 SELF -2 00 -3 1010000001000003 -4 01000002 -5 APP  -A 0001000000000000 -e test.prx test.sprx

ppu-readelf -h test.prx