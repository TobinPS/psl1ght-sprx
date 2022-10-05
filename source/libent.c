#include <stdint.h>
#include <stdio.h>
//#include <ppu-lv2.h>

#include "opd.h"
typedef struct _scelibent_common { // size is 0x10
	unsigned char size;
	unsigned char auxattribute;
	unsigned short version;
	unsigned short attribute;
	unsigned short nfunc;
	unsigned short nvar;
	unsigned short ntls;
	unsigned char hashinfo;
	unsigned char hashinfotls;
	unsigned char reserved;
	unsigned char nidaltsets;
} sceKernelLibraryEntryTable_common;

typedef struct _scelibent_1C { // size is 0x1C
	sceKernelLibraryEntryTable_common c;
        const void *libname;
	const void *nid_table;
	const void *entry_table;
} sceKernelLibraryEntryTable_1C;

static const uint32_t exportNidTable[] __attribute__((aligned(0),section(".rodata.sceResident.nidTable#"),unused)) = {
    0xbc9a0086, //module_start,
    0xab779874 //module_stop
};

void _ppu_led_test();
void _ppu_exit_thread();
void _ppu_exit_process();
void _ppu_exit_process();

int test_entry_func() {
        //_ppu_led_test();
        //_ppu_exit_thread();
        _ppu_exit_process();
        return 0; //SYS_PRX_RESIDENT
}

int test_entry_stop() {
        //_ppu_led_test();
        //_ppu_exit_thread();
        //_ppu_exit_process();
        return 0; //SYS_PRX_RESIDENT
}


extern uint8_t bss_stub_data[256];

__attribute__((aligned(0),section(".opd.text_entry_start"),unused))
struct opd_s test_entry_func_opd = { test_entry_func,  &bss_stub_data };
__attribute__((aligned(0),section(".opd.text_entry_stop"),unused))
struct opd_s text_entry_stop_opd = { test_entry_stop,  &bss_stub_data };




static const void* exportEntryTable[] __attribute__((aligned(4),section(".rodata.sceResident.exportTable#"),unused)) = {
   &test_entry_func_opd,
   &text_entry_stop_opd
};



static const sceKernelLibraryEntryTable_1C libent_table                              
       __attribute__((aligned(0), section(".lib.ent"),unused)) = 
        {
                {
        sizeof(sceKernelLibraryEntryTable_1C),
        0,
        0,
        32768, ///xx what should attribute be?
        2, //nfunc
        1, //var
        0,
        0,
        0,
        0,
        0},
        NULL, &exportNidTable, &exportEntryTable
        };
